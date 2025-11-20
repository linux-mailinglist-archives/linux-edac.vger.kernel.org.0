Return-Path: <linux-edac+bounces-5483-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4DAC72392
	for <lists+linux-edac@lfdr.de>; Thu, 20 Nov 2025 06:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F03284E043E
	for <lists+linux-edac@lfdr.de>; Thu, 20 Nov 2025 05:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A704F1E008B;
	Thu, 20 Nov 2025 05:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HhfAAGxy"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CB4BA3D;
	Thu, 20 Nov 2025 05:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763615324; cv=fail; b=F+KdgvFOYTKTBhKvJAHUNtd8Q2j1U+EwwXmCPZ+BgXay0HwockUe8/TdA1y0JobUsaW8nUS3RNA5S6Dwp5EZUD0rzUMg6OdIY1mCLqJzUtDTedhWm/XRUi3xNdDfMJdR/zCXGL08aL7bGCaEOb7qwy2OW40yRtGLRVLMaAWk7bE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763615324; c=relaxed/simple;
	bh=tSxJLx/eFMGso6nUBVO1034ubqoWvcXIZfKMdeuQb2o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AFF3lfrl/5thIvNPmm1b9QU1Qj+KExLddN8+ci/xw3HAgCIE3acb2OUIAwNjBY3UezKlElqUBMaOXfPzxoXsTmQKsbP75rWijG1Aatzm0t1FiVS6jC4HIw1A6C4zeck5TQ7S33PQ2C8i4IZcqpa6LH6urzLY9TFFeSitFUtUyGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HhfAAGxy; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763615322; x=1795151322;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tSxJLx/eFMGso6nUBVO1034ubqoWvcXIZfKMdeuQb2o=;
  b=HhfAAGxy4JJarNUF1ooWq4xiCCg5MTqx+1/Q+2RSl0ggaOZ54v1cWyRr
   gZor8AUTQscPyORWdvojICyA131F7xwfRbJTNQw0ma+xVeIsfNs8lfIar
   RH6I4P/lc66fxForbdoIS2pqg977thBd+Ps+gQcqEgebgqSNXBpcl+GMY
   p7hG9zwdfeMl/QpP9eAIXj2KR1wT+C7KYyuK2VWwYiBgAibWqjgAJoZ53
   FK/Fvus+C/G65FnQ50mjFGFpSosECe+rrVvgQNJ/Ff4l2QBqPvJNXv90y
   blPYAW5rWYJp0VobYjvDTEeA9DkXAnykxLfaI/OnXVsCFBPeveBBNFvUK
   Q==;
X-CSE-ConnectionGUID: A7MhyAZ9SvCHsH0eNPwTmQ==
X-CSE-MsgGUID: SSN+7DvFSIiceJ+Ui5LCrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="65550808"
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="65550808"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 21:08:42 -0800
X-CSE-ConnectionGUID: mngUzzl5QBuMnPcy4B1mGQ==
X-CSE-MsgGUID: s88qFb6uQ3mdXJzBiRctwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="191385669"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 21:08:42 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 19 Nov 2025 21:08:41 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 19 Nov 2025 21:08:41 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.70) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 19 Nov 2025 21:08:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MmTN/IRjf6/eTDZSQDpyGFPUGUgzkLUWndxZcB6YmxZURNoSWVZM2PJtCfc0OJE73p3usgP+XHkKxSx3ZocPdzBIJO2YvSdXQT52V0OFLnASJs/g74Fc3KQr4t67iHj7M8jPaeYgHjswefFTC+imnz1mpoJ8xmg/1Lxp5KDThlSIcpa7tal1dEeBevSbljrO2IVEfkWTej/A1HhQ08EUZ3f7upqNEixuCw9/RnDBnDvK/MQqJmvFPhaZqq4JcfFfwdSGTwk5wLT5WyLrbjKDw3t1upOsqhUaK9iRqKaJcthZv1mOpRUPT60dolTBPvNA3XKzWEIu/meAhzCXz7WgMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tSxJLx/eFMGso6nUBVO1034ubqoWvcXIZfKMdeuQb2o=;
 b=U+conoXb+Vz/jonNFy9t/yE4+nmeSuaR9fyxhbJuiA4+oS0XuIIoG1fXPCRTn7KOEesXUVGTjIrf3b3+8fjdzf2Syp/yA5lYPvAVXV0TLlXQeCyLNjaJB+fIiUspqbPHYfYnSPwe3K/7d4i8I1uEa11D4rvsnevpjKPhYWnbneMkHQ286wmNvd0PIZ7jsKKEM5wWx4K+zsBbYwf/1+kKSgmeojkgokY7VoIvnOAR7OszSMxFXbkPbLARrnnM+N8tUwyFrx/IgTIZDZlRe51xYzFRadQKJrTWhGKOOwGAawn+1rxASsD+jbpJ4pJwaQ1QND2Rw8fLdnpSX8LIksJRTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by CH0PR11MB8142.namprd11.prod.outlook.com (2603:10b6:610:18c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 05:08:39 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::5670:5b2e:6ecb:dcaf]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::5670:5b2e:6ecb:dcaf%4]) with mapi id 15.20.9320.021; Thu, 20 Nov 2025
 05:08:39 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: "Luck, Tony" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
