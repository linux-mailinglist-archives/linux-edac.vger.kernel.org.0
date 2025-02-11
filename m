Return-Path: <linux-edac+bounces-3025-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FEBA31213
	for <lists+linux-edac@lfdr.de>; Tue, 11 Feb 2025 17:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99F191649E5
	for <lists+linux-edac@lfdr.de>; Tue, 11 Feb 2025 16:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DC225EFAD;
	Tue, 11 Feb 2025 16:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OqIBG8hH"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC42625EF9D;
	Tue, 11 Feb 2025 16:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739292696; cv=fail; b=lVvj6oZOqCY/pH66jZvcublkrCNtXxSGj9Ib7pOE9uE3LOEGIwF6xij6J7irWlPi2+P77R4hX9lugz7lvpL8MwhX89ZCkqSQvenNlgRmew748tRj3I0mlC/kKeIGlFsT4AgLAiq5akFSC9DhofBF8m7zXA6FBnw4DF4l9wo5W/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739292696; c=relaxed/simple;
	bh=NQC4Ay1FKPNwS9P5hjip5wUAumafKX8z9XPLrTpnM+U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UhELCXi9NrgkKhuOBJvmnTLmB8M9loUlY0OSPZmJ3sYO4GwJin55a5n4l7sHB7pXAJ4sHzKIESfPKqimAb/TybD5Zu5ZKLaeY4aCU1I+zKSDWUtxHGj3xI+2As1GlpSxbo/IOFgI1fPAxSJN2JqzZOgidLghN3185akE8oaEogo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OqIBG8hH; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739292695; x=1770828695;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NQC4Ay1FKPNwS9P5hjip5wUAumafKX8z9XPLrTpnM+U=;
  b=OqIBG8hHWy7WqlCFUV3BJylZr13XKGwRrpxlP1IbM4rFvg2E5sjq3KXP
   55kJpchDe1x9lI5Ugbk5gmL0R7QKBwOgYObMsFYubAOcHRic+QYWLGKWf
   odoQnUYAOZQrSPZyAsdE0dK+jBHUhrHkv1QWd7sArbdhQ6dZ4HaFok44O
   xEoFH7298+1GZFjxV7TIh+6W8t+W2+DxRiHNCcBcwxDXT+wuzkAMEsqyE
   VkHJPy7F1UewL0J7cXZJQXrq4xkElxzUVAlrAYeKqujhEMHLmUeq2Ww/X
   IaAc/KgGZ4PY1jXpKIzjFr7oGGOrMERI2Ky6pUcdfRm7aYO6Cww1EVkm5
   A==;
