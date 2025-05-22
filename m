Return-Path: <linux-edac+bounces-3991-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04795AC1023
	for <lists+linux-edac@lfdr.de>; Thu, 22 May 2025 17:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36B081BA636C
	for <lists+linux-edac@lfdr.de>; Thu, 22 May 2025 15:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264DC29992E;
	Thu, 22 May 2025 15:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tybGgMXC"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A318299945;
	Thu, 22 May 2025 15:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747928491; cv=fail; b=FlRNLUVE868uDcWlqptNELEgCA7iIprSJ42Le7GpUyObw2LGDJMZtOHt6u4w4CJvhHFV1krby5llE8flD++7bmlwJ7jbgIPSG4/IGiXMrU1acgHNDU6w9AktXkzim2xmrFHyVaw2ZaEEWqKXlsYvboa1YejqPfW4KLzwUWFnvWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747928491; c=relaxed/simple;
	bh=Rtr+EWcOcsEPy362uLke/IWsVJTs5D6KKrI1wwkXg5A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T6vOGbSn8xeyd2O9iqiOFkz+K5KOgKNPaMI8QVzATL7Jo2xgu0huMY8ibBVyBf44+zQcHsxBVS+MTVuBVXidhUAAUNuQkpHzrX5Kl6o6TPNPMc17pLjT8o9iFhgksSXvnjjaM8voA1JRw0eucip4HFshCq9VFTuP+SbWrrQmM8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tybGgMXC; arc=fail smtp.client-ip=40.107.92.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RB8XDmnV1IQBGvnD/MLFlK40kDoP5Ttjv/4H1k6cnd6XXg0eLwYWo6WvKSbLTmTRNvv4IcoxxVO71u/TmfAUdS2Ztqy1GnDBPfAzM4ZAy6Vg2mM/c700gBM/qtGcJDtwBTJxsIMODAqsFN8PUtkq3tkJAhhN7esSf71BhpM9u216S+3fhaMOCtx3phGVFvMT8ysBJOM3UBfMNjnDguVRCefcXZ39O7kw9w65Zu+hfdP066GOl083RehjsuOavpyC5UFs3Q707VxcFO83iw7TXRmIKXxwXpop2pXmS2aLZvPa6ny0hxAvBSBviohcUhTL5K9l/TPYQgO3dfSpAlnH/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J90Vxuij0YMW3XLdgqnDxIWKdLjTwXL/q8Il55+GZH4=;
 b=ZU6ojXdUfHgz4atuM7tjYJH8kAwC7oFAL6BH3WlqoZTOGDP9RECeF9ZhXDcop/6BloN2x/+V+NeEV4Ob1Z9mvSOs4wE4JOBCouO9pmzWWyK5CXiQ5pmoovp8QUuhojYjH40s+BkYjDULD9bH97rb9c+eLIfbaKiuShqPfVo9i5ovdJe0e5ObSV4SGzmVYOs9rS2CQSAr4txfXT8luw0NQpOldgGmsZWN8FlfQnj+ze8N5/M7M3v11lnSH+AisCPpBfRGbfMiWnzmy4kvJdBZG8rj++pGSkF78DcrdrN7qi1MYl7Zx2TxU45jOPFS0g6szW79+1OsPkP1VRCZBiQ21Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J90Vxuij0YMW3XLdgqnDxIWKdLjTwXL/q8Il55+GZH4=;
 b=tybGgMXCF7w1947gem6QueEPoqnMqXilF2SFupjaoEAu2qRsbrumIdRxid+XHHXV5Zcgb7v7B6yYVFduAQKdmyx+it99Q6IDZcBRxdk8Y41Nal02M9K/1Mn4Aqyk7UAUZQxqQm+uiVNhJ+RiSvzFVrUcY1PO/N95jwVCX/LNZQKNn6akMU9SW/Z5manq4T81SylOuDgzJFrtvr7+ZbgKLl1IVIUD+U8q6xSAYV1dy724rkcMnuPHkbrcYbUHnKDG88yJaVVb6JohNDuaIg2H+LmE0lqKdoCREs2lM4k30n49grACCDB/2iFdTBe5JKmSiOj25xshbhJrhzyGm4sweQ==
