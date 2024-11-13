Return-Path: <linux-edac+bounces-2526-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D47E19C70AC
	for <lists+linux-edac@lfdr.de>; Wed, 13 Nov 2024 14:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 940B428147F
	for <lists+linux-edac@lfdr.de>; Wed, 13 Nov 2024 13:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16C31E009F;
	Wed, 13 Nov 2024 13:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C5pU1w+T"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A850C17C68;
	Wed, 13 Nov 2024 13:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731504734; cv=fail; b=r8P5MZmbU/PnA6iM/i8TYHiVle2SoiF0F6HRAxBm/C/v5W5toX0Yo6wuoSF6WeDx2cOvTy5tPopgJTPa4lM8zIQ/eVNplFN7olvItjz20ysAMUjj0DWACYjIXVdnLw6TPq9wrfE4ySTJdUxFgP18STH1R2JqP8anI4L18tzRY8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731504734; c=relaxed/simple;
	bh=MLEsxURMV2jQBIlxFmcZ4y+VgoTNJmocu+ccdeaOiGE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oJ09FvI0LxL1BpIqIVFQGccUJm5NVgpKkjm+XZE+8B/IaaOqkgERNCJNHRQ6dcAw+0UdAjhYBSg50V8C3YhircTWBmv0IJEDqDGd3hNgHBmiPfMTePMsZS/Wj3/59D6POqzHcEVgQ2goEDSsW2WVkD9cpGWYdx+64w32PgZfE1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C5pU1w+T; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731504733; x=1763040733;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MLEsxURMV2jQBIlxFmcZ4y+VgoTNJmocu+ccdeaOiGE=;
  b=C5pU1w+T+7I9Nt5Lfll0fDJT/nsNOf09It1RJQlk6rakLU+eh773DvgG
   ERsgjXdwdOf+VPXfwjVyBLEUdpcWFnJFSTSpoeO5rA0zzJK4DWJohg910
   YrNAPZEf8CuFwyURGzdTiVDYwOYBkdrPeZNi+fqy2xvAkohxEgMMq85qq
   A5zQ76lc38VteSi8/X1D2MPbbMTqQN/3xqAJbxHHfrGId6+P92oqw2dI4
   PpNhOXYxkdzUmm2EE1p2U6COSC4PbKaLnQuXBnkyq/MpbvyhfgGGFFmJW
   j+SLTLblg0MmRALkwOdiLLJQphEx6XW3vo7yNj56BtpvValKvcYGrPEWB
   Q==;
X-CSE-ConnectionGUID: Ml0SGa6iQBKo7cv9MkOK2A==
X-CSE-MsgGUID: yBHWjk2nTMuStig1uwU81Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31568760"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31568760"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 05:32:12 -0800
X-CSE-ConnectionGUID: 38hB0VOXQ9+UXTQpupkMfw==
X-CSE-MsgGUID: lo9/RyTqQtuzXed8NGcaIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="111188815"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Nov 2024 05:32:12 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 13 Nov 2024 05:32:11 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 13 Nov 2024 05:32:11 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 13 Nov 2024 05:32:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dRCfSyLsDH4Xjq8mxfUBU8GJR8yqQ7D75Cs5G8SZwYE5Ewezfz6oiPc/vnKRrLwBNnSJsfw7onTFcQdLH+vjnVEYq3AIJ+SvQlaNfEjjakvlUporqPXQu/SdsZS83ZOBcz/e8vi+jl760xylQIXg0kH254pDNXlEVUtcGUdibNfetICwVNVtmRzOlYTCOUV5NZCQ5qOY3Nag+7fiTPxnEo0/EJ1GwXHS2g7ccGu33Qd4uycvRsclVLyNHBnCF7faySvafO20LnDLfLYntRGHeImE+8N1ZSGBl5JIP/89ny+v3X2d5INlAtyzSV3GNDXGmPPuSalyST0aGEsLj2kZWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6twe7BOSGfZuK3nvhtX34TvMkfOAF2TOA7UJyeuQPcM=;
 b=quAnMLblnrjqItm/sZPpDUZq8SlCUh4GGdG2oMqevJMeRXH/Ng9ZJc6RUstcW3l/2K+fTP7ju37QCODskG1gSg/C5oSL1C01Ibob352AutvT5Tcfwpog7F5IALW/vSvnMh4y6A2dwZs5FvPrnO87iXR25yhSSghUlXMgQt7eastUtREaffaocdJgRgovnj2gq7jaQMpk3WJrbCPsiz0DuOy571TbhsZWyvap87QLHLVc8Jx3GdQqlQ+X26deKivh53mgCBlHO1U45A565HtZHorUaGEnNK8pYPV3KNFKT27ZMcRKznTLpkOu2KEwP+mVpZtoUnA+2/LfnieNHvoUxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by SJ2PR11MB7648.namprd11.prod.outlook.com (2603:10b6:a03:4d3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27; Wed, 13 Nov
 2024 13:32:08 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%4]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 13:32:08 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>
