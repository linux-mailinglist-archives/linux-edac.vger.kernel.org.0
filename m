Return-Path: <linux-edac+bounces-2525-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C678A9C6EC8
	for <lists+linux-edac@lfdr.de>; Wed, 13 Nov 2024 13:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 545BD1F27F97
	for <lists+linux-edac@lfdr.de>; Wed, 13 Nov 2024 12:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81DE202F7C;
	Wed, 13 Nov 2024 12:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Th3/i0Nd"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80B52022E6;
	Wed, 13 Nov 2024 12:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731499841; cv=fail; b=badaB1mlgJ7no2HiUppjEbku3J4PmI/+FdcMkP4g6VvjUyNlKWWOK2m012HbVW+qmXIXvT/jNqRBaPEI0jtmshNa3h1GhzgqSQ7dlh8yvd5KfGQHYrjkKR16mFwJSYDFa5lkI9Xjxp6fmSu6lTbB4nBtzoBP0xF5Wn+1m3drP+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731499841; c=relaxed/simple;
	bh=fTOMrpu3JaQOKxkCMMHPE1UaZJT0RoP9o5Kh0aw9mZQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RBiwzuSpEJb2E07MzRVPgIi+zmE07OQhw6XEJGpkxBytfcD+Vi37Y4wJKQ3/BwSL7fJJ2zO3keW+LglsGYnkiuSdcQixiNKxDunspPMoJZDbL1mpgVL8cy3piEbjNSRHxkxLes/097oyqJBtt+pdfIg2KMWT3yM6NllaVkpad60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Th3/i0Nd; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731499836; x=1763035836;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fTOMrpu3JaQOKxkCMMHPE1UaZJT0RoP9o5Kh0aw9mZQ=;
  b=Th3/i0NdIfxWsyrkk/GxWeUZ+A596bPY85OKYS7nEN0wOb5dyB3xJXve
   mGyXUNVAK5Te7BgIDdtUXn+XPwY1hpiklpeOUq5Nxavgtjs9wJuBWU5x1
   PI83yZc8y6G4U+ucGN40RpPTmmvmeV3Age5BgjXD51scotZ/Dk+Bv/yK/
   NZ0I6uPqNRxS0eDYjwzW5FE58IKS3Ve83YldCOU3ISUO98QkfEoQBME0d
   oxPVrXQBNTGKC49GN2tBB0oh65ziiaWTAfmpsrKv2oOixpxk/SB6ySs6F
   KQf8dypLC1cElbnVoK1RVkBRt+5qgmJDgSPLdXBYNtBdfOJQNt9iVWpLE
   g==;
X-CSE-ConnectionGUID: IjnhZg4iSZu2lNEhraHoMw==
X-CSE-MsgGUID: Nfd8lrFMTL6y35RNe0iXFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="31480796"
X-IronPort-AV: E=Sophos;i="6.12,150,1728975600"; 
   d="scan'208";a="31480796"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 04:10:35 -0800
X-CSE-ConnectionGUID: dMnxWpQfSKS1OvPdaBO3IA==
X-CSE-MsgGUID: 1Y7UBgQsTgS3oWvPwgYwJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,150,1728975600"; 
   d="scan'208";a="87964369"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Nov 2024 04:10:35 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 13 Nov 2024 04:10:35 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 13 Nov 2024 04:10:35 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 13 Nov 2024 04:10:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fpuD0FWgsTr7QfhWEE3tggcRwHz/8OmRrsqC4ZXiqGGPJ+VjJsaUBKiTUxnMoM5JXdT0UNaSWMLySKg05p8jJMtbsBkKJ6vGpi33xScP/plixHy8/23nIozI0XVMvyTRd2SJ8OdVLYrJTKg23lOeZpYiSGljnNXLXoXz/PpgqJOC8Mvf7tUzn7sxgLnGUZ0prB2aWoTW2OoE0FGrH8WQGA3Pi5WJ7zX50mcB8cS8jikTrR47/K11oyS2IGCf6U8CUg+3akRa0USrlgf+4Ou9v6WVolfX2QBatgIudgtC4beRgX7yVZQ/71/1rFX8WfyAodIWzSUHLj7z/tsQWm1DpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nlSEDFP12OheruDwuZM2EVRfqGOK4bvwRE2rCENdA0E=;
 b=Hf3TV73UUt77eJUt4mI1ha0+v3xW9MX7ulMZaxSzB404jh66/71CdOsLOEQrTp9v5itfxixy8bLVpGnoMsKZeTKGTpz+j5pggwkBxyT6rftSTuuqcUoV6jq56DOTwTSdfaTRVbks3zchD657s3sQzlw0SCdDc9UelyPOOw9bvdnfgThZHbRGR48da1+X3y+0Si2M5oxO8CtKCGuLruHSukjvqHamh32bvLMY+ShRimwO/ea6X0wtpjTyIWsHeoqUl8slJWYCbljzbg7buaZOKx8H1HuRc/3EMEQuCLh61DWIUDKmIQshl9zZBEl/I0a7/s2Oo963jO4hOvGhZghQyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by SA1PR11MB6824.namprd11.prod.outlook.com (2603:10b6:806:29e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 12:10:32 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%4]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 12:10:31 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>
