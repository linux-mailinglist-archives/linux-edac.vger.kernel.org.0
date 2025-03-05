Return-Path: <linux-edac+bounces-3270-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C207BA50464
	for <lists+linux-edac@lfdr.de>; Wed,  5 Mar 2025 17:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A20483A4583
	for <lists+linux-edac@lfdr.de>; Wed,  5 Mar 2025 16:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B3D42AA3;
	Wed,  5 Mar 2025 16:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OiYCXjs7"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235872E3361;
	Wed,  5 Mar 2025 16:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741191454; cv=fail; b=eE/IV+lY0EImWPh7Q1TyAzOmEQRKnwFQpg6qqqeqgd+Z+PnHgb+tbocjAcEZSD+vRQPNm/TL7bYOFcod3F/njAuOs4l6DAPp7eUtANF2AknErcPm+UQWLEy1VJFKYosvl1WVbhAuH+HXCCOw/i3iy585uJZbxSHO6MZOLQqh/Hk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741191454; c=relaxed/simple;
	bh=WcNhS9evPJc8jOnV2uqU3DGvUjpPcYiOrqUrzw2tfHY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JI8sP7ZJGCsf4cv+w1OwqeBoK681T/Kj6z43ji30F7taNY6Hnom/NcU+XmsmEngYZQJ1f2KJDLwOAaY6+LA5QVZeAG5QcabV30KoWR3gLMlTFEPjD0QOmzEmFrEUKNXPV47Dx+LFlVVzpRObyz/EuwYUSq+mJotKTaMthvasYMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OiYCXjs7; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741191452; x=1772727452;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WcNhS9evPJc8jOnV2uqU3DGvUjpPcYiOrqUrzw2tfHY=;
  b=OiYCXjs7krNOJe1yXh7wjezLJTtVJ1WZDQ8qdAY9M8mKl/Yu8YSvpluL
   0aqasjZN18uQQvfLbLO+Ow6rXlqFhfX/BO4BapapckTpbLP7en5EJJbB0
   YtTtuidhiuzy5j5hKrqIf4NMWwsmShSP4qtRP8afIuLmtPLmyn5vwqM2e
   JiF8ED2Gy+1PcO28B5Qdz6J7uwvStp6++//DJgrFDgBQJxXOn9knNqDBT
   qKfwEwLkyAvQze+RLYdYsvxpsAFr81v2yEgteNQP9OGO2M/v+6fiXvTQe
   BW1CAGV+2dJA/nzI7OHNboSLdQtDDeKYDB72q0trVIAUpqrgA6qI8UitU
   Q==;
