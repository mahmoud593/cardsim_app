abstract class CouponsStates {}

class CouponsInitialState extends CouponsStates {}

class GetCouponsLoadingState extends CouponsStates {}
class GetCouponsSuccessState extends CouponsStates {}
class GetCouponsErrorState extends CouponsStates {}

class CreateCouponLoadingState extends CouponsStates {}
class CreateCouponSuccessState extends CouponsStates {}
class CreateCouponErrorState extends CouponsStates {}