Return-Path: <linux-edac+bounces-2247-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 469529AEE23
	for <lists+linux-edac@lfdr.de>; Thu, 24 Oct 2024 19:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C02251F2194D
	for <lists+linux-edac@lfdr.de>; Thu, 24 Oct 2024 17:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C061EF958;
	Thu, 24 Oct 2024 17:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cllteyzl"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA6A1F76C7;
	Thu, 24 Oct 2024 17:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729791227; cv=fail; b=nh/D8Wwmy8jbsn5LLAqsMw80TqXjiF1qnpF2XY6U0558vD2Oc+cD8B3LzqPjyfdLyzjdLAWsY0VK23O9eF1MdE+pCBxlk7pMLfbZHODGBYdBRUUKtVMH5Z+5Ph/3ZPbfT7HgPHDVA5LeVfOYpEc+aUbKx/unYqSJ2kOH2DuXUI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729791227; c=relaxed/simple;
	bh=UI1ujzaK0+MDNADG1Jpu4WDRHq9AVJOdSy7ABnui51k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ONB1PjX93GNX8lufQzcVCzJV2M7lkRbpVmbXWisiQyXgDv9eiKzk0YCc1wghAofpp84J9I5yip5b7seIE8SxQ9vopRcJu3NvbVaPWZIhlRS6j3q5FwXwMfWYsJ+Kx5B0bZM4ZKKDOi06zI/BDfjDAhMGPLVE/G8ngc4S4u98nEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cllteyzl; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729791224; x=1761327224;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UI1ujzaK0+MDNADG1Jpu4WDRHq9AVJOdSy7ABnui51k=;
  b=Cllteyzl7P+IvmTVdJRbAILovFkxSmMMO9Knj6fElubDInbPgpxzOzlx
   62fptvIDQXf9Xi9nW+fNj6SLXopETpvqN3ckzRWOvz3Dp+K38gPWxRUU5
   1UoVEo7hsUPpfRtKYjZDGvODFh0bpUt5RFCSPrNNck/twKBjzIq8Gvm8l
   ply1qUDw8rwCTwR1PEEbQ9S+oIWFmpAFNX51ACgl+EY6aGWIOLFyCcnDv
   1DL/WnTlxG0JQGxUcKqSSc7UkzE8Pfm0ghQ7V3RHQiDOGtNkztZPkm5eQ
   HRCy8d7KovlRZTDTpdvXukUWhHZfPw9d41vWH+o2rS9isE/kfMNa1N3Xj
   w==;
X-CSE-ConnectionGUID: I/G+fwN6QquTaCB4iQbbKw==
X-CSE-MsgGUID: peY0HnIGQgi+0aby3i2iKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="17066519"
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="17066519"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 10:33:43 -0700
X-CSE-ConnectionGUID: 9YgL/M7dQtOEwgj5wx0byA==
X-CSE-MsgGUID: c8GwPxByQKu4Rv4wA/El/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="118128195"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Oct 2024 10:33:43 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 24 Oct 2024 10:33:42 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 24 Oct 2024 10:33:42 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 24 Oct 2024 10:33:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=US+4KDFg7256pweGby00cU7Sk/6+AT8Yj6vZbfOGLT/zWH9PNGXGPE3Wc1TXPzRICakxvZPQd3zxHZLzK5nZ6OkwWwLE1ylznaBps177F8YxUyFjzZFEuCVxIof0ArYbiv9eXHA+LTQW0kpj9F+3ut2I6KyTAxzgiaF/txSUa3lHX2sX7JZtyIxvpIsLIeRKM1BzibAx+n6RH1G0oMNCZYqy9Qwfdf682mKXoVWSUxncKynaIRsMZkrSqFfDZmnu0tLiKjhpsg/h+bLi1bz8wEUtvwjWvtnadbtB+HCxG15SCRLCW12jsd2wB2cMnX6n/qlJ+Ms7lnAAuUj7wyHGsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u62SL1gajq0RvCgtZybPFX6vTG/9lgxQdLTQeflRauQ=;
 b=sUZsIfoFciK4oMQklGVKVt5iG92N7hrADDj3XjJ+3od2U+DQ4Sr291uRmZnSayicerWz4WPGpe2QzXHrueVZLrFF9a66h0rK7SFoOKTHlcvGROKudJooUOgV0fUh3xGkwUGevTOpFirpfoSC9Xsjn94ctQODT/SRqT+0Pz24tqQ75iUDC9QayF33otSMbLWCGKIt+AeSuzwFMwMEWtS3uRfNyNrvp94AwozI1uV/qqjwdlbgm4/UC1aO7uwyW8t40tRM4Bwede6TPW/6W1Rrw7W92a/ayfmsGec2pk/k0787tXA5/o2i0bALu469dGFu6kQWC7mBQpRWdV4E84v/cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA0PR11MB4765.namprd11.prod.outlook.com (2603:10b6:806:9b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Thu, 24 Oct
 2024 17:33:39 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%4]) with mapi id 15.20.8093.018; Thu, 24 Oct 2024
 17:33:39 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