CC: "bp@alien8.de" <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "Mehta, Sohil" <sohil.mehta@intel.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "x86@kernel.org"
	<x86@kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 6/8] x86/mce: Remove the unnecessary {}
Thread-Topic: [PATCH v4 6/8] x86/mce: Remove the unnecessary {}
Thread-Index: AQHbNAO1OgjxQDLqXUuhfof9VGSAjrKzyz2AgAFsUwA=
Date: Wed, 13 Nov 2024 13:32:08 +0000
Message-ID: <CY8PR11MB7134D5578EB260FEB1216353895A2@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20241025024602.24318-1-qiuxu.zhuo@intel.com>
 <20241111060428.44258-1-qiuxu.zhuo@intel.com>
 <20241111060428.44258-7-qiuxu.zhuo@intel.com>
 <20241112154335.GD3017802@yaz-khff2.amd.com>
In-Reply-To: <20241112154335.GD3017802@yaz-khff2.amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|SJ2PR11MB7648:EE_
x-ms-office365-filtering-correlation-id: 392e673c-1554-4b08-f692-08dd03e79228
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?er0pwc9yU7xW9XKxReXkr6X3kQcSgL+kpxaeXNskFRBl3dJ9E/2IMH8ABT0j?=
 =?us-ascii?Q?aXvRwzdbxPMVLTju2WKRPPid1V7cAK4lv3T5Oos2NoGXhYo8yvBwHNcu3m0p?=
 =?us-ascii?Q?4RieXrCg5eihX+0BorgvfwE6RK980f7bdhEaj5gTuQP3Gxpukc0Dg2yAelgA?=
 =?us-ascii?Q?ZY7Pa7BWwplocfKjcdCcQK7d06+F3ew41giKUEVF/sd8Y9OQ0Q8ib3/KxxkV?=
 =?us-ascii?Q?dHvpcvou4fTw35qmQvzLrH5Eova4pWLeqvORTDpTCCFUCgn0Lf8/gOrk605x?=
 =?us-ascii?Q?cB3E9u9HLTM4mHPlYuEtp8gs9KaWTcIAFGc5aJczzZalMYhgxkDUnWYuSkoB?=
 =?us-ascii?Q?znRdktCsHoESNcNJ4NuDzm/nQPmavdiisfej9oA2QzFLHxW/wVJy8sTxeTRJ?=
 =?us-ascii?Q?Zv82euobnfQoq8mOjatbbgDkeyiqytSQib0w/j5W/MzVoEZE1kTYR/KRI81e?=
 =?us-ascii?Q?KitE4dxm85yrbUKhZVkj+g3D9Cuz37Hk2pbCU6jSjGFt4NB1EZr56xvwxyy/?=
 =?us-ascii?Q?NOTkoVJmd9gtVtUprZCH9gBx7gN6rwTGyaVbByp8nQDndE74LTEfOOu/tyDh?=
 =?us-ascii?Q?imYRNcxiaKSE+9MK3VWti9XxKWwjwd9C5kiSU4PtvMtfb6UZS5fLFqOSH5BM?=
 =?us-ascii?Q?Kh+1xkqa5dqWgjI3Z8Io+mwgisiWRMTRsX4FgtF+jqWIXJsgZn07wtGl53vx?=
 =?us-ascii?Q?VTr8nJiPISx8aVzx+NajQczAt04WWhf6QqwnXDU+PaHLlotHRQmKqCcvbh9H?=
 =?us-ascii?Q?3f9v7M1djDTjuuKlWxkcAPLCDkujO2klPXgS8pfJGT8RQG0kBfsMyavNMc7f?=
 =?us-ascii?Q?ZgVV3eR8sA3UyuBVLDqhzmv38FVtVqmNox23fpixv98Mh3SHyHay+lRAt4O9?=
 =?us-ascii?Q?jHdeDbZ5ZiIEi4FTwmh22EfcldpV6vBbhSm2j0l+ThdvoETETVMFj+ec766Q?=
 =?us-ascii?Q?MVwFemBIPVkuZQrIZYSttx+rRbjX4GZEuujenGlQZ3hjhuQ8MWg4a/NyLqtL?=
 =?us-ascii?Q?/HyxuwDoLcSi2MmKB3a8RRXmKIbqTdvY1+20Ue3bgCAjBbnl+pFcdZ/CI3be?=
 =?us-ascii?Q?+0Onx+NWeK/ldHD0UulWk/xVpllC6/PwX5oHBvqqj3R6zA9UQkuO4Lwu7KsF?=
 =?us-ascii?Q?ZunP9rrRF8OvEYWS+RZQ1MndFLmNqQV+8ZpDI6UnnPIX16zQxJZBeprxkU5Q?=
 =?us-ascii?Q?oq/wB0rP235Twtbs2aI4NY4p0T0fxU5qQVYuVWsj9Il2OJcL9XMGTiBicSmn?=
 =?us-ascii?Q?5VLOgbQgyP7ug2vScPrCp/cOMF48/+tPxRnWEz5Hmc7cDAiSWhe28TjOK6kL?=
 =?us-ascii?Q?+x/nSNvI8E1tIO4mkUHEdvzl4fpGj8WR9mWCjRllHrzkSrpSa4O11TPgHjPK?=
 =?us-ascii?Q?gHnFK3U=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wF+hMnI3uAd6vWUDXy8ahmbJo2arJs9/EHmB7B1jxeKFVY8zlPW/QQnWyfOW?=
 =?us-ascii?Q?mzT4wM0ewHY0yRB4K9hlgRd587tDJICJsWUwJvi7qLWQ5Yis0rC4v0KMq4iP?=
 =?us-ascii?Q?5ceX3s9c5ja2YZ5Cqp5neUiP5P+HeB5tgwJNYdsoZdLZR3WSzHs/pcB1miOU?=
 =?us-ascii?Q?NIXpYco6HBXw4qxTUQQfjLmcsphKtHBaJbPyEBMg34kisVhQ2TTDrs2ng9nF?=
 =?us-ascii?Q?u7KQes8jcg38uuR5RFJgNDcRfPJOK20OeRPUhZ5gZxOs4iw9dxr8c9jvZ8ti?=
 =?us-ascii?Q?ube/9VEVll+UnTap+doJbjZo5HRoFayDBnxE2JEAPg+mwUQp5XYK6wnW+9Kd?=
 =?us-ascii?Q?y4sBKEBn1jTWYpe2wxb2B/fGx3IZLjVxqAMi7dfcnsilftrJWPzhABpSAZZm?=
 =?us-ascii?Q?ZmBLrmtfMKhsU5cA7dQeJwXBb1jF0PQLhTf5XFRv57Tb2ackCWE2ET3knGAj?=
 =?us-ascii?Q?oOr3SELOtwELABi40X+JNoUsUzScGJfba53UKhhFUdXK3iKmUObXbU/LyQ3k?=
 =?us-ascii?Q?4I6nHVFtXkPrB1bcugBGQSNx9QpUgDmb4dO6RH+DEG4OHlaV44yIKPXXYCeC?=
 =?us-ascii?Q?3i55+rOOyh2mnIKMBbS5Y0cqKM14CxSyAkHDuYZxbq4uy+ZoN4uIj1CUVxuV?=
 =?us-ascii?Q?WRVQ3yMxdOwLhN3eujBZtZl7rK1O9Y1VfQEBPoRGiXjgXOe/oRHL4f1IEhOj?=
 =?us-ascii?Q?A26eid7mXEfd1Sv60V7xePUaTxd6YzNOYJXf9BAcjODlMg5AumSNhBhFo/Sc?=
 =?us-ascii?Q?0lZEU9/lYglHESqz5dK68SECEtX7uXCxLbjqYUHBtqHRt4LudW1ZWuHDyMMM?=
 =?us-ascii?Q?lkLyjJhE8w/bFcwtrPeB89Su6pfsyKwAwu0AQzXuFn8isGKpOvEBL1qbFWO0?=
 =?us-ascii?Q?vxkWVcKb/A8IvThWE8XAVgRixWayrBzuZ0Dppb5V6YHcsFlQa+L026t9XcdP?=
 =?us-ascii?Q?cbEukJfgCazAaN9FC2Gd877DtRWurXNOrZE/AJ9wbVY8KcS/5d73YhEQ62Ix?=
 =?us-ascii?Q?2d9/RLh3iSwO5ZaTCyYYVak3s8OTOnGX0dXo68OuwfPeSg9+TKZY4yiL6zV3?=
 =?us-ascii?Q?onyDgwoTKMfR7hgLdPckooSk+YzQeecrYaOkv9zrBa3rnSTm3L+7A13U3Fkr?=
 =?us-ascii?Q?lH0s3k97nZY97cBc9LC+OvNDYJ61gdPryh5m9LJ5cx3iEwGf+FCZFT0WMQAR?=
 =?us-ascii?Q?JJBrZC6CZZVlT10iQNncCLqZuPLtr+uR+q45Sx0jJDUUDC+71PXW/lA7pxOe?=
 =?us-ascii?Q?kRN2f0ndxfoXFl5uHH2T0SCRiJBr1j8ZpfCtnftWB7pafa5cl+TWcXncm4Wo?=
 =?us-ascii?Q?5/5uPyE9WTHvUQbdIWPPGxqbTbYyVJcR4ae6V33pKwANmn/5dIyj7h1In0n0?=
 =?us-ascii?Q?Npr1+ltvNA1s7Ikz0jSEOumzMP71R8591ofugLBh2nsO3oAPmqB2ZAJ13yDm?=
 =?us-ascii?Q?+KDBm7UwucqdAXJYoSM8bWDUvLA/lydwtVcKI61+QDPBRS6DrT3dDpkn8RC5?=
 =?us-ascii?Q?19qnzFzsoyEbC/o/GNjffwOSNf6jypq54PilWgCDkD9Mt9KPvOKI2dcQeCu4?=
 =?us-ascii?Q?qlEeVSKk3f4rMok+6DI/9X1VQfxDspMVs4JS+MqB?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 392e673c-1554-4b08-f692-08dd03e79228
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 13:32:08.0629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DeH908H3u48g2kdIL/xYIfdtMupXxe7QmIbgsZbzHfRA449FctoSdzTHeVEveWvDlb2r3V1Ha563lHZr9CUurg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7648
X-OriginatorOrg: intel.com

Hi Yazen,

> From: Yazen Ghannam <yazen.ghannam@amd.com>
> [...]
>=20
> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks!

> But please see note below.
> [...]
> > -	case X86_VENDOR_AMD: {
> > +	case X86_VENDOR_AMD:
> >  		mce_amd_feature_init(c);
> >  		break;
> > -		}
> >
> >  	case X86_VENDOR_HYGON:
> >  		mce_hygon_feature_init(c);
> > --
>=20
> I think this could be a bit more substantive if you also combine the AMD =
and
> HYGON cases. And remove mce_hygon_feature_init() which just calls
> mce_amd_feature_init() anyway.

How about a separate patch for this?=20
If It's OK for you, I'll follow up on it after the current patch series has=
 settled.

-Qiuxu