X-CSE-ConnectionGUID: 9nHFplrZScerAc1nyINFJA==
X-CSE-MsgGUID: qbiezuLsTq2zDcBesJHNmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="40045712"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="40045712"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 08:51:34 -0800
X-CSE-ConnectionGUID: xIdZiyNTSFihksiBmbdCbg==
X-CSE-MsgGUID: /U9GhPRsSxOvajoqaD3rHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="112540701"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Feb 2025 08:51:31 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 11 Feb 2025 08:51:30 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 11 Feb 2025 08:51:30 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 11 Feb 2025 08:51:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YuC2Vls1cun6/lc/UXDuBkawoZQXZnFSHKjYY+MfLkptiUjLPTZHmLnsULAp41FNNEODHbHyVjqbROka1NvyU9Eziuz/gw7JZFDJcF3YrotCyef4V3x4u1fvYtMHwn5d0Bu1tIJKG/MV/bvHeqVB8FA6sFBmgo8L6pbqAmKnfcai989SyUof8igsGEgeq0eWSW8FKBMNAtjJCkQef7OXkPqF2Rlv8KMkYC27m7ZxQzyciKM/59vJaqKr4fybwF4/TqPcR8zdKmXBfiqGYUOu+S6fqUqs/az5Jz/LDA6jgg3BiWW2OWTsYLwWwND3nDwptvGiNW310tnFgAMxFb47iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Gcz1a3RzgQDf4zNvW9s7CSVUHam1arg7W5segWmxQU=;
 b=S4LuDjHJ+6athO98SOd4GPDSWhD5XjRkq0oVpAspcYyO1XrFDSLFB5/pro04YFL7WrXo7L97DjUdQ6mvccZ56t56il+zigQEr+naBjMyY/h4Ix1v6DY/Ub4dgZeMwY/3tP2d7bj5oTyPehnfeg+BuxePvPafZfpXYkvA1V+HjeRhtPH2K6mTAqTb1hJf+xzh12fpvxh8x8nG0ivMq6fsGoh6i3tdKmgUMj/qI1dAZ7vjQlp0TJOjF4qT4QmvmVF1vGXqO9VsBJ0XK7VXMv1QY80+Z/TT9DgSmErFG4FEb6HQhALKonXM2j7cDLqZGrx+6r4etWOQMnVGVS3tKjR+Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA1PR11MB6782.namprd11.prod.outlook.com (2603:10b6:806:25e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 16:51:27 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 16:51:26 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>, "bp@alien8.de" <bp@alien8.de>,
	"nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>
CC: "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "linmiaohe@huawei.com"
	<linmiaohe@huawei.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
	"tianruidong@linux.alibaba.com" <tianruidong@linux.alibaba.com>
Subject: RE: [PATCH v1 1/4] x86/mce: Collect error message for severities
 below MCE_PANIC_SEVERITY
Thread-Topic: [PATCH v1 1/4] x86/mce: Collect error message for severities
 below MCE_PANIC_SEVERITY
Thread-Index: AQHbfEqI0kYYi86Gd0SpGo1kmZ5OBrNCUSoA
Date: Tue, 11 Feb 2025 16:51:26 +0000
Message-ID: <SJ1PR11MB6083B1BEED49F2A622F8AA4AFCFD2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20250211060200.33845-1-xueshuai@linux.alibaba.com>
 <20250211060200.33845-2-xueshuai@linux.alibaba.com>
In-Reply-To: <20250211060200.33845-2-xueshuai@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA1PR11MB6782:EE_
x-ms-office365-filtering-correlation-id: 59ef65e1-9048-4759-ef1e-08dd4abc52f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?WmUHYbhKoaidvomEL88lcEhMcGb0VF6xhdh6VBlTA6ajtVa6gDN1xELFhD9q?=
 =?us-ascii?Q?QEzElpN+2LCfVYHCr0uD9UQoTIewIsM70bMqWKZbViUlkpTYZfjR5+WDg5yv?=
 =?us-ascii?Q?bsuV359GSpnWA56B3nVw4GzEDsP8SKUKu9KPQ4PoCspl/i+68aE7sOD/IpQF?=
 =?us-ascii?Q?n3pKenQvIhwBfn2iFSoxuQc07OeSw587Ui3FC5kmvyicNdxrfcR3ROh1Y2kw?=
 =?us-ascii?Q?9LGSs34QRi4eoNuh7a5VzcYelptXSM7X7qnKKWyCPpFyffkiIoInxpb1fRKo?=
 =?us-ascii?Q?k0PsHwwMf+n+jfUc0DquNKcxST4+B/yWjUv6I7oL+GuqkWkAXR3/Dg16wWwD?=
 =?us-ascii?Q?7koq8lxj8BN0jFG/WMvVxfOR3jbagHH/PkMG/3J4t+rFMBQ2MSmauEaLTrJD?=
 =?us-ascii?Q?YjlKdgOPpLtsd1N80Yiz7yG3ZRvwpy0ZScxRIaTGAlFgTucDZPKvI8HjGLFV?=
 =?us-ascii?Q?3Ga1QB+WjHqqULaD7Nrj2DqvEKhMBc3qMy5ebOClXajvCQ2j7ZQfwO/VJvq9?=
 =?us-ascii?Q?D7p/5VZj6BZcySWNbwKfFbaOC6B3rPr0T5vUNY3+HmanShwelCtBQXjcUH/1?=
 =?us-ascii?Q?m4jDAUen1uFIJB7gOlKuuXzzq/aj/+cDs6gCcv/ZbsPmTXQK3OIgc1Z+oe+s?=
 =?us-ascii?Q?IeDUb1OF52bbwAZdFV6BRERizENcFZYT6keO37i/PUfyLzHXJS5Stt+ExftL?=
 =?us-ascii?Q?4Xa8aplv6L9cXvam2hNrSSftQZ49xCbmWQ++EhaQvs05LYFCJM3ZvzA4WBxd?=
 =?us-ascii?Q?Rwk6emiUSxMW+oLtu6v8hEXMbN9tufZaE+x20pwbdIaAuuSGLQdlnpr0vJUA?=
 =?us-ascii?Q?qahO8OidxiPqkjXSs7W3vpkgRpkQ8zAg1mMiraEn9OT+iyOpZm683ruLIDC+?=
 =?us-ascii?Q?60lUzmz0+bizvx4XQ1qnHihXhYkN3/Dukc/ayZSfVfsDHFr89ItbBRuPh66M?=
 =?us-ascii?Q?6AP/2RAMAe+ck8Oti+ytv9X9/KfYGdGcFcKFIY9Z0tvLllU3GrYabKoyvEV9?=
 =?us-ascii?Q?dbFRkg+ogzMfE0RGjlnAyfFSjuFDO5SQ9TZn3rkeXzkj93a0WQWqFxGFfWPK?=
 =?us-ascii?Q?nA2TEh34doDUMuUIPZ6zI6YECBxxJ/29sXmNTJ1EuK/fh9pAoT89s5gfZD7/?=
 =?us-ascii?Q?aiJHeljx/nWbCiRYPxdrI4Ivx6ZLevdzqKJt02iJx/wpRW89wjuqoJt9caeO?=
 =?us-ascii?Q?p00+wyStu/CqOiWwO4fXvSjL3H92SFQUsAlbSjnfmGmPyA+tzV9+BL6eVnZ/?=
 =?us-ascii?Q?QvqB24leb4NSt4ivzDZGcNbzKnxsI/SDb/OY9JII4d3ezLdQi+IqJM6fXF4m?=
 =?us-ascii?Q?ZWoldjX/GlEE98ORghUHb+qMt/xjMJHMraDAQbLbF4nBxg5KOVLDC1IZBssC?=
 =?us-ascii?Q?aBvBsk+irS3H9m0KvqhrH5lwFtpOR0e3ioERezMEv8973erJlN+EqZWgzYSj?=
 =?us-ascii?Q?8LXupCt4qa9aVC8WDuM4mF01kYntBhEI?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XxMEH6MCufzjfgp6I8IJRWuODobYzNAVF63eoalG4JJ8JI8tn2E1RATie5TF?=
 =?us-ascii?Q?bJqojHNTfOq82xQoD7CvRS9Ipe3T4Xr5AzO1gruODAjrm6oYcrJOXHgkZv0i?=
 =?us-ascii?Q?27jzK0PyTMwtavglqctkJalTvCTm6MDfiUmLz3BsFneMgMg49vZFDs1ey7m/?=
 =?us-ascii?Q?swswBDWZz81hrjAOj4QhxZ8NtgoRM8JyIq5UphGGE5T+x8g3z3nszJafnnJT?=
 =?us-ascii?Q?sfaILNtPt+YM+io5dygqkhdcE1nWGPP9IvrMWWOg0x2FSv63ibnpqHMl2XYw?=
 =?us-ascii?Q?d6VT2+J6yMaaI5ygdE1y9BDq726TZWSTBN7e0cjdFAvp8cOL8ZDUIeGCzlCm?=
 =?us-ascii?Q?evnw/5xwkzmj3ofwETGW97oi99+7Ds4JJiVFx54/fQUSBDUbLWyvNrvAvmRZ?=
 =?us-ascii?Q?6UFAuYIxsSZxuLMAYeYfYsawe7rUvp0pUbtQuldFA2Wqs+pI170wgU1X9SB4?=
 =?us-ascii?Q?v3nkXYCJeRf8fLN43fzCuMc6LSGeLYsTUu+h4S4zJOPQbDTyywQCtHMwfqSP?=
 =?us-ascii?Q?F5H0avP+9c0R243cLg5U5T2xYFaT2SJTi7gf4AFcvrDsresevD/qbNnnGUWh?=
 =?us-ascii?Q?suUQ4tvPNqKp/aOCxNwoMOpuryTEMYgBZqav95TAV9LGHfXN9JrzuU7N3esS?=
 =?us-ascii?Q?HbY6f9nlRGYggTkliHpokZ5ewLjdMgvDA8+hH2gidyqYf6xkbiQ1hl9QgKWK?=
 =?us-ascii?Q?hjj04S6kkrvuYU5HyuaraxJwIxWK03Y2Uog+OHb6NXEeiFvLbBc9qIuGyo3N?=
 =?us-ascii?Q?wE1Ya89oPN6sFpA/fY3aTtseGeUMKuaYgRW/wbAE7pb0hQFImWNyNSLE+2KM?=
 =?us-ascii?Q?+T9zEUk492XIPmc2Us6BjGeOusRLw7jlEJkJdVO8NaFlyWlEWUxBq7mCVpW+?=
 =?us-ascii?Q?U92TiAAr1rK1DYre7OR7jDzV7tRgQWrPBXsfaGi1v7X2GmCW8wgEFlpiwg/o?=
 =?us-ascii?Q?SAgUlC8yjXly6J4Z2GRpLt4rlkRj6GXHyAkHfTCxIAXyXGl7pG3l32eu9/XA?=
 =?us-ascii?Q?y/7gJD74F06rumCpPuvfG5P7rUNPJ0KtXUBPoJji+Dy1rbk48gnlC2p8Gqdt?=
 =?us-ascii?Q?VDqZ4veNKENeUEOhPfUQ9k53dR4sft6pGNB+ruVD0qFx+Q525vV3pl7nsoiZ?=
 =?us-ascii?Q?t0gbIlIlE7ijOVrxHLXvpF5zX80+Zx3AW7IhQhigbjYHcRm2Bc8VgB1WNA57?=
 =?us-ascii?Q?dfxIkiz2Hjt4gBxJocba7VMJuey3CT5qOC/qfHwfChxE2daHGvlyBUP+wgAF?=
 =?us-ascii?Q?qEJp9yuLmXnhSo2eW3oGyeDtnUNF0MhwUZ1dkBDV3+j9dJIUdBwYSPnkhctJ?=
 =?us-ascii?Q?gCjD8sNgo3Q/CeWpGr2dTQX0lMQD4p5DvBO7cLGCrMpbYjLvqjQqnkwg0B4C?=
 =?us-ascii?Q?LMv+IVW4KWD5k1Uuc1uy/KQRAF+CqgjNJ3n0R85eOtpbohZFNh5EwPfnYPOO?=
 =?us-ascii?Q?pwuzjtSKUOVkwSzccGEtE5VY4X9VjzAuTS74Q9L7fJBw7wTbE2V+0gB3ZIjh?=
 =?us-ascii?Q?QRfQ2rstmsOvG+DGuGqIp2nsWoQ0waLVNGTLkAVOE4/v2G9Vwgg1tlsFSqUz?=
 =?us-ascii?Q?KaoezQC2izUkvsDE9ZkbHZRK9Cu9JGGobX88kRiu?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 59ef65e1-9048-4759-ef1e-08dd4abc52f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2025 16:51:26.2651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qmoC2FW6OKyljFeRvsyclk2GFM08tXbnyAIjPgWOGLPnfpoQECKs1bg1Oy0m42iSyKIw23k21unDC10+0Iz1HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6782
X-OriginatorOrg: intel.com

> +	char *tmp =3D *msg, cur_sev =3D MCE_NO_SEVERITY, sev;

Should cur_sev and sev be of type "int" (since that's the type returned by =
mce_severity())?

It doesn't matter today since the list of return value does fit into "char"=
, but it is setting up
to fail if that should ever change.

-Tony