CC: Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>, "Mauro
 Carvalho Chehab" <mchehab@kernel.org>, Robert Richter <rric@kernel.org>,
	"Garcia Rodriguez, Diego" <diego.garcia.rodriguez@intel.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] EDAC/skx_common: Distinguish the memory error source
Thread-Topic: [PATCH 1/2] EDAC/skx_common: Distinguish the memory error source
Thread-Index: AQHbHtYnIyaHSUhLvUuHcNLkD80CIbKWN6Og
Date: Thu, 24 Oct 2024 17:33:39 +0000
Message-ID: <SJ1PR11MB6083EE82968F5F6D8C8D2B84FC4E2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20241015072236.24543-1-qiuxu.zhuo@intel.com>
 <20241015072236.24543-2-qiuxu.zhuo@intel.com>
In-Reply-To: <20241015072236.24543-2-qiuxu.zhuo@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA0PR11MB4765:EE_
x-ms-office365-filtering-correlation-id: d8eeb7d0-323d-40e7-9cdc-08dcf451ff60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?YZHHccROFoG8SizCZP1/4NaO+RNdXEo3KcK6nM/g8Oxz+IfwiUUFxlUrKG3I?=
 =?us-ascii?Q?ZqqwPe8eHUnpo/4QLEM0taQMw1A78jAEOj6McCMGirJDnMQWfQppHxhuPh1s?=
 =?us-ascii?Q?QFWRpiM32K2ygMlVfgya8qUrgurRvuVPjWWFQo63vcxigJ/VycKjZQ70BopH?=
 =?us-ascii?Q?SDEctJ9w97tnx06iNw886w8vd4awrPz8ytAJ+qtaqFi3OZSq/YrngPeeyhB2?=
 =?us-ascii?Q?AT9xQwODnjDO0Ib3gtMM5YryKUK5Iun3/irU1ktAtzLrykNiULcYdd6vskqC?=
 =?us-ascii?Q?S0ZcHQJ8Kt/gbI1UlxFkxBePhpLecSs+dLmfKDshakSJibgQfE9dsWek2qX4?=
 =?us-ascii?Q?a73KYjg/6o5susyoaovd5aXM1N5xwUhta2IwOhJHVSnNrAiO13aJXm5iOgdi?=
 =?us-ascii?Q?FvQkEWEbL+Bxkfy64JF11UGHEo7zt9QF1Le1/8VsCYIZfP/nvE8xLd4yhkVw?=
 =?us-ascii?Q?8tQHT6vMe9NyuPC8ITXqeyYFDlsxAl+CjFQt+8I3K/uM27VD0+dQkrnsdAuu?=
 =?us-ascii?Q?90lfkH9nzLTJ3J6pexXxAF8An8+BTpnJDFTB/veERvwgeq5g6NwwVzhQsUJ8?=
 =?us-ascii?Q?Z7Yoq0kAbb2bmKJrsjO5nubr9ZFXJHolkfhFZ5PFYy7DzNPqBtNO1YEEeoq9?=
 =?us-ascii?Q?9AtYTYL2E0u8WxwiEMVbyKm+HqG855SyfFExDrZMTuflzpPRYpoG04JK6O14?=
 =?us-ascii?Q?RAI1UQaepmQXe4Y1t4pyHBduJDpRq7Z4tZ+FLzxZQz3bKaJXVSYGEh8wdCsi?=
 =?us-ascii?Q?hQmKzsXwnmkgw4iG+epFq2I60E0ds2S6Q+zFAn5RPj3pDQ8PzLgBk1+DNlJJ?=
 =?us-ascii?Q?tVtryf6twWTC7y8wkDfWrv9OYGkQKwNGeUKlbfb8kxYPDWapaO7ypQRiGltq?=
 =?us-ascii?Q?GTUC/vClk2cYJDxj5zTotlI8+5YueMQ1kattsJBBiTS6RukoIPtJKWx+zJk/?=
 =?us-ascii?Q?XOfKEyM4UyL4atB0MK9keMpwVT4yUaFFG6Styic95RilolUyngqGc3GnJVwE?=
 =?us-ascii?Q?a34Um3N2d+uG32hQBrDB49rxUaE2Y003Om7PaeIEI9FoAYr3mCWjKu8+L0/n?=
 =?us-ascii?Q?Za4cStBfRGpH/9FzIFbsOFDWdMx7DgNpn/6TcXZj0oAh+mg6U/j/OathVcbR?=
 =?us-ascii?Q?4naF3dKVIcmaTn8vZ/Xt77Spsu8bAXIaHGBxrsy3hktuMpSwHjoJv6w8WX4T?=
 =?us-ascii?Q?8pZDIObxKJQ+J9RoAB0oZCK3aJqCjMdqIKMBZUNHTSW1FJj8wP/0qsG0ctmF?=
 =?us-ascii?Q?ye3GUHdyAJjy+/wd3MkTiko/ZqQDGh8TO+/5vC3oN4hy1qGT00wshoBVI8X3?=
 =?us-ascii?Q?hdzrq3n+LV8E5KJpKoERXr+S8AAyp6OAKGg+4L9GYRJkgcRUOR1vd1UaOvi5?=
 =?us-ascii?Q?mmlPz0o=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uXmefOQ4XfQ7/IRw4jDrXAGfofNX+Xiy2kOwJmwg95Pv74RRMCm9Sr5ee4vT?=
 =?us-ascii?Q?x1Ew4v5zHwmT57iApkfi/WT/nDeXT3Lg9nwKi0wZ6zJ5kg4AKT018puctH6T?=
 =?us-ascii?Q?sNj9s/KXk0pOANA93OS1+NHlB8mMYOt77lQCEjvLjiMcmGe3pDtNo3bLZW5P?=
 =?us-ascii?Q?mabzAtnvwhI1zHTz493W8+oAa13SXTEKmXIck346t378P4BpYw+h1mSqSqWA?=
 =?us-ascii?Q?ehYrfplQuyARwtIUWqWI/L+83LbB3x8THbiycLk2JMk+STvzBXm+eReksXKb?=
 =?us-ascii?Q?bUODvxAZReqbTn0vQ75VURDFUkuPL8hiaKNONUvI6HeSrRET1hll0Bb93iMG?=
 =?us-ascii?Q?35oZyJWP7sCM9nJGsSL5yOdIWg/PG2uAHafAZ/VTkN0f9fa68ojEbV4N27cA?=
 =?us-ascii?Q?QJAmu8pzSowc2UwgEDSCcsO0EHA0prI+H/lt9yoPoA+yXDgmAvYs5fUUv5zH?=
 =?us-ascii?Q?jZ1Gk6uzutnXgCGZDPyVkZEqFQjr9Ij5y5VJKBFCCJdFOMUQBnkIWT9zc903?=
 =?us-ascii?Q?jBBjf7zMZwKSajk+5v45uy9o1bvZfPP6Qvl+ChF+I6x9OjniCWgdfi4dkVzO?=
 =?us-ascii?Q?tvgY+/JUTqDBHCcqR7zDEcTb2D0O5KgeSKxHb+XD9j2WlRCxecf8MqvpNd5K?=
 =?us-ascii?Q?c18aSQ5DaknQ2WtG3fKweH6DhhX2pKv0Yxe4o1PM3kGaxDgsuWmip866QfGi?=
 =?us-ascii?Q?fd8q4crc2tzd9cG9+BUq1PYRWo5iyhFgz81noQOn0pyeZ6OTXnQqtHhk98bF?=
 =?us-ascii?Q?2POfxsc1G4lMR7ogvpZFYvDr6P2krBXsl3ur1syqEwnVN1gWVjJvSWXn2gDF?=
 =?us-ascii?Q?fWKLfsOU+4yWvGXVK8x+jvvvRUITHYEY4e5zwkTmZSf4X0t0sX1vQQaFTA1C?=
 =?us-ascii?Q?oxcbnP2mEtL0OZUHx9YW9fEYz9wcdUOAdz5hArZT3mn/7Nb4EQmfLTtvY14F?=
 =?us-ascii?Q?0guUqGZkFP5a9yXygpdCdL9hYh+0bFMtyiA9xmOC7COmfKcMOkzAl9vjXGA9?=
 =?us-ascii?Q?cuswYGbnDCKUgQ0UAQj5CJNveShM770UiOsU1Iupu+Z1KMLxwQdzDlZ/WJAz?=
 =?us-ascii?Q?/bXc3mWIfzO1y4ymav8mMvAUT9zs1fSBDozBCc4PpB/DDmjn7PsCjhpnL3lw?=
 =?us-ascii?Q?RitW0ESt55ZeWGxr1g/CcIhnqGnGvy1ji65M+lo570B4B1sP+CAjgnj8Wl6U?=
 =?us-ascii?Q?pLhBJBLW1Vmq7xWjRK8cRRUvU+LxQVw02FZFNRkWwV++C3WD6mLSSDkFXrND?=
 =?us-ascii?Q?v3acz7MT3whmUFamwnU5gETU3JMUgTRpfUBo5tqOz6S5hy+kKSqP5OyA4HS1?=
 =?us-ascii?Q?xXtCRP1b73GFDDIEQAtsaVhKRpaJgQppth7yk2nCiUwU5rLW6va9ZMUY9OC+?=
 =?us-ascii?Q?pfL+vrdIDsI7reXCAhGbMJ9VnoctMaEu2GLgmINTOjMkR2d7hPf6uvnQNazc?=
 =?us-ascii?Q?eqIS+EzmTHaSCev08N+kv66fWQHezkFEn8TivvCsom1/EHhv3goMOlR80xTL?=
 =?us-ascii?Q?NnLyUV4VRJw75Tb1Ppm1rjX4wHc5uRq5dwilAqRifKPrNRapdXtbf/V3XPn/?=
 =?us-ascii?Q?JjFQZsbyGHaZrhpGIicrA4Vg15jfY7GHZTa0+al2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8eeb7d0-323d-40e7-9cdc-08dcf451ff60
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2024 17:33:39.3537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nejiDhgxzPbcVZVdbfT3dKzKCCtWl1EwKYMte5JqtJDUEVjoyorgxjt7Hsj78LWckrmQG0QDCIs9EPvUXdNKzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4765
X-OriginatorOrg: intel.com

> The current skx_common determines whether the memory error source is the
> near memory of the 2LM system and then retrieves the decoded error result=
s
> from the ADXL components (near-memory vs. non-near-memory) accordingly.
>
> However, some memory controllers may have limitations in correctly
> reporting the memory error source, leading to the retrieval of incorrect
> decoded parts from the ADXL.
>
> To address these limitations, instead of simply determining whether the
> memory error is from the near memory of the 2LM system, it is necessary t=
o
> distinguish the memory error source details as follows:
>
>   Memory error from the near memory of the 2LM system.
>   Memory error from the far memory of the 2LM system.
>   Memory error from the 1LM system.
>   Not a memory error.
>
> This will enable the i10nm_edac driver to take appropriate actions for
> those memory controllers that have limitations in reporting the memory
> error source.
>
> Fixes: ba987eaaabf9 ("EDAC/i10nm: Add Intel Granite Rapids server support=
")
> Tested-by: Diego Garcia Rodriguez <diego.garcia.rodriguez@intel.com>
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>


Applied (this one and part 2) to edac-drivers branch of RAS tree.

Thanks

-Tony

