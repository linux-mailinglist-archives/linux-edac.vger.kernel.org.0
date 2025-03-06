Return-Path: <linux-edac+bounces-3288-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AD6A554B4
	for <lists+linux-edac@lfdr.de>; Thu,  6 Mar 2025 19:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F6FD1641ED
	for <lists+linux-edac@lfdr.de>; Thu,  6 Mar 2025 18:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8877826A1DF;
	Thu,  6 Mar 2025 18:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AJa7sSl3"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB49625D914;
	Thu,  6 Mar 2025 18:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741284961; cv=fail; b=EQs5Gom4aC7V8D+3FUx39SQunonrNBu0Q9vIwfAsExDX48vnZLgM+RjJsRiRXKjJs3OdFPdoJTxLRgkCuCJBKoUbondEQJOgruVCzp5cdT2uwHSunCRyK6UZwT+SBTt9xqYhLIr6zzpJMCfGzIM0F52oqdzTMBv0RL0DBU0Jc+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741284961; c=relaxed/simple;
	bh=A2XxSCik7PjU/07uKwqozX6cxpUKPRf6ZfGn8yM1Edg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nsvy3re5N6EJ6aVrhRzxy8IQKictdvgaSDYpZ6gKK7h114t0Da0wJizs/n7dkmaCSLXZYsAWLow9qy1Dyf5N9eGwLf9uhZT4Z6u62yHJFHOd3gFtKroGGwCBi5M5ysJgR+lwfKmoQM5q8G3kotuwsqdKahjgoGjlxOsjmMysTx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AJa7sSl3; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741284959; x=1772820959;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=A2XxSCik7PjU/07uKwqozX6cxpUKPRf6ZfGn8yM1Edg=;
  b=AJa7sSl3gw2aH+KcoyFMgh6D6qJ1Nh7qfAqTijqYLlQ0/vaZktmVFWr/
   PVbC3PU7bibJdWK61VHK2dJY6CDClExSNFA7tqw5wTmhfGFIOfq0x5rJg
   hNixO/B/xOX7K577YSvqWAHOJQCeim2aygK1BRJXt0BirZMjhgYCE+bFr
   rcTY9ep168GaW3ED0kfL0rsKhFFdukHP4X/+nDUZpUppb/CPAeS3Y0ZUT
   ygJLusl65LMMxkpFb7WeI4ry4oWJgvgBGAHCmvBwwWdMWnAqqxbjZ7imp
   CUgz/p9ctjVznCskR77Mx9GfSsxwjJQ1QSJHnR6b296+ys93sgm3Tl0tN
   w==;