Received: from PH7PR12MB5902.namprd12.prod.outlook.com (2603:10b6:510:1d6::8)
 by DM4PR12MB6136.namprd12.prod.outlook.com (2603:10b6:8:a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Thu, 22 May
 2025 15:41:24 +0000
Received: from PH7PR12MB5902.namprd12.prod.outlook.com
 ([fe80::f62:33c5:301d:edf0]) by PH7PR12MB5902.namprd12.prod.outlook.com
 ([fe80::f62:33c5:301d:edf0%6]) with mapi id 15.20.8699.019; Thu, 22 May 2025
 15:41:24 +0000
From: David Thompson <davthompson@nvidia.com>
To: Shravan Ramani <shravankr@nvidia.com>, "bp@alien8.de" <bp@alien8.de>,
	"tony.luck@intel.com" <tony.luck@intel.com>, "james.morse@arm.com"
	<james.morse@arm.com>, "mchehab@kernel.org" <mchehab@kernel.org>,
	"rric@kernel.org" <rric@kernel.org>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] EDAC/bluefield: dont use bluefield_edac_readl result on
 error
Thread-Topic: [PATCH] EDAC/bluefield: dont use bluefield_edac_readl result on
 error
Thread-Index: AQHbmE9uJXp3YV+iwkat2ps3a7z6d7PfLulQ
Date: Thu, 22 May 2025 15:41:23 +0000
Message-ID:
 <PH7PR12MB590226280DF463501FA9D0F8C799A@PH7PR12MB5902.namprd12.prod.outlook.com>
