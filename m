Return-Path: <linux-edac+bounces-1541-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9D99341B8
	for <lists+linux-edac@lfdr.de>; Wed, 17 Jul 2024 19:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF7131F230AE
	for <lists+linux-edac@lfdr.de>; Wed, 17 Jul 2024 17:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BC9181D07;
	Wed, 17 Jul 2024 17:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ucIlcz63"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0EA182A40;
	Wed, 17 Jul 2024 17:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721238825; cv=fail; b=vCYQntNAeAdx+BmWaSaQIYRj4ex+I8yW33+NTpCApa3M6cHSk5quNF3n5vqRk79fwbqkjBHoS7BP9AGDtwvCXodRg3x30oRnUaQUJHwvrnUF6U57wVLfxtCz9yxM2G1yCN4IqrKRROYlK7BsMYBHJRwF1bQh5dgNPtrzrb67RMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721238825; c=relaxed/simple;
	bh=lQs+B79i+SNlHitVOARATKK9Syhg15PRRbBcY//4W7U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Dy4FcWu7tcOX9fqvK+2/Fx/HalxRdEivMcJjZcIgAJGz0P712enBfj6k6m2ixijdBRLA8UhuxBg55IXcyDZKBh4rEP44egAYWoQh29mYYgw0GfTarcAtNbDxJaw43oyFeZw9kPO5pq1/uK5paXnqmJsb7eVACr/NSoGZuDwNgco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ucIlcz63; arc=fail smtp.client-ip=40.107.223.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ersGCpYARv1zVnnf2DTMK5tyC2sqyJA09eDoANODQ1ulZHvmwoIokbpP96nM8Gr+FIu/7ui6lisfskI5LGf8tUWAR6JFAkL4RjtjOv3u1Eg0kJWjxIlr3EpVil98+EEcpLohnX0JmSuhwdq8mXk2P0mobpL1/OP4MugGx5Q0K4bKbfRkTJmlN5cx4J6X5gU+Y+eZH4uv8YPGMJjt+rP2tgXhze0eo3YXJfPKng3FrCqSlEeqt6mWTRqrIkPsQDFcZpHasie1GS6KhfNMBhAti89F21qz9aTt5HTvt4juLiRKFtN7H3QjdBeZFxhsPLfU5XID0uaHV1t3uEX1JsjcMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FVzcjWsCxofI93B9d6HkbydSW0zW3RC4Q173Y24nM/Q=;
 b=jW7vkRpeIkrvCjpXraPPybRbc/Dc0uPaZrNiYg3TuwAYbj3EHn3XvJfhrVcGq7AKgskUPmEhO0T7SqU8j4RA+S9VlnoA0jP4zkg1BoG0uWgKMPe5XG4iiS19anYd9MHKmaNE7AKSML4pRJEKB609XqOnW8/pYzdY4f7Zu51Wnn1LB254Hlcp9L2g0eBTr/FTv8wwYaY7ikAfaE8oN5VWCNMCMZnFyZKu2uwHV8pqyBG3hY1c4nuG8CY6wXxdsWo4Np2Su5Lser3d3TLvj5nigiI9gVsMLCpavd8cGwTKzNpAUXAbzuW/R/JcNb7dKlnuVr3Nv80p6t8s5LO/QYmD8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FVzcjWsCxofI93B9d6HkbydSW0zW3RC4Q173Y24nM/Q=;
 b=ucIlcz63TChQuqSl+oOphD24yfpNPn1neoNtVe7mHjsKX6nkEydauzXBEsVuEdZGRI0K3dHt8jw9NdIjF+ENuk4tNk9V0HHc4/YhLOiYG6fqww5qWTj1ga6wqh7Rx4H9tRz+fzgu2PpNfSPCtrBj0J6Cf8EgsEso+7J1fFHEtMq36z7sEpAF2f0Y6DC4LgyxxXgKmK+gfAi0c3+VX6PGkeQT0szrzgBld38RW/28Dj3ddnFhFXVtJDJQ0jNGD9CfkEFDjr6tzuqAk2dp8XK2E0lXQg7x+qfiANqi81gF9kbhoC200KgCfFFrX0p+BIHvzOb1IE0Nrai9OIi0CihNZg==