CC: "bp@alien8.de" <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "Mehta, Sohil" <sohil.mehta@intel.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "x86@kernel.org"
	<x86@kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 5/8] x86/mce: Convert family/model mixed checks to
 VFM-based checks
Thread-Topic: [PATCH v4 5/8] x86/mce: Convert family/model mixed checks to
 VFM-based checks
Thread-Index: AQHbNAOwVGx4kOICWUGqtHMaNGxb2LKzxq4AgAFYcCA=
Date: Wed, 13 Nov 2024 12:10:31 +0000
Message-ID: <CY8PR11MB71344CF097758F67C9336B85895A2@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20241025024602.24318-1-qiuxu.zhuo@intel.com>
 <20241111060428.44258-1-qiuxu.zhuo@intel.com>
 <20241111060428.44258-6-qiuxu.zhuo@intel.com>
 <20241112152716.GB3017802@yaz-khff2.amd.com>
In-Reply-To: <20241112152716.GB3017802@yaz-khff2.amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|SA1PR11MB6824:EE_
x-ms-office365-filtering-correlation-id: 2a00cf92-9de7-4a84-39ee-08dd03dc2bcf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?RW0SIAbIIylx5nikYngHz+Rwm0qNdqSKdJycTFseBM+sAuN0J69YXwGmy9tf?=
 =?us-ascii?Q?7nY9yuavU3jj99pOTd3DZIJwdl/Lv0kocxjlRZVrw/pq7LyyY1K6vjdObU/w?=
 =?us-ascii?Q?lnGvhL5HIwgmkX7YQExxsREj9lbKDijtDL1S/S4px6l8gyq75wLaxeF2Mrha?=
 =?us-ascii?Q?H5CAgFslEuTQsNcxOLaDAFOG/V5CmA26on2AmmHPGBhFzNVGYz4+/D8YfHdx?=
 =?us-ascii?Q?/+K+/maAfcqeg4+FXHtRjzun5ePD/AiuXVeI9Lw9/9d4cMRHrGHUhkMHdxsP?=
 =?us-ascii?Q?BXGFcLZNqXmuHnFAdGgwhpN7CjLO56nF7gH0YCARGHVAiPl8vTFV2iHr5rM5?=
 =?us-ascii?Q?Y/horS344GXhIt1aRDEB0tZg/W9x2ko2yh/QbL4Ah7G61pifu5GAdqBaUgRk?=
 =?us-ascii?Q?/BNmEMzbzPAg1tI7WaM6l70k1UJojFldyBnCeMGQAsDro/u6i0NUgRWVpjgO?=
 =?us-ascii?Q?57nNYWnmH9y0kfHUQCl6wXMKzygdZqvFes+wMnnnFi5ZMM6RuLsSBauG4U7f?=
 =?us-ascii?Q?zR33McKVFR5qHzeiZcaEtlVbYm2uu8OBxdx2B8wKXDegffh7Z5vgTZY32S1C?=
 =?us-ascii?Q?WFR9Rv1eSK8bj3CJjngHLRDkJgJOvB7xHbdTpUZOM9PlTpoNzo5KzzrH61dX?=
 =?us-ascii?Q?Do2Ua3JLLYTrXpqRarYGx+tLr4BqKCnpCYhF7gSEatJzmXa8A5HPkEn9My70?=
 =?us-ascii?Q?kNtFPqNmRDOqF5PcTGB68R5XP/66arIbVgeIaEw/JUrqdRJFFeJuO1u4XVGD?=
 =?us-ascii?Q?9OVx2/YUYTdyIEtglWQqiiJ1WlUWp2S014xijGgO0Z6Oy3S1ebxulKejmOxS?=
 =?us-ascii?Q?HMn9gTcYxU9phYQ9Vuahk/Gzk/NpEsaE9thHI9DPCujhW8fSr1TtJiUifd2F?=
 =?us-ascii?Q?9CAIg1ZFX0bFJ0exIgNW282WoX7QkNbFkMStwDs0QDstpLrXR8RKSStK1d8L?=
 =?us-ascii?Q?dGgAbBahjP64Sr2rCZA9f3WnRnyXH3AsvPjURGiNtnkQXHoTTPa47sVMLshh?=
 =?us-ascii?Q?AZ4K1hdy/EP+M9BRD7DEOXMN/d9C7PyHVpV+KJv/iQ8IJHYGS0HZrxYqcO2z?=
 =?us-ascii?Q?QYwwqIsQ7QeulitB+VeZYOxRLOFGm1K80fnclI7c4WtoEj5RJAdAz7Ziqyi/?=
 =?us-ascii?Q?ONZQ00ctWI43NEYVAUBdj2DmpNCVrdF70KA8cOODPnXkYEXY2HVcoWPpKshS?=
 =?us-ascii?Q?hkkoy9KELThMhEsyEc5pjvbDZ9IEfroyx6vfSWv7+90eYQoinqAKL7QP6B6z?=
 =?us-ascii?Q?kuKeF7VFfAod/xay8vyvonbu/kkH13w2QjsCNAPdET77FEsLjJ3CQsbOdHHj?=
 =?us-ascii?Q?ic7Z+eTl4OFtp/OZMur8J1qKwRjcxA0sJMrHBC3H1iyrYNIn1B53FTD22/yT?=
 =?us-ascii?Q?EgAZl7Rm03QfVQirkYJcL3jekE9i?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?X3qdCsZR6cOyVKnoEMniCMNjML3dd9v46uby5C+Xdi2BGTOh89y9xhsNSODW?=
 =?us-ascii?Q?MGMX+3f9YcOtSOatUIKP3NyJmNz+vU7EbYvDTtW9L45Oc71mYCixUZ3Fdd4m?=
 =?us-ascii?Q?MHls51dHlJO1OfJMEySEw1bJ0iEhSpOs3mHVGEZCShwcn+3Hg6KkUTCklqjj?=
 =?us-ascii?Q?ksHRefMLqWSkwnyaN90DqQLLT1VYSjVXW1/wbcB5wtNeJ24yB9/Qx1biSK0L?=
 =?us-ascii?Q?TpQf+bx6JQ7ZxnPl2eMAnikhmYGj3jDNmx5OLguuhLGwJ107cS3q3ikANiRt?=
 =?us-ascii?Q?9lvwRHTssnfpOSDb7Vm/pMMmNcIl155EWzRWdOui0k7lc3XRW8+ZJCFVDHSs?=
 =?us-ascii?Q?l56dTZ1yf5cn9qV6d7LFHOgOLabaYfbFtsYFOJFltxE5BPLSzLFUnDqmULsh?=
 =?us-ascii?Q?n2a1oHSZp93S9h8xYVWG5IUDet87LP1YLBhQQNPU5e7wZU3Wh3Z4yVEo78KB?=
 =?us-ascii?Q?ELv4gbNY850krq06aQcuqDZ//M6ylFENoKH0QLflV1H9EXDMv8cUb+ApI3JZ?=
 =?us-ascii?Q?nsYKtDadb+gsp2347QmiJsgWoAo881h/nOPScRzWsjUTNcYs4Tl5uq4Tf1xA?=
 =?us-ascii?Q?c7NkSshiKVIurOTBeDLCEcIqgYu3vqZGl+hTgwfDZaCfk9BBQEwKUf791dEg?=
 =?us-ascii?Q?NR+G8X6r1z5KT8XHqbE3LFTBF6kEPMFeSMhga3qAtorQo9s1ZgEvf7RDWIWl?=
 =?us-ascii?Q?VmJuO2C2Z3XqbhunGtlOJwLQ0antVl+0NJ8BbD/DFc1NgLmtTVK24rfOf5r/?=
 =?us-ascii?Q?6iu2tJCw0yBeB59LKFPwUYe6wC6ft0UVIUN4gUAPu3b/lT2tcMBBlEZHO/OW?=
 =?us-ascii?Q?9cG+Yqqefxad2Wbi9l4RdHCE8MOU6OQYdh7bAaBDD953qIGWQ9MRZ4ygbnJD?=
 =?us-ascii?Q?/Mduc1i0rmsz2wEESFZbFL3flAGz/dTgqarR+4Gi2H8j1N6GQ47RB6csFhZ8?=
 =?us-ascii?Q?xUuUOyDiJ2XejRLZ8zy50XKriTSrTK2ZOeEhPzaiytfuc5jOlwFyiuRaBxTd?=
 =?us-ascii?Q?sHMBheOF/rt7IRtVVKUJfhgUselCFRoKdImrzhMsrsmuBWP7K+viDPqcd+40?=
 =?us-ascii?Q?vTzZKu1DgqkPJjRemKNruvOljA72b2UxXTZKli4HS2+EC7kImFuzCxnqtGCI?=
 =?us-ascii?Q?0Hi/uSmFCRsjR7H8wHLAJqnKLdzfQPpn1j9GUJHoy3njI60FK39Y49DIrrSX?=
 =?us-ascii?Q?TUeWhcnRlxYfsKaKuyOiSx7//mePNcwhxy2yUl+SeZXRL1vA0MEWa/o1P+1h?=
 =?us-ascii?Q?Je3KR4Hz+mzMp5GMWQxscAwlI4PUVjLukbWJVVkXLt+8HnM48SSz8fM7+6sS?=
 =?us-ascii?Q?PBB/T2yZ1ZgOTOPCxbfF77YLgWDyP2dOIqILv2pazgOvZ4f3JQw19AfTKoWr?=
 =?us-ascii?Q?ogtfzGtSFpHIQ21eZepuppMPnrZxe+13OBrVRwdeOTytnogSN20mIUhONKBp?=
 =?us-ascii?Q?hazgJjkez6UdbGtFVwVlK0+nU577jIuMGVSK/ZRrVnGAPCkoAFRsPRc3khN9?=
 =?us-ascii?Q?oX3utbW2CIvnBvDSec9eQjN9UtBmB9VdnJvVqo69kIVe5D5AtCimUXUEkRVM?=
 =?us-ascii?Q?tj6lc9U9EbF0R8bHr37Wlzb6xUbVRNiR1TBU8dv8?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a00cf92-9de7-4a84-39ee-08dd03dc2bcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 12:10:31.8789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IvKTTG10x/ZcI5PxYd94Mas1keSgwb2d86NVT6PGKxMRzx40B5zz6fSi5W0MAn5G7DQrR8rZpdrKllZ05JwhKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6824