References: <20250318214747.12271-1-davthompson@nvidia.com>
In-Reply-To: <20250318214747.12271-1-davthompson@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5902:EE_|DM4PR12MB6136:EE_
x-ms-office365-filtering-correlation-id: ac2a134a-9f58-4e40-0478-08dd99471b89
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?+dctQZwAIZvt7k8gZnVQgceY2HSH3mha+JIzeBsw7Bn8gI07ogcyNUEmRkTa?=
 =?us-ascii?Q?xOWzdutQtQiMK5KcD9uSAjPMzM3peZa2gXgcvZ88O26u5DYynE7fXOdH6TJQ?=
 =?us-ascii?Q?kELYuyFss1tM0HSenQivO2WyccpRRSSWjKHW+0pNxGhWAIpta/0v71ZQ6I+g?=
 =?us-ascii?Q?NZHzstwqK/pSaRJmjV9kCgwOAxR7MvXx3WEhDRO/ewWSgE1Z1+0F3+8cDn1Z?=
 =?us-ascii?Q?4SB+0xItyNlTmdcvYfm1wurXWtctCb2DhbwHPpP9pWI3pB5wx6wZxZgNIRKR?=
 =?us-ascii?Q?xOBVocJz8D8CIQ1avQChnTbWToSinsLrELxYG4wAyV/U5k0txU9fQvOrC/4A?=
 =?us-ascii?Q?rC6ynVVelVxGhdAefDlNMTg9XFoqcrTnfzlplYnqkZQn2Naz1du5TTRdvX2r?=
 =?us-ascii?Q?qtRX5dWRYHwE6ItuMY12T1vffUyQRCtLVNQJy/T0EIUbTB6m0z9Qeu76ywuq?=
 =?us-ascii?Q?5jDPRkRYObi56YUn8Er0LHNYwfyvYfHZaRLaMpwHcdk9SZ2NRiKZbf8F2zSy?=
 =?us-ascii?Q?xbUfv8hzptd/EsqsBgCBRd1QRqJHwtdjMdTaQYTGxdoX5csmR7I6GJ0l/qhY?=
 =?us-ascii?Q?q3j3P15orHS/0G+aF0yqQXQ/8OcpCKAlYJ1zwsuRUDErZJT1bpFwRXS4jXjU?=
 =?us-ascii?Q?FrsEZnZUOktdtn1fHQHL6QhChyIdHnRICVc6GXF/++vY10nWR4KLfjSK63EV?=
 =?us-ascii?Q?Xop4wrW0wkbJIZwNtAyb5GRimoJWCmpoh8Iy9XRSAhEqizdXqpUvOjtSdOfi?=
 =?us-ascii?Q?xgWKD7DhDQzfHOnSQ2Qe3/hyBK4GfzXzmgxtF92uDdQe41iHOoJdQtFuTtlZ?=
 =?us-ascii?Q?Mqm6jAqYMBJS2TGrOKCZNAM9Wub83UZ0Dvp2SavKACitoiEPdkGrGVT5WWC3?=
 =?us-ascii?Q?pTj4Gdy8Q8yMnPSaHGypj/Ubp9TOLj3Xts3dFZq5nWP3lgqvN6yJtGC5BMBw?=
 =?us-ascii?Q?hJMo+wuojDXu0OaGu2NAPkmVI4QgdOxpmmUd4Ecy4QKnLid3n1oFN9bsICD+?=
 =?us-ascii?Q?QR6ofY0iE4Nci9SOxm95IBv0plGMrRIoHgGt9BmrxCl01uM3q6VJV1D68aN2?=
 =?us-ascii?Q?D9KVc4k54vTbCY4QOr/bHR/oTt8eA3llwckjEedZOm+1jXg0odtRE/i9E7JW?=
 =?us-ascii?Q?kdfwNWY7rT+vH+k/YRo1+DvnQhX03q4gpLFF9APBWsyEfzQPwlphj3CwucWa?=
 =?us-ascii?Q?SBLF1N8vgd6Nqdu7LdmedwMBl/UTT1UH88qTMLBQUomeRA4lyVPNqaIE7vjA?=
 =?us-ascii?Q?wdD7J/zrUZ9nUTjF1P0wy1mNByjHH65nvUsJ2WN8cXYrwhOsMt0+CcF9gSBV?=
 =?us-ascii?Q?h9lpJssNgT+yycePpN/rUXIxfeyRvcLpXRyVgwQ/IL7BYRlbH+hp+PbO569q?=
 =?us-ascii?Q?8bHu47eVUu2ihyozVc71aj27GmYkZOn3K/OspuE6xiStjzlTljP4d8gbI3IS?=
 =?us-ascii?Q?uUn3sGSnkQD3JwK5ySbw4TLqcID3vMWkaw+fp3siIPqwlFnwHneYTQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5902.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Nm2f8Di6MJZkmCjOpx1l0eHH4fU7k90OPcsXnTwYawJI0hsudNSuD7vxwhKW?=
 =?us-ascii?Q?AWoKejSrtgsgJyeLOwmqVdZMxLtbTKvmoAv1sEjvF+txZ7FwGqbSkgjQ/iVG?=
 =?us-ascii?Q?gbqh4P2U7wUMngwMPdQge676iBNdDVBVmiSYhtMfXLnAbYAFamf+K9LsI6sv?=
 =?us-ascii?Q?09jE4SLAQhp6RVTzNtCcp/LkM1POKr27C+88/KIep3pC0kA1UCpDDEh9y4lA?=
 =?us-ascii?Q?TJUd1hSq3afNB7UYs8GOL3hmg8xyxJZ9VoRJo9JexYsCgb9RU1oQF/noTxm3?=
 =?us-ascii?Q?jIQsKpAP3EN6X+Gv6gXBmfUNd86FSZWuRAsJl04YEvigy6XqHbIjFuzrGf+F?=
 =?us-ascii?Q?+7aU61/XubVIbwpgxW99h7Jc447yIuN8y1X8dtQI2xn+kW9hMzQsJ9KjRj2e?=
 =?us-ascii?Q?+OVMZo1mUImVTOawIDgoxnKM8hBL/5/8wMHRy7mEFp/p5w8B2qQUBeGQvb0Z?=
 =?us-ascii?Q?GNlGid0KaZhqSltMjGGlIKJ/vArjqCqQ7Neme+M7YPvOhqpDEjML0voi4KFg?=
 =?us-ascii?Q?HwJKAZE6N1oHTzGF19V8VBpFC5qzhAJaKXUNhib3VabBlVM4oOLms9zxyEZf?=
 =?us-ascii?Q?Ke1cCtMN/PCzT5hren5eXVn5G4Zo2YoEUWPrxaYhvfnjBWOp7EuADSKRthRA?=
 =?us-ascii?Q?YJ88GtjSzPMNbdLHRFzYiIwkhm92iomes52/h+IID8Y7tebKvtjq4S4o+BR2?=
 =?us-ascii?Q?gntPRgKtsH8PFZwfFgqcHdScVL84i4XnUrq4qs/F9Md3yi/WHYpvEuxU7OQi?=
 =?us-ascii?Q?Q1JeB9Pwlr8moSW5mYI6cVfh2jJjjA7Vitmcvs05lIKzQROUMxPiUn/+Icvv?=
 =?us-ascii?Q?xnfeK6A5TijkiUUtpOZkTO7tAjF3mhjw02KTSOr1ziE+PO/KfZjJwtJPJ2qF?=
 =?us-ascii?Q?VanMKRfLzxow7oBy5lW0D2pXwzJdlNLwjQYkcAodBH5Or3bouLLj42H2K+je?=
 =?us-ascii?Q?DUHSl/Os//SruljpsiQ+7/Q/djKjbckFicXuCCDVyw/oP4VPjLFoYf1bKB9B?=
 =?us-ascii?Q?RoGWM8xgK/YN3r9vEAlQ2B+KNGHvnRcG3biT2UCFWQ1QpAAHqCXz39nRslAQ?=
 =?us-ascii?Q?ZKzOjBkqrjJUzdc7vEDBXRycHquYdmxx1z+tZtZk549bkDYBXHuuA51Bg+69?=
 =?us-ascii?Q?bGrpkASExy0SeVC+kH0fY1V4t6Cc4vjaRzA9XUvbbP71BMiyZ/hBELyaQV7P?=
 =?us-ascii?Q?2nErTFA5XzG/hIvjrMPSqnyMI+lquFJnUkGnHg5VOiuDfMsEFfyy1aVxr8Sp?=
 =?us-ascii?Q?38Xn0aF7R6FEs1AF6qGDLw/XyO/sdbUucfJe45JFpdSX8wJLaxa4VGilQ8KF?=
 =?us-ascii?Q?v+9pO2IFTgDS6bwenp5Jy0WNDc4HniCs96bp7C+g4pDm5xKFOeobVkN1qmBq?=
 =?us-ascii?Q?76Tc1IDqfECkKH1hwsSX9o99/sIrkh6RKCbG5KYGebIrIqZlQZeeZMtsfVie?=
 =?us-ascii?Q?S7y4+FKItYbSI3ID0lxjNQ44OOglrMLjPfyn5rZpwiiE1CQuA5+kdpjxmjGX?=
 =?us-ascii?Q?mNLD7JW6YsTQM1uQ8lSOJbZE+/7A/gq55oZqXMQ8bfJRazhZOtHapN8WReJ1?=
 =?us-ascii?Q?B8MqhnZBk/xF1gg4b2JYfpGdZgc6gzicnfxmXmAn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5902.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac2a134a-9f58-4e40-0478-08dd99471b89
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2025 15:41:23.9817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R3lRvsNOuYngdnAGZ9Q1PU5zcf4+EHkhHKlq5yWqnYlAVYIkS6DRvcWCQ/+TwAJDQBM8ThRZrcW8j+exdsemhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6136

> -----Original Message-----
> From: David Thompson <davthompson@nvidia.com>
> Sent: Tuesday, March 18, 2025 5:48 PM
> To: Shravan Ramani <shravankr@nvidia.com>; bp@alien8.de;
> tony.luck@intel.com; james.morse@arm.com; mchehab@kernel.org;
> rric@kernel.org
> Cc: linux-edac@vger.kernel.org; linux-kernel@vger.kernel.org; David Thomp=
son
> <davthompson@nvidia.com>
> Subject: [PATCH] EDAC/bluefield: dont use bluefield_edac_readl result on =
error
>=20
> The "bluefield_edac_readl()" routine returns an uninitialized result duri=
ng error
> paths. In those cases the calling routine should not use the uninitialize=
d result.
> The driver should simply log the error, and then return early.
>=20
> Fixes: e41967575474 ("EDAC/bluefield: Use Arm SMC for EMI access on
> BlueField-2")
> Signed-off-by: David Thompson <davthompson@nvidia.com>
> Reviewed-by: Shravan Kumar Ramani <shravankr@nvidia.com>
> ---
>  drivers/edac/bluefield_edac.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
>=20

Refreshing this review...

Does anyone have feedback on this EDAC driver patch?

Thanks, Dave