Received: from DM6PR12MB5534.namprd12.prod.outlook.com (2603:10b6:5:20b::9) by
 MN0PR12MB6078.namprd12.prod.outlook.com (2603:10b6:208:3ca::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.25; Wed, 17 Jul 2024 17:53:36 +0000
Received: from DM6PR12MB5534.namprd12.prod.outlook.com
 ([fe80::e3bf:44f8:b0ac:c892]) by DM6PR12MB5534.namprd12.prod.outlook.com
 ([fe80::e3bf:44f8:b0ac:c892%4]) with mapi id 15.20.7784.015; Wed, 17 Jul 2024
 17:53:35 +0000
From: David Thompson <davthompson@nvidia.com>
To: "bp@alien8.de" <bp@alien8.de>, "tony.luck@intel.com"
	<tony.luck@intel.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"mchehab@kernel.org" <mchehab@kernel.org>, "rric@kernel.org"
	<rric@kernel.org>
CC: Shravan Ramani <shravankr@nvidia.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1] EDAC/bluefield - fix potential integer overflow
Thread-Topic: [PATCH v1] EDAC/bluefield - fix potential integer overflow
Thread-Index: AQHavE8DcQoKX9J1akCoAWULvtvss7H7a20w
Date: Wed, 17 Jul 2024 17:53:35 +0000
Message-ID:
 <DM6PR12MB553486995EB0AEC62777CE0AC7A32@DM6PR12MB5534.namprd12.prod.outlook.com>
