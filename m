Return-Path: <linux-edac+bounces-3166-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C83CA3CEAC
	for <lists+linux-edac@lfdr.de>; Thu, 20 Feb 2025 02:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECDE93AF513
	for <lists+linux-edac@lfdr.de>; Thu, 20 Feb 2025 01:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C246212FF69;
	Thu, 20 Feb 2025 01:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QzxTDmAf"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8702F3B;
	Thu, 20 Feb 2025 01:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740014829; cv=fail; b=ec+P16iMJTPDPg4uqHjz32Pu5ql3vDiOSAzCFJpMNpfJtyjgn+WzEYQH7uDy6Esmsovpajp4XgWP5Pxw2Um8AeLMr3Ck6b5iDM+MxQHoyyyvZp5OymrFs0+MvY9PxaAzJsNUg9m2dg3rlgEYNtddn0FPuyUytvD6TR46d5VkmnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740014829; c=relaxed/simple;
	bh=aEWBEht+nGRTepighoJj1nAVgsZ608q1UU4PRDcPRhc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nIqlf1EKe+Rg1a0xl/Ot4Y6HvtWIB+bHTjmoOhna/px2W4lYF42HuGZnoz5vMhFK3Hls5meGFfTNeZBwc8kMygxED0/C+XGBEm8OqM/HVEyY1n7p5odbmWqeoSlWom/H9l0nCiZ4/vK4wbObOSyR8vA4ESgPXjG03/uLEIbxXaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QzxTDmAf; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740014827; x=1771550827;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aEWBEht+nGRTepighoJj1nAVgsZ608q1UU4PRDcPRhc=;
  b=QzxTDmAfPpgz+c7crZ422Qw9KboFcMWr9NtWQZi3CwfAVR5lnRZPhQsv
   TssIIkzd9MzoRLBvEBW0nRcl3huSD6hTwoAw7TOzPmiCnilxhkIf9hgZM
   Eun47uiJZ2hNXnK8DmP7voSatJND/eFLlZ+TBLDLU0oAAHYZVHqlyQDzs
   tCkbyVDR8w/DtHmwouSaVrI9gobH26l2MHspyF6+mK1uEujycDPgwAdvr
   nea81zaRFPUTDKTlQUfWUXlcMsPOSfMeDzRcK7CIyZz671f6E4w6uIU06
   imM557JpU3BnuZT57KwYespMjnq9ok/5IEPh03dQXTWjE642anJOyNOm0
   A==;
X-CSE-ConnectionGUID: e0K/zOx/Tsahdc3cfac9Fw==
X-CSE-MsgGUID: F1eluG1QRza272B6fRUqZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="40633953"
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="40633953"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 17:27:07 -0800
X-CSE-ConnectionGUID: MTDOCooWROqBMVj10CugRQ==
X-CSE-MsgGUID: QeM/JJXKTSeP6wR8TXIAgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="115561890"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 17:27:06 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Feb 2025 17:27:06 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 17:27:06 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 17:27:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sadPK6Q4hMlrhIZQD21vOMcrV/ULLI/SuaiWOC4Z8X7xxAWEzIzKxqFwHe/rFxyGUphvTpPgwKmB6BS3KDv0NgAVg0CKFAo3JyYXZ/DYBOnxnUh5BYNyPWbGDyyaRBLQ0MrtmdTKR2Mz2iAykzLFemKaVpPa2QB1PogC15h/arPJ6JIRkhbJOX+iVajSokJ6/inKAeWdqE1Sy7Ex7pggYfhmY5+dZ+J5s1FnkFltkpepkZ2kBCptt4kAJISAteGn2H7TM0VupCrFVn6J3g3e0DUsw1R4FsZX08NPBbsOKX8+9tOpfJP1EEGkFusjsjHBaFFE0VTk+2rjk2rudgw/Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p6pcUSla9ZyFVd7dMYTLoSV6IVfJpoMOjGIx7e0gfpw=;
 b=r77ABFUWZFlpOzj8A9DwfzhtQdxDsKikmVt/+mFF0VNzlBFTpA4AT5gKN8kPqmc9xhpbRBt7xgqsnbXcWiAeWppqDFqqT8DXwNcHtgK3noxz1414vemDO+KkhR3QDt3YSvJRBbkWCAjXRUs99/zmOdAdZypGZeYx0kF4EOwLSNMdY+jj73v1e/rYUL42cdWAcYYUxuxma7DRHvSnndAp3Wk0AT1cpiSr4H1L9fRpFyapmyCTJJVGIZONo/OT27WvMAc+2Uyrw6J9sAuOtefUOBR73IoOwq+wwNDG2yRPB2U14d6TMRHzHGb1OzvNq1Su9wq5yqX80rB6l7W+M4S1qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by DM4PR11MB6309.namprd11.prod.outlook.com (2603:10b6:8:a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Thu, 20 Feb
 2025 01:27:03 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%4]) with mapi id 15.20.8422.012; Thu, 20 Feb 2025
 01:27:03 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>
