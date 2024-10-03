import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../controller/companies_cubit/companies_cubit.dart';
import 'offers_grid_view_item.dart';

class OffersGridView extends StatelessWidget {
  const OffersGridView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompaniesCubit, CompaniesState>(
      builder: (context, state) {
        if (state is CompaniesSuccess) {
          return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.companies!.length,
              clipBehavior: Clip.none,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:
                MediaQuery.of(context).orientation.index == 0 ? 2 : 3,
                childAspectRatio: 1.4,
                mainAxisSpacing: 55,
                crossAxisSpacing: 0.0,
              ),
              itemBuilder: (context, index) {
                return Center(
                    child: Skeletonizer(
                      enabled: state is CompaniesLoading,
                      child: OffersGridViewItem(
                        companiesEntity: state.companies![index],
                      ),
                    ));
              });
        }else{
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