References: <20240611223017.30988-1-davthompson@nvidia.com>
In-Reply-To: <20240611223017.30988-1-davthompson@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5534:EE_|MN0PR12MB6078:EE_
x-ms-office365-filtering-correlation-id: 64f6cab3-e7c7-4bfb-998d-08dca68961b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?IvHzF2Rs+doco1Nw8kYYsMK9DrAh6c409Nb7cC7WqfVwx0fC8RoFjI998CEq?=
 =?us-ascii?Q?OqH2PBaA9ObX9FQTARHL6glJX23QFwT0fRRKVNurJWN3zXM5OOq6s1SgcY4P?=
 =?us-ascii?Q?GP9tbgBL4vF4N7bVRYj9i/xCwHkx07O7c/4WQA3SVxyzu7/Ta/yBBGAV0hhm?=
 =?us-ascii?Q?Ayy2aeXHEfEiT2Zkz8p01JaJQJdetYUFIs0TcEK5gHMXd0NjWPru+7bHvBT6?=
 =?us-ascii?Q?/edX8djHs+aVRpg7z32kEmjej2ixT+Ty/XFBQoJTo22xvJmzPpcl+5shl5Fw?=
 =?us-ascii?Q?5uA9ODqnj59a2yenleJehilOCGspZFYjqeHwhNaV5afO0WU1IlCN1LzyoFpy?=
 =?us-ascii?Q?dHY3uUxBycNKTo7Vm+AuSlW2qAeDGsL2dMh6ghJ5yBH/qBz+L0LHJ7KtNVg6?=
 =?us-ascii?Q?B2eOq9HgJvAdMf5pewBqEHrvBY5GrQW+0UrDPLt9fsj7XOtm5T/KnElJ4Pj9?=
 =?us-ascii?Q?qA3QUfofVs6XTsk+bYObBR6d4cprTu+6a2utoMmwjGYRnGybcBVphskyY4PX?=
 =?us-ascii?Q?QqJZ/ffngTKzGHQa5FL0oi8RcDaKzxJYgnbKeVrXQLlUfD+I9DFXgPyaEVE4?=
 =?us-ascii?Q?BRLVpeeLJm0gRUONpqeLpGLTETAT44kWYdsK15Kzn7gbg0ywOZYxyLaMuoQL?=
 =?us-ascii?Q?0uDtAcVokrVv6GUp6RiCpuUTZsLxeQ3mAEZLwcWasLYImrNwKFSliuTydSlU?=
 =?us-ascii?Q?VqsjyDTZmJ/hthTf7lxcQjV/Bx0luJuguqEjpeH1JS9HgYvMtyCsL7hO/diB?=
 =?us-ascii?Q?EYXxyvry1XgDBmxYbIMnt50rlMh4IWEIZXnIJmAA+gROC6UqhpkT2MPq6eOL?=
 =?us-ascii?Q?ELEbkKVM6zkSGSz43HETAmrvWBDTZKPuj5VAcMTrdG2aj07eb40olAc/NGb0?=
 =?us-ascii?Q?b6qSzFJlG2V58+yk7UxIcXCdwEstW1y2OsFUtL6+1J7c0xe6KRB7poDD5JQA?=
 =?us-ascii?Q?P4YFjevT18hH2vCWZoNLDjJkEPICSeXxZvcnBUTeYljs+jE8Ha9yT/lwBIf+?=
 =?us-ascii?Q?aYZkWgCKle2ZXSye3jFWsKBib6lYbJW6l17l2gzAHj/D/uG4FeX2H1+NnRXJ?=
 =?us-ascii?Q?9Ox4/PSeyyhczdm95mtE/agXjz+LUqeFGE9HXc5TMjex/Bmyo0mKfhn1VgH8?=
 =?us-ascii?Q?2f99P8ZNfHU5AoA9TU+T/MMSS3RRQSYfcGKNi97ysalAXCfdZytUvI4LvTPt?=
 =?us-ascii?Q?Vcfo6Gbg6IELbJhJKfeShMjyhHwKRDMfAZ603EPtyhzgg34EvRS8C+VAea+R?=
 =?us-ascii?Q?NEMgaA4tsNBt9TMIOr4COuebOkGDOG+X7FaIQTPoqWHo8Y7D8uODf3XOPcUM?=
 =?us-ascii?Q?nMXV6UOosdO4g0GdkEReRU35j7ydJBkGSv/SS0YRAyFj+gxLROdhz5ZeTvyP?=
 =?us-ascii?Q?FvTj9AM9rFAWXpKexPpbEoqx4mXJCYtuWL7rSx97tx9NqRZ7bA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5534.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?EHYvhAMsSMTsO+c8cpKSnOOnzWadfXBUi+pMkF26KLaIW+1MlVYpwjZmMH7M?=
 =?us-ascii?Q?qmJJTr4tdH7gi2fAq7Z0uNewmbMtTFSEjDDOn/vHRLmo0Gww+vjye1IShJdd?=
 =?us-ascii?Q?X+snwN/K12HpDK0GkzNKG542pJ437BnVMQAzKX5YfauyzFEp16MgUIfys+zQ?=
 =?us-ascii?Q?pQShb+MGa1a5ZVfgg5VPviPHVPD9PMnc0nlLJBPw79XzXpzcaMtRPxz3jnBU?=
 =?us-ascii?Q?AZooftM6xOMrU9HZ9nVigIJr35U+gCKG6/Bo/OUmT3woQwQuEdv0HUo8RwU1?=
 =?us-ascii?Q?IVmJrAMO+4I27HlZPy93RsyQhCbTPo5TGjtCA7TGu7ex7uhLqxW/2NnSXGBJ?=
 =?us-ascii?Q?lodH1T8jeWluzzNF2Na7mZvtcdgcceAjjWeBttqbeAFkCvN3WtZ7baupTJ3I?=
 =?us-ascii?Q?Fjf9RIxQV70CSel8tLxmiTXs93CEOI2CYTSbP/EUlThlUvKq3IBitriOW3qX?=
 =?us-ascii?Q?IwwhFUWrQKsxWGyHfizEoLQ9o0s/597CE7GTtyg1U6UOp/BczjLNl5YA3SIJ?=
 =?us-ascii?Q?95DCutTm6nRYoIaWaSYDNsYePTEbzfhVwozALRRP34YSzA9WamNzZnKJ1ZIk?=
 =?us-ascii?Q?4kLkWudPUzIQu+kV8YFZRk1hPmVNOlXrh7qxDaFfa4aQywSN+HakQB4dAral?=
 =?us-ascii?Q?/xO1ENGKGnFwwxND8m5WhlU5EIYyis8/vTU5JJw4RoYtoLu1JGIp6r4dVUxh?=
 =?us-ascii?Q?OmKk66jlTX+IL4/ueeghXK7FkwzQtHElwrhygvZCWs5XoNrL97zd4BtDtlpM?=
 =?us-ascii?Q?jv65flF2CE+Z1vlHToYsBhlJ/4b21D2S+WMcHhJBf0YP/wso9rRc+97+bK7/?=
 =?us-ascii?Q?G3nuoeok9SUowb/jpnFaXeQJkQNOroHEThnCF0582OFpP1NORa+yRfiNIIkW?=
 =?us-ascii?Q?bcZKGhtytzD19f7I6RW1PpkpXguSLwclXTeRIbRz9WtwQd6ojdswbvKSadN3?=
 =?us-ascii?Q?3LQ49FmErRMn3InCW0yLpcM5DlaFrfOw8bDLVmKAkLNa7KGNFNBGQVLF6mk2?=
 =?us-ascii?Q?JzoGTTxBxW/slAmHk5DraTmnXXrG4DI8cjutgntyrOrLBxZnQzLUHCKm1PVk?=
 =?us-ascii?Q?zH+JUGStHMo+QfzusrNx5DE2FJAHHFp2Rh4GhjJRkkZVqRRq7hkqowDEQMG2?=
 =?us-ascii?Q?Ey04VJBjoH4FIYE5AYR87bc3vJRZiPphkAlxwkoqmdSC/5CKSarx6rsTNrMa?=
 =?us-ascii?Q?9o6N9njllrT8IOuYYTLv0U8Jj3t1BB+ZuvncKKeeMBXnA4COIUSAVJANRmpp?=
 =?us-ascii?Q?+2QWghlEiehc2UrtzNgO4JX5vhYDdJVFkWUMeT+XaIIAx8MzMECQEn97CnbR?=
 =?us-ascii?Q?dI4gDHK5AoXL87/84LXGi08hA+oE0LvncJezOKev/zTl+UKbNxYPvSfdhg+v?=
 =?us-ascii?Q?KU8lLRPrCz8O9PPOrbclKk2WSWQK2gBJPMRCGFG7bbogZyDE6NTDTqORhqnP?=
 =?us-ascii?Q?Lso5RMULnWSkk4Y2b5Q02XNpZZ/Mkxqoc7U5UBjcn7+eHVucr7A5JBskeTrG?=
 =?us-ascii?Q?+fYqEaEYpyXd/FcqJwDgw24QMXmEmxwfI/2vNGlOTGwLbeRnOYxfOZc51tVy?=
 =?us-ascii?Q?1h5AGbIsVHJ2inu9NoZOipxOQ+9W+Xj9AKrY59j9?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64f6cab3-e7c7-4bfb-998d-08dca68961b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2024 17:53:35.9378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3QU24ZjeC1z6rS2PIldlX+0dPfoLsfwvzM4w0LmxI2iOGD9At46VPF5HmKrZqa0CIrZJ4C+049oWXH4TEKwghg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6078