X-CSE-ConnectionGUID: qZi0U4UoRwqAoaSj55/oyQ==
X-CSE-MsgGUID: 7ns/cUhSSD+m0kWIdPzqhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42449468"
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="42449468"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 10:15:58 -0800
X-CSE-ConnectionGUID: IHdatwMDQnyChgrVO+o/AA==
X-CSE-MsgGUID: v8FtCmm8ROKHNiZ3RHwbMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="123689971"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Mar 2025 10:15:58 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 6 Mar 2025 10:15:57 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 6 Mar 2025 10:15:57 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 6 Mar 2025 10:15:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XlJSwb+gfjl51uQ7Y2hbKDtehO2f6Vm8yXFzqSCPQBCBWlt122yFYcEGhVBTFmzZ3i397ciV/Y9S5vLPDrvgQMx7UUXSZoR+v7h4ec54NWcDm736rO0drpZT9i+ckkqFOPbPLZW/nvnJSNegYTHp3ogt0wxKu7ShsiXWFAkr9agfW4bSPHzEPH9FHv3k3ip1Gi3dG8wAkIZJ2wS860MeM1ygfo8OKn/ZNG9VvZCZgCtUarmrcoyyJBfTP5uCi/NaO7W18TLAC95I84AyDAffBZNPyCrHLoFUHsYfaGsR9C7eR6RlA8npk/FKr4gvKNKJGifsfrm/1+QJLyoEEDlU7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3AcUPrZLyu/7G+Dk4HclN/sk7+gwRrigoDmKmzYslc=;
 b=zBt4oJqZEPQVmGzjZgBf7Yt9MPuZp+lnipCCqC/hqFCkgMCtn2N6asSvx9I8FloLC8z0jLIs42nU2rP34w43hKKuYQVztj5eE7SFJ6TeG/ir8/OxPV4GsjlnNkf2jMSaBwOgVVdmkpU1EzSwa2en8ocluBKbHSMSwhLCify0KMZeFIvxCWj8DkeEbAnra5fb9eU9ezyAW/xVNJT71/TMerBlxj7AQDT35XrXFSSwSIwT1RX+zZA0GSlVBro8rQ3I43gTlcc5inEPxiZwlYLdWfVLoH78HFLglcJ+4ydwbH1qkTBnkUHSmIRVGaCefzuBxUHnw0/r9U0/U7YcARzBlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA2PR11MB4906.namprd11.prod.outlook.com (2603:10b6:806:fa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 18:15:26 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.8511.015; Thu, 6 Mar 2025
 18:15:26 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>, "bp@alien8.de" <bp@alien8.de>,
	"peterz@infradead.org" <peterz@infradead.org>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linmiaohe@huawei.com" <linmiaohe@huawei.com>, "nao.horiguchi@gmail.com"
	<nao.horiguchi@gmail.com>
CC: "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "baolin.wang@linux.alibaba.com"
	<baolin.wang@linux.alibaba.com>, "tianruidong@linux.alibaba.com"
	<tianruidong@linux.alibaba.com>
Subject: RE: [PATCH v3 1/3] x86/mce: Use is_copy_from_user() to determine
 copy-from-user context
Thread-Topic: [PATCH v3 1/3] x86/mce: Use is_copy_from_user() to determine
 copy-from-user context
Thread-Index: AQHbjjz80HPRru3Yf0aaSKSiikfocbNmamMA
Date: Thu, 6 Mar 2025 18:15:26 +0000
Message-ID: <SJ1PR11MB60837DE67D37F45B0D106C9CFCCA2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20250306021031.5538-1-xueshuai@linux.alibaba.com>
 <20250306021031.5538-2-xueshuai@linux.alibaba.com>
In-Reply-To: <20250306021031.5538-2-xueshuai@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA2PR11MB4906:EE_
x-ms-office365-filtering-correlation-id: 27b4bcac-d273-44c2-3c9e-08dd5cdade7e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?3fxY9AaX0FzLgUty9O2p379T54S7wH/n9d80L9Ao7ZMa9qo63cZeutLBrulA?=
 =?us-ascii?Q?uTdvgENe8lhRDrsn8pxp6zs4Bf3Cj5EkAZ+E+rhcUmtWZKLEPJP/w9hUSZWi?=
 =?us-ascii?Q?BCUiIGqoFJXf2H80I3u7YIsmbw7wRE0jTEVhNunwrUUJDKsN14DM/y811f7y?=
 =?us-ascii?Q?TpwU4BSNjTr1b0f1fSA+Uot30OCZqbUOTqZkiTBydt5Wem2qiXwpDbTtNcIe?=
 =?us-ascii?Q?HBEuZNDsMtDS3DtFMHEvagIFF8YO1qR5lTF3Zh9GML6aHe5OnDv43iLc37Ve?=
 =?us-ascii?Q?ufrKzGMoMWDEBFykE9sKBi1h6y4ozDAACS+Zw5N4SvK6B45Uyu7j2GgajKG+?=
 =?us-ascii?Q?ql7BO/Zgipqg+hTZBS0dkEKBG1y1trEHwjjaLNaqDTyavLad9EZt6JiwWccv?=
 =?us-ascii?Q?tWtof7A6yUpyzvPi2jyDNcmDv3RTo1Ur18l714MgefbSzZ3rSJ2F0/I5giiS?=
 =?us-ascii?Q?52V+Bu9Q9qYjK+8kaaDvs1aqJwGmR3TJSS4aQ/Hg4fXkMrcMxb8M8V2smX1r?=
 =?us-ascii?Q?U7QJQ08aMnvF7FeavEUOgoHnt5IsTZGse7HpWspgsezOiDgeR5cqyF9jewwl?=
 =?us-ascii?Q?b84U5N1/634J51y5OtBSY9LntpXCQbdbMGXTbOY3JVWSyHtn1SE9tmOxCkaQ?=
 =?us-ascii?Q?ZRvpMKPhs4Jy97CfMQQZbkKossYf4KV92PY+vq23yFf9aifvcwaLdMuICBEt?=
 =?us-ascii?Q?GklzhbjS8iyvQrSnM8ujOzVTOoEPijdTQvGqM/RCioiVid057uaPeFx9Z67/?=
 =?us-ascii?Q?6WyyVG5tSNK/Ijy8d+vVqiaBfrDa1Ck+lq4KfaECtS9utGv2KKfFC0QaX3vj?=
 =?us-ascii?Q?Tntf96gfBXzyu4SUgqHOQCM9MSDh/e5aEDHE+1A6CxfLJx3SaUij45hjSPVQ?=
 =?us-ascii?Q?mgx81iegVIfzx6dP8QYcrf86KXQiAQet3DMKknXVR811EjmOEBB+ow+Q/C+M?=
 =?us-ascii?Q?jv4ni0K/9d8W8kriXvCJGg+QFV7YyhI85HWcelCYsi0/MhvhH2K/lBm9+y5M?=
 =?us-ascii?Q?8Hmn6cmVWASDUTH740ubImU+2rPfhvIUMP/3axJx4nJk4gktlLj5EHOdITVR?=
 =?us-ascii?Q?Tqdp5VwmPWNaddZtry01YkTuH9DJ/Yfs6+iA9Z/2qY9FQDlHpBvS285Yh7FA?=
 =?us-ascii?Q?4tAxlWgaVUDfoZLhdsu68MA4ZTNB5maa5gibELQwVA/+IhtTeaLkpUsWksgF?=
 =?us-ascii?Q?MWwcFYTkOXWInegJq+xsAgBAA4hkZxGIu1GyqkBxFWmE//prvfjQya86/0xM?=
 =?us-ascii?Q?yC+TkihfBfLgYVCWYigx70kh7hsVpYbf4oOwZz5rGG+DOQ873o5Y7ZXFMV6P?=
 =?us-ascii?Q?at3znTMw9IbOf4S57yWyenEbunqDh+eICjaY/4w5n0BGmBvFhW4i91j5XTdQ?=
 =?us-ascii?Q?Z5A+kOpyr4aW+fWtFWm9MYsSkkvnJtIgi8w2BpgIAtAylbAwZ7RTGfzdb6AZ?=
 =?us-ascii?Q?vXdoNYqDg787HojsozsQUuMQedcZ8Ldn?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gna7kufM/czUICpBT0UMvxsOKWSarDP+q3N/zHZh2yQz88WRDeDJptuvrxxC?=
 =?us-ascii?Q?JcO7ivYnihTl3welJWmwrT/97EFdcgP0mU7pcEi7tIzizLBt711f6sDcY4Wk?=
 =?us-ascii?Q?kZggWJgN1szDiS8Sk8VDrB7nOOm991t7ORYUV9Ccw4/A5yRAwoLDRxiRGGcj?=
 =?us-ascii?Q?o9HfeNeAQutJf7E0X5UCDbZHHon3PO3yvdURWYsN1f3ZlTMwCgy9opqXWJGd?=
 =?us-ascii?Q?kyI6mj0/BkaCTTi2BQe9h+02jsFy1XdzsrzBtg6V0JWRweIK2O/q+zhreWc8?=
 =?us-ascii?Q?xrbaLFl6SBnmLSQzhpTxkcuVNCkN/WzClBUu+n/xMQo+jbBxNN/qlO6U6eAw?=
 =?us-ascii?Q?S9vF7oj0FPw8GkV+YxcLmzlMC3E1VPKycNazBtQuIVB+BLAvPrG4juDVkHKE?=
 =?us-ascii?Q?QHYU8Mfyv9lbJ/xQ7B5kGyZG4DHjQU9drV9DYXsvz0IFOHPods05tYEbuvG5?=
 =?us-ascii?Q?2MT49jAHnbdNeVICZcf3HsB8rIALiXxPoO0kXbN00pqd9oOfwFtlxGop420g?=
 =?us-ascii?Q?smRn//9o2VnbAO9LrQA/Btziqfzy46Sa2TqaNwSUU2XpkoVhWb9apIjHUoqs?=
 =?us-ascii?Q?p0rj6LsUZhsr9jt8SKb4dQStQ/DuRT0qP4IBswIsfqBcCnunAonQfbPawxs3?=
 =?us-ascii?Q?VJBHO1IxiXiSTw/UmiuC1IL3NFZ159mDNT4iIvFe7wGkVdFW5pPdbYNEQjkb?=
 =?us-ascii?Q?8pmcs61yfy+LZYCPmGzdR70C2TJfARuToNv/NdiskiEUxs+XoO9NKIARrvJe?=
 =?us-ascii?Q?YZWymkOdXqk9SuT2x9N2Yuepv49h47D3Jk1IvCZHz1vgNSwGJdx/ynS0Ma3c?=
 =?us-ascii?Q?O1glXIuj6k376n5I8rujAfNMCnVz1lCmcTc38VJcfARxZa7gOj8BB9jKhQlq?=
 =?us-ascii?Q?amUbjMG1LmuuWOiVAQA8GKSbw4bNEvJ8CB4kIGt4+5qm3qRWqliI4kmX33X0?=
 =?us-ascii?Q?uHEMVX0n6uWC60Mh+wof0ndj8HVTHkNhDPDmZvOIOcopeMWTOTR9rGjvX2wr?=
 =?us-ascii?Q?Rj8PMdzhx05OpU005Y2wpq/nzWwy0ioJYt1EyTJRTlQdIj8GwvAquxmloMYp?=
 =?us-ascii?Q?KoF2TjrdNuTnDkxDPf0mxkXLjgjz59SIQcOgZtvCTDEnsngLcJNz6hQty9ee?=
 =?us-ascii?Q?Ly34+G/pCKcpCAlgLRF7EQRJr4DbpSMsZ+rwCb7rOcMFvDJo0HLR74Ieixhe?=
 =?us-ascii?Q?TcQeRXW6RT4zA8pQQ8QmWSsf6ZrMycnCKytthqzSRQg4oaGp1pSGIEsSVDG8?=
 =?us-ascii?Q?js6blzxduynu3LZ3pPVoT29x64PCrFfTlIMY6FT9b3SAgiljlQnioOE3BCi7?=
 =?us-ascii?Q?slXHpUtoOKvlkXqM7XO9GEZh8lsST9lHaFaLOyYEWQW1l+od046Ov4G2DQPZ?=
 =?us-ascii?Q?+rEYfFNUkfVeejSwsbCuDKU1SA4TDmYpDTFVUNY88dPDVNL42H+7v40pRVsn?=
 =?us-ascii?Q?OhbQe6dhRF1BdNVZdBfqUiGEt6IOMnRV99qYrpblNy+9yyVyntiujXPavk4d?=
 =?us-ascii?Q?oh0pj0Mm9RKjRmTyFSnvMESAUTiuqfegpLDFofZE6GJnpNAxdeK7KabucSmC?=
 =?us-ascii?Q?jA0mZGJzojbkdZw3lHDhfSbA6tnABojbrv3M/rbB?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 27b4bcac-d273-44c2-3c9e-08dd5cdade7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 18:15:26.1436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3G1qxyI/naxA28MWDNQNW06OTc2knTN2VPMN6tXHJvJyUXBzXzNHgcYI65u4FlAdt6uaaw4uQdrZmO0P1exi/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4906
X-OriginatorOrg: intel.com

> diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce=
/severity.c
> index dac4d64dfb2a..cb021058165f 100644
> --- a/arch/x86/kernel/cpu/mce/severity.c
> +++ b/arch/x86/kernel/cpu/mce/severity.c
> @@ -300,13 +300,12 @@ static noinstr int error_context(struct mce *m, str=
uct pt_regs *regs)
>       copy_user  =3D is_copy_from_user(regs);
>       instrumentation_end();
>
> -     switch (fixup_type) {
> -     case EX_TYPE_UACCESS:
> -             if (!copy_user)
> -                     return IN_KERNEL;
> -             m->kflags |=3D MCE_IN_KERNEL_COPYIN;
> -             fallthrough;
> +     if (copy_user) {
> +             m->kflags |=3D MCE_IN_KERNEL_COPYIN | MCE_IN_KERNEL_COPYIN;

You have " MCE_IN_KERNEL_COPYIN" twice here.

> +             return IN_KERNEL_RECOV
> +     }
>
> +     switch (fixup_type) {
>       case EX_TYPE_FAULT_MCE_SAFE:
>       case EX_TYPE_DEFAULT_MCE_SAFE:
>               m->kflags |=3D MCE_IN_KERNEL_RECOV;
> --

-Tony