CC: "Lai, Yi1" <yi1.lai@intel.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/7] EDAC: Add Intel Diamond Rapids server support
Thread-Topic: [PATCH 0/7] EDAC: Add Intel Diamond Rapids server support
Thread-Index: AQHcWVsxTtdfmoKPdEe5hxzqLpk4EbT6f9mAgACEnYA=
Date: Thu, 20 Nov 2025 05:08:39 +0000
Message-ID: <CY8PR11MB7134C62CD7FCFFFD973288C789D4A@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20251119134132.2389472-1-qiuxu.zhuo@intel.com>
 <SJ1PR11MB60830D5FFEB9762FEF78DE5DFCD7A@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB60830D5FFEB9762FEF78DE5DFCD7A@SJ1PR11MB6083.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|CH0PR11MB8142:EE_
x-ms-office365-filtering-correlation-id: 369992fa-8441-4bd5-f613-08de27f2de2b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?6RnDq9FTsnEhGB/nm98DznhfEzM5oB98ITM9l86WJ4YRgxzbrfys/a61Yfy5?=
 =?us-ascii?Q?7Zo7mfSwYBGidSzfoFV2vrQwnffwtL9rSI+lsfFb0KGncKsAOrZfsjgllR+z?=
 =?us-ascii?Q?6kv8MwpOYUkhtTOfWwxlHLht/MWR+kAnuweyJfsFqAMW+STQdSftxOn34fni?=
 =?us-ascii?Q?gBXZNieKGde2v4kb5HkCxFNZtod1Esqacsvo9T06tns0xlwwtShmDjpHdmJR?=
 =?us-ascii?Q?M+vETMIgvHguUiK2IYn/ATROGKkR9LZA/KxtZG15Nu3Ni04aZ/pXCuNrmgza?=
 =?us-ascii?Q?eQbH7eE2Z8syPWrnzR408JYFArpKONMywN6TMobGI8/VYLD46noEpzJkPhtB?=
 =?us-ascii?Q?D2jid8LU7QzdpZ1B3T7LAzMW41e4WQ2Mzk+uS8br16bfWDMjhCvi9EpZ1Wz4?=
 =?us-ascii?Q?2oquOtMmWx0Opq5Rfyi815EuGn4sK/BfvOBkGzsBe4rkpiMkgiAm8GQnCWj+?=
 =?us-ascii?Q?vJcGv8b+R0L4dUy0Mqs8BSeE30nWLtge7+BbvrjEJXwX68LaapCFYkBe2D5w?=
 =?us-ascii?Q?FAji7yBhqczcvrMLrS+bz61YPrGkLKcV63huJyCTN0Tybt6tCa51WXQ0SmQF?=
 =?us-ascii?Q?WW9BC+QFADLSJEqKAqLhmeG3UHw4rLi4j5JGgAAKLW8G/CFE8SxGikQ7yVfe?=
 =?us-ascii?Q?4TsNKZO0XiKFrRxw4w3OaSVdgH/4g+lz9CWdYOyPUAPrDt020NgVY+Y15AXJ?=
 =?us-ascii?Q?rKT7FoSuFv4SiahUD+AN+BmI6Ysy2kLxeYCgoZFTFe+4ZRonKa51nNv9RT+n?=
 =?us-ascii?Q?ayPWQRljIgOMEnya4IV/Vvl8MRANEZS2x4h9UEqKn66YpRrOZdqQLaiglM8j?=
 =?us-ascii?Q?gsfkQBuuac6IyFfk1XnIw0VNWqCyv8J6hyVaakjMAo1uBLYlr/qQfophjV3/?=
 =?us-ascii?Q?kEsIZyqp4YpPRgAKV5KKTZGlXhviKwSUG6CfNVS1cx6usbtCR2TK6q7zEEt1?=
 =?us-ascii?Q?RQ6plhwINWq4DS78Mx5ykNczINCqWO/vTvJnu5Uf6esnatZ6bSJ7A0adOnYt?=
 =?us-ascii?Q?xoXJvO8nA03bqSQ4LCdZDUkx1TjVgM7HubCzXLwar7i5JU/xwkeCAEFPmIxc?=
 =?us-ascii?Q?ZtFlTaApR4HSXrL6ilXiSTf9vm4gmKtdanR1q/W8gYYDUR9cTb95w/fR7/0C?=
 =?us-ascii?Q?G+YaeQGgKOVLpAKod48mhHEqr2lJClpmpKjAgPBVGkvlke4iQL5udwoTlYJi?=
 =?us-ascii?Q?30m/hhsYZMqn/FZCIi+hyALacd0ad/MNdUxYYFlcQY27p1C30BwsqewTUcTH?=
 =?us-ascii?Q?cAyHq7Nl0T+3SkQz0eQUYCUqgpzriPSJoQJVXydq8XGNDp8LlT2DBrTOhBrm?=
 =?us-ascii?Q?+HyPtuRodO51GwXxBi5DJfOUk8vy3wUY7GerJbvLDUtM4+Bl24EG8wgVbcBd?=
 =?us-ascii?Q?SXKGvorjXbvegaFCAX95uwhyYKYmDDSIbXivkjam0jEBPNt14NbVMuWbFABL?=
 =?us-ascii?Q?SO1TiWO34t3hCe7I7OWK5egnTWxXzqskffTAvT15dAYd4ixCbX0ZHqwEpDBg?=
 =?us-ascii?Q?o4aajkEL2JHeiTv0wqSMVHw5gxgjXpLyqh1p?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?K4NqQMlAvjIzIl/QnJ+xxTUi7xNrnJh5zF+6wy5c58YYWZeFtMCkBU0ai1DO?=
 =?us-ascii?Q?v1Hae6o+Ikkr1ZKD0MEOID5atF2STxt+yyA/NJdSCHPs1N8nLaoatoDkuOrZ?=
 =?us-ascii?Q?2jxAqbCDWlq/2OhDazGkejPBU28zAkav7TIJMmcvJLlsqZLgSf8O6XppUN83?=
 =?us-ascii?Q?P40aIOnGraCIu8yDCZA8gJzaeMvbpW+6zYgGXsXP1edBfOgrLushuVp/fn24?=
 =?us-ascii?Q?KJw3F5Aqum2vshS38mFWQ1sNeYM3bJLwdekZ1EUf6DhiLOMoRZZGxMPyDhC9?=
 =?us-ascii?Q?lK5soa4bwhLsNOPOFTKO083ef2771D0MSkiIj68eGt+6o3BOOVXS3IwKIf19?=
 =?us-ascii?Q?7URVi9HlnKduN1JP5zzeJ6/Wpx6O78OXMmyR/jiKCcjupkv/TF+dqyxs8XQT?=
 =?us-ascii?Q?XTVGAcGmDsl33LnOA2qPZ7sqFZ0N+QLc+u1ILh5hF91/GFouqXL+2nk56IFG?=
 =?us-ascii?Q?3C+fpJCGrMWIE1C2atVr5onRZ3ihLiCey8HegBgeW69/UAg8avy4IqiOTiX3?=
 =?us-ascii?Q?MB4ThS9JaVx0Z9r9Xu+PrK+sAJjFuoJWBUNf/CNc8Ptd/0bDQi8XpRTKx8uD?=
 =?us-ascii?Q?wOm9YLHy9jm+haeW0OZk6SHCFPgwLeXcEWE1Nat7VaqE/ArRptnjQ9zJcPV8?=
 =?us-ascii?Q?aBguUSBWL9iBcxGsv+1wlxqDeMEw7RTUslS3vs+uHazmrC8DB6w/hjofRdJl?=
 =?us-ascii?Q?jUQKVmA1A+HmY/bMR68G0EnlhIEfbVx8MtidhOX7I6CcquTB8cNGZ3IwNla1?=
 =?us-ascii?Q?1IBR3uPHkchTu7xH5C1MrnkQImL1ZzBMHy4hJrPoF8uLfpeQQ+twwnJoegjr?=
 =?us-ascii?Q?58yoacYorQpsJVHCg+8YOXmDIZt1y1OjOkS9i/2SI0c9/OQJV33rLiARzyaE?=
 =?us-ascii?Q?2M9F+l4vObmGDgeDGPQ1orpOXilnAZFlGT4p9T7L/aulBbJ3/QMe95MIZl1h?=
 =?us-ascii?Q?wUPbSLPTlttc+VdRntQw2Wt2mIiuVsXTGEyR+MWU9Et3VUrpKIe9RremruH+?=
 =?us-ascii?Q?zW9kz0sNAKwWPKUvCjPmJcAVTh5Qm6RAWWvJbg+pSY7t6zwhZsT4WUpq3ABn?=
 =?us-ascii?Q?nQ+gVOmLVLwDjBgDv4L/pH0dGc/s0ask3O+lvwWVSCrsZ+CidJ9/c5K66kF1?=
 =?us-ascii?Q?Tochmx7Xh6gh3aBwvpLxPEEEZBz1CYet5wz54YuMzgXLw4sWgVE3pI7NQusr?=
 =?us-ascii?Q?D4xXoosq5m+gdixuACZveyiguRH6M/NslhhcW5ITaxmhzPFmi6fvR6vvznAI?=
 =?us-ascii?Q?z7zzhqm2+GFnEij5h9eGRmvXcW+1p9A4HlEJBJipJuQTnk8CFoZZxj/L12QD?=
 =?us-ascii?Q?HipIi4CANWwaBEvvTVXSmNItavAppi077mYTK7sORA3xS9ujPUkwlhiO8ynB?=
 =?us-ascii?Q?Xk6xzcF90wGJaO9WRuUhXFYMQN663duQIRKyM1gR92/E689Yo223nEZPiisU?=
 =?us-ascii?Q?AgEGO3yvsgeAzUl31KVwGjCWeLdipm8mUCWvp8x8kUARmXge9Z3Mbx5h0IiN?=
 =?us-ascii?Q?cwXgEaUO0uSq7mzeIRRrxpaFoVBffPZSOLeGolswZpE8lM8HeRBsDkhicKJE?=
 =?us-ascii?Q?h59CiTIbVErEw34nwyc5atMcbFutqIjtJJCFrwJo?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 369992fa-8441-4bd5-f613-08de27f2de2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2025 05:08:39.5838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pFQ/g2TbdAgPn47umA2c3Na9UG6SstbxdU0F0BMowUS2Mg/qseBVW8kzVCBF5l4gRP9CLWz4HZJC3GzdE0XAUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8142
X-OriginatorOrg: intel.com

> From: Luck, Tony <tony.luck@intel.com>
> Sent: Thursday, November 20, 2025 5:13 AM
> To: Zhuo, Qiuxu <qiuxu.zhuo@intel.com>; Borislav Petkov <bp@alien8.de>
> Cc: Lai Yi <yi1.lai@linux.intel.com>; linux-edac@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: RE: [PATCH 0/7] EDAC: Add Intel Diamond Rapids server support
>=20
> > Add a new EDAC driver for Intel Diamond Rapids CPUs.
>=20
> Applied (with a kerneldoc fixup to part 4).
>=20

Thanks Tony & Boris.

-Qiuxu