> -----Original Message-----
> From: David Thompson <davthompson@nvidia.com>
> Sent: Tuesday, June 11, 2024 6:30 PM
> To: bp@alien8.de; tony.luck@intel.com; james.morse@arm.com;
> mchehab@kernel.org; rric@kernel.org
> Cc: Shravan Ramani <shravankr@nvidia.com>; linux-edac@vger.kernel.org; li=
nux-
> kernel@vger.kernel.org; David Thompson <davthompson@nvidia.com>
> Subject: [PATCH v1] EDAC/bluefield - fix potential integer overflow
>=20
> The 64-bit argument for the "get DIMM info" SMC call consists of "mem_ctr=
l_idx"
> left-shifted 16 bits and OR-ed with DIMM index.
> With "mem_ctrl_idx" defined as 32-bits wide the left-shift operation trun=
cates
> the upper 16 bits of information during the calculation of the SMC argume=
nt. The
> "mem_ctrl_idx" stack variable must be defined as 64-bits wide to prevent =
any
> potential integer overflow, i.e. loss of data from upper 16 bits.
>=20
> Fixes: 82413e562ea6 ("EDAC, mellanox: Add ECC support for BlueField DDR4"=
)
> Reviewed-by: Shravan Kumar Ramani <shravankr@nvidia.com>
> Signed-off-by: David Thompson <davthompson@nvidia.com>
> ---
>  drivers/edac/bluefield_edac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/edac/bluefield_edac.c b/drivers/edac/bluefield_edac.=
c index
> 5b3164560648..0e539c107351 100644
> --- a/drivers/edac/bluefield_edac.c
> +++ b/drivers/edac/bluefield_edac.c
> @@ -180,7 +180,7 @@ static void bluefield_edac_check(struct mem_ctl_info
> *mci)  static void bluefield_edac_init_dimms(struct mem_ctl_info *mci)  {
>  	struct bluefield_edac_priv *priv =3D mci->pvt_info;
> -	int mem_ctrl_idx =3D mci->mc_idx;
> +	u64 mem_ctrl_idx =3D mci->mc_idx;
>  	struct dimm_info *dimm;
>  	u64 smc_info, smc_arg;
>  	int is_empty =3D 1, i;
> --
> 2.30.1

Hello, I'm reaching out to check in on the status of this patch. =20

Please let me know if you have any questions, concerns with
the patch, or have changes you would like me to make.

Thank you for your time.

Regards, Dave