CC: "x86@kernel.org" <x86@kernel.org>, "Luck, Tony" <tony.luck@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"Smita.KoralahalliChannabasappa@amd.com"
	<Smita.KoralahalliChannabasappa@amd.com>
Subject: RE: [PATCH v2 10/16] x86/mce: Separate global and per-CPU quirks
Thread-Topic: [PATCH v2 10/16] x86/mce: Separate global and per-CPU quirks
Thread-Index: AQHbfjfFfcwhoaKyI06fFY9NnIDF+bNMliVQgAI98YCAAJr6oA==
Date: Thu, 20 Feb 2025 01:27:03 +0000
Message-ID: <CY8PR11MB71348215C3D43B73DA4B3BA389C42@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20250213-wip-mca-updates-v2-0-3636547fe05f@amd.com>
 <20250213-wip-mca-updates-v2-10-3636547fe05f@amd.com>
 <CY8PR11MB713455D3FE3A60DF09F5404D89FA2@CY8PR11MB7134.namprd11.prod.outlook.com>
 <20250219160641.GD337534@yaz-khff2.amd.com>
In-Reply-To: <20250219160641.GD337534@yaz-khff2.amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|DM4PR11MB6309:EE_
x-ms-office365-filtering-correlation-id: ba965665-b0f5-49b7-df4b-08dd514dae80
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?q5EnlqbNmdwMYNYzxlI9vhQeYR0TngEBUDx3FmioE+AjrqUVwwsb/sg6lBAO?=
 =?us-ascii?Q?ks2PENiX3T9Bs7vLsw5AkMMLol+Ldb0vYqg+Z2jL10+AsnuPRmbdcf4iI8Rn?=
 =?us-ascii?Q?ywoS6CExno5Im3B1udc3Qj/Vt+8pm+o9DOILId31jBVJkc5GRKOnagBT4u+X?=
 =?us-ascii?Q?fQ3dbCn2KOx65DAx3KABdLQw+NVgEZ10RFZhATFY9VjWShUvyzc1OIaFlX6B?=
 =?us-ascii?Q?poJu5Xo2bfBvZqvFUWEW2i1WIqoFYXclLEqKxLF1SSkIBCJOxv7ECfUeIaGf?=
 =?us-ascii?Q?Xzg/YBpcigzg8oAHR+w1SyWlaUR3l/jn0XehIzbGTRwZ5ffRlo0y1BzFSyA2?=
 =?us-ascii?Q?zsG/ycxgwnlDdL5KvWkgMjDTk7VeJCq2J/VvZm2dIeW4AbZkHSVFPBPM8DJc?=
 =?us-ascii?Q?HdtkAcwsnHGDeI41kCj22DV4RhNy4O3DkbDSX9S3qZv9GNu7t6tpaJMMs1v7?=
 =?us-ascii?Q?WQyMLAY5WXMHpIasnP7sB56AxdVkipvo2jrnuEDL8guFtrFvqxvXmx3T9DeH?=
 =?us-ascii?Q?uiEdsC/mSGxAfI7VU0Ffv445pn7nimFTTRummP7j0oDpoOMnGzBscuNno0L6?=
 =?us-ascii?Q?iffd+Pd2x5FTBCpprEfvtdclvtaW5tsvUlAT4NAOJhaEbdS6nbfZbv94X1Ek?=
 =?us-ascii?Q?KtbRhNcIhR3NO4H05tGyvNDFTyloI8SZyKMitO/qL/h6ANBoOOzYWU1kLAVj?=
 =?us-ascii?Q?aZ9++3OZM9dn36itmvYdyv2pG96YaDA+lYptI5YaSzln2zwlOXb/TKgOZzIg?=
 =?us-ascii?Q?0rABxFGNQB56vClW+Bk4quGXC3VXaXxSHfwCI5BlDuymS+zmHq0AKe0Y7S/P?=
 =?us-ascii?Q?tPIOvsh+LFTMdUf4TajSRsIUKvVUlXsvje3Aok+eqDDiY/2eeCflHCPTAlKA?=
 =?us-ascii?Q?ImwIRSuoK526X/UbDICqDAB+a7mNOUVH3HkBvuaJTvoOMCpBaR/qLmdJeLOJ?=
 =?us-ascii?Q?D4pRp6/oDib/3B4nWgbunrZRwxdYW9WN7FcYWwIL/I/Iy4OuevY+3sL0uzmL?=
 =?us-ascii?Q?ourSrR9b+296EvlNOvO9F2Noenirt3spwjnS3mreJC/CPc7IuWqPQZUHz55n?=
 =?us-ascii?Q?XOdZwguD40j+wWDat1VxXcKxcVaJy0COAFntJNrR3qZQJx6RodOjvN6u4lX3?=
 =?us-ascii?Q?q63TqEsDCEQWb6v4XTCHLhj7HkFmB9O7A4I6pJXScI/Zs+388H993zTUE7af?=
 =?us-ascii?Q?gGrfpD9UBqfL2zkvj3RwaipnldKaULKiiOupHmH4zdF3Bdn41BLhssNLpLXK?=
 =?us-ascii?Q?S+hUF8BdrYQifuuK63CiOunGNlNUsOWwt+82lx4T3WD6UqqIfAehNQmhLq0d?=
 =?us-ascii?Q?bay9eK6eQhqCuRqLhGPYkAvLI8rRSD+9sswkkR69nwTHngkTy1XXzoR6PBF2?=
 =?us-ascii?Q?fgrFvfebnq2CGOkv2WoMbLBdClw7gYeX9QF8FUtBB01EVaiMgkkmPUPvSA9K?=
 =?us-ascii?Q?Sm2irR5TYLPQTHP2XlCSYcm/plUTCqio?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?D6WcFFyFVwDcCRrBfOuI1/xttay+eLwzdIL3QlAe8RdJLcHl8e5KFVU1PiRc?=
 =?us-ascii?Q?28W+/XK/hwP4GpvJGs6Ze2oH/5gtEltXcUuQiq4IKMGZJO9MgFtlnybPT4SS?=
 =?us-ascii?Q?Z2po50+7p3NBGu0wOhCpBJbmG5ZjQTCQ+giTG1EufxJ+snIfmKxk9Pz29DiM?=
 =?us-ascii?Q?haU2Eoe84DyGqbzLLtX7EtdlFCbcucb7kwPPGf8wHNAOTdUb4LO7+j1kitiW?=
 =?us-ascii?Q?YLko4byg4raTlsCiQxKblf0vldesJgYMt+aYCqHuLv32ItUry122p5Hgg07h?=
 =?us-ascii?Q?iCO/29cMNmILMEN84oV1XzSmx8wDKPRhpXB31NOqhdMjW6YND0XVwKEPI9g1?=
 =?us-ascii?Q?sBRVCBgPXpAoNeLosMnVi5ykGfsdRMcC9LDItIgbSPrz78OZdIvwMs4hw7eq?=
 =?us-ascii?Q?cdijPTn8Wz5e9xO/SekyDT67lg1hAd6jWK5Q/BpD3WpmR2kog1m+fIYqWL2i?=
 =?us-ascii?Q?GWT0sGpuqeMBcwB/53RseFbyjsNiiqMF2iLHUi3yt4CM7at6t5yaMftntu/8?=
 =?us-ascii?Q?Ti+T/MdlvGG/HBkz7IMWHsfqji9Dm/a3k0+S8a9xpqlPeZ3qF2cLA5KgDEq+?=
 =?us-ascii?Q?H0XAU+TP7YY5EDaLeanKMXamJX035jMsNY4484MZfnKqPa4CRAHd76JXGMPT?=
 =?us-ascii?Q?YtPkT7YWl18dB6FbBEXspNOxghx2ezZhRuAPLKvePEdaiDiswMMJcBheHKG2?=
 =?us-ascii?Q?8qK04fRosalotMMP7+kla0J3cSO1zjXilqr+fvEmG+N04m1pHSpixF7YCGLo?=
 =?us-ascii?Q?cCHSJB69N6+nVJtNbQPQ2oHUA7BUztM+p/XhkSsrrfcG7sRsBGIneWikp44B?=
 =?us-ascii?Q?f51x3GDM5GDgqCQziAPkWugcszKvOJkN0xE/VAUkP2GLEUtpj/XKGC6q65yy?=
 =?us-ascii?Q?knxsTWzuuH9BwUvJujKkx+hC3/LK0hys5RBfoJPBrsyXihJB4D56b6V11Xen?=
 =?us-ascii?Q?g2j31wxAtIbLuJoXzM3vRZbnZ+3Aj8kub71fB08BpiML+J7vBl2gnwK3o9CM?=
 =?us-ascii?Q?24KT61lCwaeHwjoJiHaKdqNgUji/mGiCCTVClZCxpQviRrxh+ZsOnyXt7blQ?=
 =?us-ascii?Q?AXcrIFdbIz4lLQROyTncB7OsjwGq6jGiNcDVQ7EOPA79JE8tXmwix1h29T+J?=
 =?us-ascii?Q?i/AEqMBJfxFhMF/TKAGwxjis3y5bcKElIjidNUxMijLPNtRtbYuwB3Zl901Z?=
 =?us-ascii?Q?SYeUXnKhi7/y4MsuGPUxEiiRdqRdu/y/Nwq3KHdjf8L2hwNg3jU9YmXP3yPS?=
 =?us-ascii?Q?Yh5xU9dnLlXVEU4hahQnVIwxjP68MP0h0zDQf/WOo4zi3i5tnccApVvvTre5?=
 =?us-ascii?Q?M3RXeNrLLbE4N0/IkbtonoXHrtTx3IYozIUT9uFpjSTFjDAN7NXR3j37Ie/E?=
 =?us-ascii?Q?QqdU6zzoO8kSGirxzjSVXRPZf+mehC10wPtxiJtPDr1H5TChDXCN8/uQmS8w?=
 =?us-ascii?Q?cFzh/st+oSm6Es3FqmTzUlQu+W+nwDx8F2IIc/Vy/0uPzkuDN9tiQl5sa+gm?=
 =?us-ascii?Q?7IIwrhIdGgnzS+9n8Lu/rpmCK2+rSTzDIcTiOHHRftsKaZqK27AdLWbhmd2L?=
 =?us-ascii?Q?CS2GDsczWOq64i7FymMVIf2htvLTfm7RdPrL/ZAr?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ba965665-b0f5-49b7-df4b-08dd514dae80
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 01:27:03.8386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MIGymbxwBIRVtFEi2Sz1M7BCPk60MMDFy7aqRqlu9JPUICL/tNHYKGSEAbksbwOE1kWwY08hbevhtacwVVh3Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6309
X-OriginatorOrg: intel.com

> From: Yazen Ghannam <yazen.ghannam@amd.com>
> [...]
> > Is it better to add the following description here? So that it's clear
> > we don't apply the quirks for older CPUs.
> >
> >     Older CPUs (prior to family 6) can't reach this point and already r=
eturn
> early
> >     due to the check of __mcheck_cpu_ancient_init().
> >
>=20
> I don't know. As you said, the older CPUs don't enter this code, so why r=
efer
> to them at all?
>=20

As the following check "if (c->x86_vfm < INTEL_NEHALEM_EP ..." includes old=
er=20
CPUs (e.g. family =3D=3D 5). Stating that older CPUs don't reach this point=
 makes it=20
clear that the quirks are not applied to them.

> > > +	 */
> > > +	if (c->x86_vfm < INTEL_NEHALEM_EP &&
> > > this_cpu_read(mce_num_banks))
> > > +		this_cpu_ptr(mce_banks_array)[0].init =3D false; }
> > > +
> > [...]
> >
> > LGTM. Thanks.
> >
> >     Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> >
>=20
> Thanks,
> Yazen