X-OriginatorOrg: intel.com

Hi Yazen,

> From: Yazen Ghannam <yazen.ghannam@amd.com>
> [...]
> > @@ -1954,6 +1954,10 @@ static void apply_quirks_intel(struct
> > cpuinfo_x86 *c)  {
> >  	struct mce_bank *mce_banks =3D this_cpu_ptr(mce_banks_array);
> >
> > +	/* Older CPUs (prior to family 6) don't need quirks. */
> > +	if (c->x86_vfm < INTEL_PENTIUM_PRO)
> > +		return;
> > +
>=20
> Is it possible for pre-"family 6" to get here?
>=20
> Family 5 is "ancient" which has its own MCE init path. And I assume anyth=
ing
> older doesn't support MCE/MCA. Is this correct?

Yes, there is an early return in __mcheck_cpu_ancient_init() for Family 5.=
=20
However, this code explicitly indicates that "prior to families 6 don't nee=
d quirks"
and addresses concerns like:

   https://lore.kernel.org/all/dcfdba92-7004-413d-8011-12771636d11f@intel.c=
om/

> >  	/*
> >  	 * SDM documents that on family 6 bank 0 should not be written
> >  	 * because it aliases to another special BIOS controlled @@ -1962,22
> > +1966,21 @@ static void apply_quirks_intel(struct cpuinfo_x86 *c)
> >  	 * Don't ignore bank 0 completely because there could be a
> >  	 * valid event later, merely don't write CTL0.
> >  	 */
> > -	if (c->x86 =3D=3D 6 && c->x86_model < 0x1A &&
> this_cpu_read(mce_num_banks) > 0)
> > +	if (c->x86_vfm < INTEL_NEHALEM_EP &&
> this_cpu_read(mce_num_banks) >
> > +0)
>=20
> The "> 0" is not needed, since mce_num_banks is unsigned int.

I don't get your point here.=20
But it needs to check for the case where mce_num_banks =3D=3D 0.

> Otherwise, looks good.
>=20
> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks!
-Qiuxu