X-CSE-ConnectionGUID: QpxkW0exQ1GWe2x4V8IwnA==
X-CSE-MsgGUID: 6ESJxThbRiidQgqZomwHow==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42408111"
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="42408111"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 08:17:31 -0800
X-CSE-ConnectionGUID: PTJyySesTQOKUqO4FAnItw==
X-CSE-MsgGUID: DzfrZ6AAS3m5Cmx5KkIxsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="123767228"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 08:17:31 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 5 Mar 2025 08:17:30 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 5 Mar 2025 08:17:30 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Mar 2025 08:17:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q6mIxlXMfzj/nrtsRRBv9EcxUkAA5wfgjV0L55QTuWu5acTYrnrSpJJHzHBIwqXHSgSfkkhYe9zshRDFG443jSjVEE1kc38V/6BswwzKW2StXEz/ImmyMXWNLKEspBHmmLxpge/dAF8w3RtMWJTk/UNHsQighrBn+a19cUA3+htgw9DpLXJJlTH7dDMRxGdsuqAY6fjEdFw4eqJkfbnViIx71bfUZz5/my7tE65KvofLJJkeUE64ZMhTTTXKs/UzQKy/qPZoqSbyc0pl3t2lzrynxuzGJzloLSsGhO5XLuvJPfgcXyTlw55pGJdl4Du7/hjkznVK456zzvFUP2JvUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WcNhS9evPJc8jOnV2uqU3DGvUjpPcYiOrqUrzw2tfHY=;
 b=ZpwMKlsrs3SlbBXEQggperhHu/KjFwkQiUmhbp4TvZR8UHA4oJ90sC2jAjWRHCI3miUTjQjJbUpgynzSAQ5Zz5W42Ifj5152Z3Q8wGXc7BYi7oZF62V8BJPbQXTmVHmaXsbOkB5sbI9EHQEHTXsxVqD9JKgUymKCD/jWB1TLnDy2lGoho78JMSfcZ+DwNMly3wpizwtPEW7Q4Go1MaKO7nSnrkRGPM7JmtaPNfwM6fzM3qfoZtTo/S1U7F9TAj7usJtZza70ioQgAtKpM0fl+anainU1YblJeHcNeUm0gNQCv0PSC4vndhFAE7xBRwmTWENz/RAEhbEkKyoItTeL4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CY8PR11MB7846.namprd11.prod.outlook.com (2603:10b6:930:79::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 16:16:45 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.8511.015; Wed, 5 Mar 2025
 16:16:45 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>,
	"Yazen.Ghannam@amd.com" <yazen.ghannam@amd.com>
CC: "nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "linmiaohe@huawei.com"
	<linmiaohe@huawei.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "peterz@infradead.org" <peterz@infradead.org>,
	"jpoimboe@kernel.org" <jpoimboe@kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
	"tianruidong@linux.alibaba.com" <tianruidong@linux.alibaba.com>
Subject: RE: [PATCH v2 2/5] x86/mce: dump error msg from severities
Thread-Topic: [PATCH v2 2/5] x86/mce: dump error msg from severities
Thread-Index: AQHbgQXyPXX+b5DVvk23qF/fq5InZrNcuPwAgAEn1ACAAFIwAIAAMEuAgABPZwCAAvzzYIACMC2AgADxTtA=
Date: Wed, 5 Mar 2025 16:16:45 +0000
Message-ID: <SJ1PR11MB608315FCD2EDF6408A2A05EDFCCB2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20250217063335.22257-1-xueshuai@linux.alibaba.com>
 <20250217063335.22257-3-xueshuai@linux.alibaba.com>
 <20250228123724.GDZ8GuBOuDy5xeHvjc@fat_crate.local>
 <cf9ef89c-ca91-476a-895d-2af50616242f@linux.alibaba.com>
 <20250301111022.GAZ8LrHkal1bR4G1QR@fat_crate.local>
 <dee8d758-dd65-4438-8e42-251fb1a305a7@linux.alibaba.com>
 <20250301184724.GGZ8NWPI2Ys_BX-w2F@fat_crate.local>
 <SJ1PR11MB6083697C08D8B6B8BFD3CC98FCC92@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <89027155-8ca3-46a5-8c3a-e24b903cb3eb@linux.alibaba.com>
In-Reply-To: <89027155-8ca3-46a5-8c3a-e24b903cb3eb@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CY8PR11MB7846:EE_
x-ms-office365-filtering-correlation-id: ce8eb322-872f-4a21-c11f-08dd5c011fe4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZjZOTnNEejU3WThWVmRGY2RSVUZmRmlwZjNyRW1jZjJOb0N3a2Y5Ri9YcVNH?=
 =?utf-8?B?ZEVETytJNzZKd1Q1aENOb0RvVXBRNUVTeXFJL1VscUcrdk8rbVpkZ1hoWGdH?=
 =?utf-8?B?MzA3cURZT2ZnNWxKcVdiNDdCR2NuZlM0Nmt5UVQrb2cvY2tCdGtncWRVV1NZ?=
 =?utf-8?B?ZDZhYmdxQXJIOHN0RVROdzgrZlNvRGxJTE1ybFpWQXBXRUJuVExNNC9xcFJI?=
 =?utf-8?B?QW1CQmtBeFZ3REtUek5yT3pjUE1tc1p4QXQ2Z1lEL2ZHWG02bHBIWkdSWUZ2?=
 =?utf-8?B?YXhFRG1wQld6LytSTmphVTRPWCtBYnJEYkw2eVllUDNiWWZMbUdMblB4Zkc5?=
 =?utf-8?B?MnQyNXY4dVJySGFOMDIwMm55TkJGek9WcmVtVi9QVitSSHBmOEUxcEJzMUZh?=
 =?utf-8?B?L3JLZ3Frby9DUmlNQkVBOTZnTStMbWJtbnNLbGwwemZuR3dDOHUvVXQ4RHpP?=
 =?utf-8?B?UFpnLytDb0VxSm45QXFTQ2xla05BbmxyRHcwZXM2aWVRLzRYRlBKWlhOMWww?=
 =?utf-8?B?YklVa3loekFZOW5vODExL0tLUWNaZUJEZElUenRtTGt2OWMxc2cxV3pXZDVz?=
 =?utf-8?B?SXl5czZ3d0ZJRXlzSlhyS3BmK1BobWNPMnIyWUtrTDA1Z2k1Y3NoR093VVpL?=
 =?utf-8?B?UXhOTzZwRUJOd3I4bm5FUVpwMnA0V1Uwam45a3A1YkJUYy9uRWdRZForUmdO?=
 =?utf-8?B?cFZlQ3hBQWd3NTA4Qkx3S1RsRmxCUmZobkZ0bS9MbXFEYnMzbElmMzZCakdR?=
 =?utf-8?B?YlVQWHIyVHBuUzF3bG9QSy9KYWg0aGtFMjNYVkxMSEpNL1RwaDEwY2oyN3lY?=
 =?utf-8?B?em96N01obFNtNllkb2hma2tZdE0vOXVhWEFMYldrNVB5emR0aUx6RkVZQk5S?=
 =?utf-8?B?T21BMjRrS2pBUWdXb2R2M3RHRHVGQUV0T0JXZmRDeXdua2ErQzdIWVBhSFRu?=
 =?utf-8?B?TzdQRjZaZlY4VGFyUGdwSi9hL1FoQ3VNTlVnalpCditQdDE2K1FZZk5panFl?=
 =?utf-8?B?akxSbHRva2lsbDlFVEtIQ0ZmYXhHVkU1QVpoM2FtY0hmMlhZUEZMZVY5VW9H?=
 =?utf-8?B?QzFyQ1FwaUh6Y096dUhVcTdYeHVzNjRwWEk3UFFDQzBpT1JnbWp6MUpHU0RV?=
 =?utf-8?B?dGtGeE1FN0ZBUU1tZ0VDOW92OEFRNTM0MmIyTUh1MGtTcXVpU2VOY2VZUDZv?=
 =?utf-8?B?L2xTckxPSkI4czJERTJQbjQ4L0FIZ2xPN3lLV0RQOE01TFE1R0lrVWl1TEtt?=
 =?utf-8?B?YWtCZndIeGltVmN2VURBZDRMaXAxUVZRbWtwWEVtdEhlV3lrRkY4V2xTUHE1?=
 =?utf-8?B?cjNNTGlobDhhaTdPOUJmVVFVajJDekRyZW5FSHhJTzBtNWluNHdWSFpaTlVh?=
 =?utf-8?B?Q2dzRmcySGVkMzJkZVBzWnVma0ZUc0lTZFQ4cUxSdExtMGcyZFhUYnZ2Mm5T?=
 =?utf-8?B?cG1xVDFVTDkwbEE3OFUrcCtSY1p2dWFhS0owN1o0NU1TMnovZmxsTnhWak9y?=
 =?utf-8?B?aDlPUmFqeW53R0xrZU94WTAvczQ2MzlDWDJtU2JnTFJSbS94UDJYTjZLbzZw?=
 =?utf-8?B?U1lQVVhXMUZPQUI2VlRqM24rbXoyaUtRUlA1V1EyeDU4VkY0YmtLNlZXWUhw?=
 =?utf-8?B?Y3FMQnQzYlNoVlFUM3N1R2pLYTdiTmEydTRmd09JaUJIMXdRMldIZ01Ub3NY?=
 =?utf-8?B?WkowcUpvUm0xWXJpNjFEQ2x6eDJpTlFleUphcGtzaXlGUGp3T0pBMk1IOG1n?=
 =?utf-8?B?QTBDcktwdklzTnlkTDEyUHpUSzBTTDJ5RVM0MVJqWDYvUHk4TElFTmJiRE1I?=
 =?utf-8?B?YzZVWThQQkhaempKMWVaTFMzV0hHdmxaWTRObDhuNklqV2pUbFp5a3k1K0t1?=
 =?utf-8?B?a25wbG9oNUFVam5LQjRpWjJhRC92M0kyeHBYWlJPcVJpUFRYYm95Ym85aWhN?=
 =?utf-8?Q?Up6R8PRGQCfI0+5HrLUYHwmXalf8LQEH?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M3NaTDk4OEN6Q2lEYmYyNHVQdDBFc1F5a0psRElIeFlleXFMdEkvd2FyRDdM?=
 =?utf-8?B?REU5Mi9aZ09VeVB5RSt2aUU4QUFBejU2bC9Qak5xblp5d29BdUo2TU1VQXV3?=
 =?utf-8?B?Vk1XOFB6MWcxL1M1N1dVTnYwUzZFdk0wdG5sN3JEZW82RzBKSHZKamgzYTJL?=
 =?utf-8?B?cFdsVWlpWDJPdEZMK2dIYUNYYlpNTC85dW14THhqQ2hoeGRjMjZHSUxzNVBH?=
 =?utf-8?B?MjJ6NUxxeU5XNUZFUlJPbEM4dkdZc2VSUVNiK3RBMCtuNkhraEo2QVZUcm13?=
 =?utf-8?B?TitvV0lKN2w4MjJZUVpCVEhlekdTc004QXc3aE1udWxQd0IyREs5WE9nQ3hM?=
 =?utf-8?B?amRBdHJzZ1VLY2dwV0F3Q2Y1NStNQThaWlltY3YyZVN5cTVvS2Vhc2ZHVDZD?=
 =?utf-8?B?NlU1d2NPOTVWQWZMSzFGb3llWlFCMXNPTGVDeThQNVI2UDN2QXpHaktacXpa?=
 =?utf-8?B?bGtCUWFDenk2V1Y3SXVIMnZnQ0FwRktRbC91YjZFbk9nZ3dNY3hjSzNRMVdJ?=
 =?utf-8?B?ckdERVFMcmkrQ3BGRk9yVldTUjJCSWUrc0dIR2t4bHIrbDdMOWN2Wlk1bjZL?=
 =?utf-8?B?c2Vyck5uRjh6azhGWDB3QlZ3cWpnNjlCNHBXSUhzNk1nNnUrZ3dwb3BsVFJG?=
 =?utf-8?B?VWNOdHZMNGlIV2hobTJJUk5xTS9Sc0xFTnRDa09tQk00V01EaHFmQVd3N0Fk?=
 =?utf-8?B?TmJ6WkFLMWRJNkw2SG1RRXFidmhTMUNpRmpiVzNCcUM0VmVhT2FKQk5pSndr?=
 =?utf-8?B?VURuVEIwcmFUTjIvQ3hFaUdlTk5TcXcycEMzZUVGZlZaeUpnaWpnenl3LytT?=
 =?utf-8?B?d3AzLzI4MEtJNHNBTUlBejU2V01FU1Ezd1BjUVZIY2pTdkVBV2pyMEExZk9y?=
 =?utf-8?B?SkRXWjJXdmFkWm55K3EwdmZGWEdsL2VsVnc2dHN3bHBoY3VPdFFTQkxnbG4v?=
 =?utf-8?B?Mld5OGJPKzZFTXozN0hOTk5QTVJEdVJZZmllcjE1Z08rek0wbGNSOE1naGpQ?=
 =?utf-8?B?RHpqRUZ5QTIyaEpSOFczNDRyVERHMmc2Y1crSW9RVWtvQU1SYnR6WWpjcTQ3?=
 =?utf-8?B?TW1XdFIrVlZGNHlNZmRFSnJjSkk4aVdIOEx0OWxOV0RBVzRIWnAvT2RWZ2pU?=
 =?utf-8?B?bzlndUhsOUNkWkZySkVvUlVCeVpzbWprRzZFcG5KeTBwUHg4eEN4ZkUwT3Jo?=
 =?utf-8?B?TjRkWUIxelpaUlVQRXdNUWNhRDFKQ2RYNE51dlhwM2RPRGdIMnlKS3I5NGtk?=
 =?utf-8?B?MnE2SmtZVkZMNXA1Um5Hcm82YldKN1U2aGNFajVNNWtGeGhWUFdGUzQ0NTZ2?=
 =?utf-8?B?NXhmUklIbUJMdmZ5TlFMeTFuaUtOckttd01ZZ002dnVZb1lBN0QxcndReEVO?=
 =?utf-8?B?N29TaE91NlNhVTlpZ0NYQXU4RjhsSmk3SjJ5WEw0VHQ0RG9ySGlZQkI5WFJt?=
 =?utf-8?B?VGkrc2UzY1pCeDJtTXdvZEFteUtOT2cwTVFoaWxtRVZBQkdxU2JJUUtIRjFr?=
 =?utf-8?B?dVgrSlk4MlFvNjdYbHVsaU9jbXdKS0pVbElLbTdocm8rVCtBNHdOWFV5RDVH?=
 =?utf-8?B?QklSdGhJbEUzK2pzU2ZhWTlWYTZ3TTI1Q2lPL3g0ZWwrWmRHR1NVSHlUajQw?=
 =?utf-8?B?UkU3UDBVV3lvK3NnN1lqSHdLeFRvVHBwaURLNzdOazYxWUlvY1pWZUpaOElJ?=
 =?utf-8?B?dW5CK2hETXFuOFM1SVZLYkwrLzdPc29KWUdZSmlRbXhBcTFVOHIvRjNPSVBT?=
 =?utf-8?B?NHJlS3ZUZ3Q3S2U1R1BkUzAzcHY1TWxlb1prQ2kxb042UUI4WnpMcU9ndXdO?=
 =?utf-8?B?THViYzJHM081cVpkQ3doVFU2a3B6Tmt0UjB3UzFIUHIrTHlPelozdDcwVTFH?=
 =?utf-8?B?RzJiMGQ0c052eUsyQ0lyenh3N1c2bHl6cThqRG96dkNOdEpqZFhWVURMc0I2?=
 =?utf-8?B?aUYxYjRBczhWUGdINTJjT0o4eGREd2gveTU0N3RLM0d1RmF5SGdldEpQcjhF?=
 =?utf-8?B?OGJoVnZVNC9HbDVIeUNpMCtHNDhzS3BHZi9RN280ZXpWQXcrbHI3L0tPeW1a?=
 =?utf-8?B?MERVcVl5emhRbkdDeWlHZTByVVV6anNBRG5kdCtlRFhSeGVCRldHZEZvMHYw?=
 =?utf-8?Q?XtGZv502VbaCXWVQMuykjPaCQ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce8eb322-872f-4a21-c11f-08dd5c011fe4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2025 16:16:45.6028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bn8a/unhPxjGQr8q90nQECTaJ6lcYX0xhQzLtUsDddpZ49HpPJP9FS/21TTrMtPECQE3/0G4QL0RE2gmfZy/ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7846
X-OriginatorOrg: intel.com

Pj4gMikgSSdkIGxpa2UgdG8gc2VlIGEgcGF0Y2ggZm9yIGEgc3RhY2sgdHJhY2UgZm9yIHRoZSB1
bnJlY292ZXJhYmxlIGNhc2UuDQo+DQo+IENvdWxkIHlvdSBwcm92aWRlIGFueSByZWZlcmVuY2Ug
bGluayB0byB5b3VyIHByZXZpb3VzIHBhdGNoPw0KDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9h
bGwvMjAyMjA5MjIxOTUxMzYuNTQ1NzUtMS10b255Lmx1Y2tAaW50ZWwuY29tLw0KDQotVG9ueQ0K
DQo=

