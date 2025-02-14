Return-Path: <linux-edac+bounces-3090-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DDCA363A1
	for <lists+linux-edac@lfdr.de>; Fri, 14 Feb 2025 17:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD39216F578
	for <lists+linux-edac@lfdr.de>; Fri, 14 Feb 2025 16:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5624263F40;
	Fri, 14 Feb 2025 16:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dFcbqvqV"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EA61519BF;
	Fri, 14 Feb 2025 16:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739551897; cv=fail; b=k26iwNehENbCAz87gDIQmxU659lSy9dkDOEyCPWjSWJc8EMr7NCtlkBlpaXDEpyUxww1J73/zfvjdwltWXKw/TL07uDuKr/2IaHAUuZmqhLYiddT+LLeHxew6F/IiCSsKrTf4bPJb1Bc9+/KyIWTlAVmhPIqxjLly7lbTdSyhVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739551897; c=relaxed/simple;
	bh=iLs5lAaekHYwkB1bRC65iuRZE6cytDPlfy/ZSjl5sIM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GC1UNLbThw1q0V/aCb59imeVEeoaiQoGnila0d0tUTX0xaAdyE2HX//AS5NrxdhMUbIBwDELBxecWRjAhkaIiGBmgtqfCsFj8gZwVUy0/tksUvrrbDh6txXhrLYD5NNJFoiUoXgd1esUsJOF0HGJjbgocp6vmHhzw7XJVlJwaHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dFcbqvqV; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739551896; x=1771087896;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iLs5lAaekHYwkB1bRC65iuRZE6cytDPlfy/ZSjl5sIM=;
  b=dFcbqvqVIxbm9NPI9EG/67HdKPdxhFm6EAT1XaraEHiwSVYwKXetLeea
   NOZiBNXAmzM/onmegwY5w1gimffjzX+Ikt9uj/xBl5nTWAuhCaugcY9ep
   budOWRkuGNf9oI0mm88s7IDzRyHlgV0kiiAfVAc0bvOgljOfzNDeLaLNt
   F57lQuk6JL5qaThO6nM/C4jrmHRTikH+n1rnkxtR59xWyyAL29knKhkOd
   09Q7bqpLeT5BlI3ouV5xq/U1DPy8NjGHR4iEsVVbvFkoWu0lCZXgB5LCo
   bf6iwD55/Xpvfnc9/3mCBOk7XaRGDNWUAFgxcm89cJ2tL9gQb2Btr25+s
   g==;
X-CSE-ConnectionGUID: NU2rVbhWTt+Lm7r9pMyOhw==
X-CSE-MsgGUID: k91RaosMQpKUEYo1uQ962A==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="40573797"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="40573797"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 08:51:32 -0800
X-CSE-ConnectionGUID: aitgLyePShKHTgEaQf1B7Q==
X-CSE-MsgGUID: 8Kov4VL1RuevsInhnTpQQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="113232457"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Feb 2025 08:51:33 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 14 Feb 2025 08:51:31 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 14 Feb 2025 08:51:31 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 14 Feb 2025 08:51:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bBA2BYfgHUdICVebnDMN0DxLWRAmnem3gtFz2roZMbfNVx3+qX5/owyYDdnqtoz8wlJkHXsvWJwU/5iSiyOGSfcriqipjDESLqmMQ/c9VR9K5w6y+DzxmNTVy/V4wwbyuBgGh2LGWWSTrAsHrokxCLujS0d6G+sETyyOJ26VggJivGrv7KHdQM+zkhbS7iqncf9vbCUwF9hNZfrR/th4qfhVsVpn0q3gyiK7kYQCrLDps9xCFfl5KP9RN1M3L0jM5UxGxbv8ElIxmwxcGDwx5CgIwqjZzBuBrAA9oa2amwxS3g4RxDJVPCDXJWdiowAUGCzEUQra+qo97YhhEwqoPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iLs5lAaekHYwkB1bRC65iuRZE6cytDPlfy/ZSjl5sIM=;
 b=XXdbGD9j6ZUe6zw7w2q8P3//lDNKtBAdXiknv5M5Z8m4oUA6x3DG7iERmuMsi9gKoaVPx6sEb3aDCctxV8qUBGUHekQ8jqfv3LNyVF1MYKgaMnga1KYvTGfBvuUI9E26ChR3JevzAjYMWM0C++z01S0Px2tMbYTcK61zxWQ2aBTWatXTV9cr2DtDnJG9qPL/JfyCwsYhdsjEAAkYJliaRiAVoJ10hFL68fVBQj0CdA4Nogab46OiHDkxkFok8xOhW/nKrXnOf3Mce/WRZCOgLaY5YWdmuc7HOH24cFwMPYPI/NykfjyCccaxFLRNvKER60BGLPzQ9HkZJiT6PDpSXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.15; Fri, 14 Feb
 2025 16:51:00 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.8445.015; Fri, 14 Feb 2025
 16:51:00 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Miaohe Lin <linmiaohe@huawei.com>, Shuai Xue <xueshuai@linux.alibaba.com>
CC: "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
	"tianruidong@linux.alibaba.com" <tianruidong@linux.alibaba.com>,
	"bp@alien8.de" <bp@alien8.de>, "nao.horiguchi@gmail.com"
	<nao.horiguchi@gmail.com>
Subject: RE: [PATCH v1 4/4] mm/hwpoison: Fix incorrect "not recovered" report
 for recovered clean pages
Thread-Topic: [PATCH v1 4/4] mm/hwpoison: Fix incorrect "not recovered" report
 for recovered clean pages
Thread-Index: AQHbfEqIW9dvUHx67ESUmb6z94NVXbNDUjcAgABgzICAAOC/gIAAPXGAgAGQ3wCAAKX3AA==
Date: Fri, 14 Feb 2025 16:51:00 +0000
Message-ID: <SJ1PR11MB6083A9201E4390F160266AC5FCFE2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20250211060200.33845-1-xueshuai@linux.alibaba.com>
 <20250211060200.33845-5-xueshuai@linux.alibaba.com>
 <5f116840-60df-c6d9-d7ff-dcf1dce7773f@huawei.com>
 <3820329d-20e3-49ee-a329-aac7393c6df3@linux.alibaba.com>
 <23251c74-cc50-012c-409f-c45117b52b16@huawei.com>
 <84ed4048-606e-47bf-98ad-d850cf30d60d@linux.alibaba.com>
 <9f54f518-2be4-7e44-0d6e-c03c53149b97@huawei.com>
In-Reply-To: <9f54f518-2be4-7e44-0d6e-c03c53149b97@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CO1PR11MB5154:EE_
x-ms-office365-filtering-correlation-id: f3e3692c-a18b-4ddb-d2c5-08dd4d17c2ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Tk5UTkQyU2w5dnhKM2lFT0NmZG1QMllSU1B4OXI0NkJFS202VkFMOXVGd2F6?=
 =?utf-8?B?cGZKVk1iQ3RKUlpNaGZteVhGeFZGZ1lXdXBrZmdWTGhCRTkyS3ZaN0ovb0N3?=
 =?utf-8?B?aXppUmh5ME9HeHhuV3FUNDl2M0xJaExBM0tEbVJCZ1VBcmFSblpRTGRMb3Yy?=
 =?utf-8?B?ZzJRQ2liWm41ZXMrTVFvdWJWck5UZU42bkF1TTIvaWlhUTdqS0tCMXFUbzB2?=
 =?utf-8?B?MFRjSWUweUlQOHRXYm5KdVJZVTY3NlAwaEJHQU1hQUlJVHVvODlTcXpOQVRM?=
 =?utf-8?B?V1Jvd1BBWUcxWjZqQ0ovbis5UXJRWXNCZnZUV0xUZi9jVzVqSUZiY0ViQ0hZ?=
 =?utf-8?B?S2VWTTNtS0xjZFRxSUVidjJWSzd0ZjEvWXlTeGFNSTdPMXd2VUREaGU0Tm5i?=
 =?utf-8?B?TzM4MDd2YmpETDViYUZtdlZTZ0ZJNGpXelZSSnFDRWZJM3Q1OTlMc2FPRjc4?=
 =?utf-8?B?ejBNT0d6TENLaHphMlFiS2Nnalh2a3FYaHNVUHlkdHIwdlhmQUZGazUzYUFK?=
 =?utf-8?B?NTFRMmNLOEtpZmR2RmQ3UzNxdVJWKzlYNnFlVDZucXRZUE55dks0Tkxzd3gy?=
 =?utf-8?B?WGxUTnJaekhOeTZjalR6eGYxUGJTenZoVnBVOGdUbml4Q3F6RE1jVUFKUXM4?=
 =?utf-8?B?a3lIMy9LcXpobEtMNzN5SVBTS29zL29ldzFsSTNzOWRkT0JlZC8vd2lmQnVL?=
 =?utf-8?B?UFhSbG9ESnlFcmNZdVFjaDNaYmFXak5RWEk0VWwxKzIwZzJtVFE3VlFGeXNJ?=
 =?utf-8?B?a2M0R0p6b2JObCtPdlZDRTZjdXZhOUVzaHNNUUVDMlJkc2RZZmdRLyt2Q0R6?=
 =?utf-8?B?c3pWSWl6d1lxTTE5SFBxSHBRd05BVk9ralhwWVBaYkVIYU9ESjNYdzJjenBI?=
 =?utf-8?B?Z2Vsa2VtWEtHRHB4WHFlUkdHaGhtSXY0d2lCY3NYVm1XU2hueC95WUZxRkFV?=
 =?utf-8?B?SWFRdmtvWkxrdmU1NFNXV25BZUxzRnlueXJkTHJ1YmlobitjcXNxWGQyRm5U?=
 =?utf-8?B?enJFNkk0bVo1NWdEZ0NwUHI4UDEvUytZV2V4ckFoSGJaN2t5NzU1ZC9qYndj?=
 =?utf-8?B?My9uUWpEaDlMRHdoRzhqMUxCZThKZkZJOW9SME5FRnhBUHdpOFFpSXFyWUJt?=
 =?utf-8?B?eklCR2xiZmJKT0NvUEJQT0ZUL040T1Z2THdIZ1kyOVk5bWpMOGlteHZSZmpL?=
 =?utf-8?B?OW04VjJUV3ZtVWtyZkVoMmNYR1RneU5FQVA0MnFEMWdiUXNVZ0ZlSGFjcytm?=
 =?utf-8?B?UDVwSFZobDIyd3EzTnBySE1PRzdMY0lzR2xwSC9OTmthUUcvZFFwSWFOeG1I?=
 =?utf-8?B?V0ZNcFhmcVRmdldpMUR4RU84dzlnc1JYbXNMSDJneDhmcWVIbTVNYUhjSDEy?=
 =?utf-8?B?b0wyQk1NNkRxcml4SG5tTWhWZkpHZHM5RWp1anppYjlSQ3ljT1NkUlBib24y?=
 =?utf-8?B?QS9YelhCdFJDbGN2UzB5bU1NSVhmbHB2dEZ1U25nR0Vlc0czV3RTSnNmUURx?=
 =?utf-8?B?Y0NWejNQTHE3Ym45TmhtaFRaSTV5K2RHcjR3YjFkM3MyYzJ1L3V4Ri9jTEJX?=
 =?utf-8?B?czh3cHhkUVRhamZ6clQ1WEgzL1FXaXk5aUw0NjkrSmU2bzBrVk1UbGtYMVFY?=
 =?utf-8?B?NzUybkFHZk9kRmszcFdXV01YUVFwTlRjdzNic1lUSmw2RU5aZk9KSXhCdTha?=
 =?utf-8?B?ZG5QZGxPS1ZvQ2tIUm4zRjB3YnF5NFRkdVV3b3l1UkZwSHZGRklkbWs4cjRO?=
 =?utf-8?B?eXpueUEvaklSTU5jd3JFcGN0QlQ5ZkdLbE5TbEtjU2RCN3dCODFHTHRYcmJo?=
 =?utf-8?B?L2ZkUEZoOWcyd3FZVkl1eGZkOVFMbkt6YmhqL1VWOWVFMXhaZkc5M1hzYXU2?=
 =?utf-8?B?K3N1UGpvOTFxZlFoSDVqY0Z1MkxmOE9TL1REUUpjSTQrbTNvMDBnQndQaGZt?=
 =?utf-8?Q?nJ/zEFTnf0tL8YbSkWAeil3tfFAmAtk+?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aEVweUtBOER0Z0huM25QMllDRFpQSXF3cDdvZHUxbVpMSGZVVGh4TTV6R1Zv?=
 =?utf-8?B?UEFKZGVjRENxb0dXNHZSSmQ1Sk9FdUQ0NXREUUtxNXVFZEdLaGNMV0cxRFJn?=
 =?utf-8?B?eU9SLzlmZUIwd051NUEzamlkdXA0VldmZ0xDKzc5WnF0a2d0RTc4UDRIQzNV?=
 =?utf-8?B?VHFJUDRvSTYxeVlVQlZGTXFKRzZMSHc5WkVsY2lUYWVtWk9DR3hJbCtLdnRy?=
 =?utf-8?B?R2gyOVNPZ0Q3Y1pvL3oyTW5LbkRhYVQ2Z2FlS3VWdG02YWp6QWc3MHRKcXVF?=
 =?utf-8?B?TnFBNkpKMVZnRWIvUFAySXI2U1J0YXY3cFpzbkswZEp4aTczSUZlSXlGSDN5?=
 =?utf-8?B?VlRVT0QyalBna3doSlhOSDBLNUlJS2g1VTlPdXg2WUc4TEtyYnVOek9RRE1j?=
 =?utf-8?B?YVgzakNGR1plMTE3S2tTQ0VXbHJNNVBQbW10dlJRU1NoNlhkTTJKdUMyYTF6?=
 =?utf-8?B?Z0l2TXh2Z2gveTFSYTdZNGZmRTNrRDRPd0xubWRubXlIQUlIVGUyVkh5T1lR?=
 =?utf-8?B?OGZWNnI0QWMycC9Ea2htREJuUk1ZUFZNOXByT3pjTzE2NlI3YVpVaS9LcE1Y?=
 =?utf-8?B?Z0l5VFM1emUzY3pXbGhSeVhoajQzMVFSc3R2cE5veHNxSE5aVTFyZVpDbi9K?=
 =?utf-8?B?eFA2QTlPbFhTZ3Jxc3RncnZneStrQkx3NGFzRGNnN2ZGWFNjNCtZdnlicVV0?=
 =?utf-8?B?eFNOSENVVGo4ekI0NlF0UUNXM0grN25OWU55T3gwcHp3QVZlcU5GUXFrZ3ll?=
 =?utf-8?B?S2p6aVBmSmFiSjJ1TG1aRXpCbWMvbk1jVFpVT2hmNk5LK1F5QXRKOUo5VmxN?=
 =?utf-8?B?SDBaSnM1SWZ6V3UyS25xSlhOdjM5NWZKT3lBbG1peGlPMmtEaDRWTkwwWmxa?=
 =?utf-8?B?aWRnZkhYelE2V1NsMjlXeGwwWU5jeHZNbUIyVzhPK2tuajV6ZTRRSHJWQm5z?=
 =?utf-8?B?ckwrVnlSVEY3R0xoc2w4SCtST3I3L0xiNWxna2x2c2JOSFA3UFZTcnNSWHNz?=
 =?utf-8?B?ZVU3M2JUM09oNVBuRTVpY0g4emU5NXZLMGxqZjYxbyt5MCs1VThxUlJOeDBN?=
 =?utf-8?B?MDdUcFVWdW5aVXBrdTZ2NzZQOVV2dGQzZG1ZczhpOEUrUXRqeGd2LzAzcVJM?=
 =?utf-8?B?MXF3MGk1UVo4aWxCYVVWQ2NGSDRjcUdKaWJDby9VSXdOcXpFd0RPUElVNUFH?=
 =?utf-8?B?MHdETC80aXRJd2RvUk1CK3JmNTFhSFAwV1I2WW9WNEtRcTVTT3JDdFozeDJ3?=
 =?utf-8?B?bFRKT1pkdzF2RVFYNDlDcU5aR2preThXb3lHUFJBU2UxTk9zRFBHcEtXWVZT?=
 =?utf-8?B?c1NXRDdudkVJQlJZVE92S3FQRGRBMUx5SDZRNE1KWVdFemNYb05XYmkxcGcz?=
 =?utf-8?B?RUpQS1VVYldydUpUcVlRMFVsOGJQQU5pSjZxM2dqUnQzbE1SREg4RTBwT1Uv?=
 =?utf-8?B?YjE1SlZ1UlhhSi9HK1lJenNTek1rODRLNTRtelBvVHgzdmxFZDdjQnFEbWRo?=
 =?utf-8?B?SFNSODI5a3p1TUtCbmFLMWZlcFRIOTdVdUpYT2hSemlWbXFZejh6OW1QbHBD?=
 =?utf-8?B?ZUJ2emc4T2E2Y2tWVFBjQitEOWM2N3drdlg4bjJRS2JLKyt4dlE1U3N0U1V6?=
 =?utf-8?B?aGl2WW1kdXl6RkU5RjBaUlNqN3BVWm15QW5IODFxTE03TWw4RkluQS95bGxO?=
 =?utf-8?B?Mm5aTm9aOTZrNGNTUEd5Y0J2Z3QrK1RUcnJoRGpib2R4TXhLdHh0bDNoZ2ds?=
 =?utf-8?B?MGQzTlpLRkxralhjZ3B4eEJhM1JEdFZESllvKy9zTzJORXBaVHd3dUZFMzhB?=
 =?utf-8?B?WnIyTjV1N3c4MXpoak11UDBMaDBHckVqLytHODFFQ1kzei9YWkxCZituZ1FX?=
 =?utf-8?B?SHVnbkpwc1dpcWNFSFpTaDBrOTRKQk5QM0M2OERLL3FEeFA2cTlhT3pFdDBU?=
 =?utf-8?B?UUppWFFTQ0pFOWNFZUJ5NnVzUmNnSU43emxQWUxnWVZHdDZOYWxLcnNXblU1?=
 =?utf-8?B?dXVZRUc4VWlOOG1WemZpUCtpQXJsNHRUMnBpSWtobzUxNllaMWhrL2tTZlE0?=
 =?utf-8?B?V3ZIT1h1V2NsWFdwM3RkR0prdDNiSmdrNWlkZVJwbWFZMW9vWnZuQjJXNVRh?=
 =?utf-8?Q?ZfyCJ9pw6aHLXqIvftGkfsN85?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f3e3692c-a18b-4ddb-d2c5-08dd4d17c2ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2025 16:51:00.5746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3UeVOX9WPm6dGUVMad/1W8UrBzg07cHhThUDZ+3nzWT6l4QTEFgklXsXVj3NQ2WbVhRVyNN1AZV9tqoQ2b8Opg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5154
X-OriginatorOrg: intel.com

PiA+IFRoZW4gdGhlIHBhdGNoIHdpbGwgYmUgbGlrZToNCj4gPg0KPiA+IEBAIC04ODMsMTAgKzg4
Myw5IEBAIHN0YXRpYyBpbnQga2lsbF9hY2Nlc3NpbmdfcHJvY2VzcyhzdHJ1Y3QgdGFza19zdHJ1
Y3QgKnAsIHVuc2lnbmVkIGxvbmcgcGZuLA0KPiA+ICAgICAgICAgICAgICAgICAgICAodm9pZCAq
KSZwcml2KTsNCj4gPiAgICAgIGlmIChyZXQgPT0gMSAmJiBwcml2LnRrLmFkZHIpDQo+ID4gICAg
ICAgICAga2lsbF9wcm9jKCZwcml2LnRrLCBwZm4sIGZsYWdzKTsNCj4gPiAtICAgIGVsc2UNCj4g
PiAtICAgICAgICByZXQgPSAwOw0KPiA+ICAgICAgbW1hcF9yZWFkX3VubG9jayhwLT5tbSk7DQo+
ID4gLSAgICByZXR1cm4gcmV0ID4gMCA/IC1FSFdQT0lTT04gOiAtRUZBVUxUOw0KPiA+ICsNCj4g
PiArICAgIHJldHVybiByZXQgPiAwID8gLUVIV1BPSVNPTiA6IDA7DQo+ID4NCj4gPiBIZXJlLCBy
ZXR1cm5pbmcgMCBpbmRpY2F0ZXMgdGhhdCBtZW1vcnlfZmFpbHVyZSgpIHN1Y2Nlc3NmdWxseSBo
YW5kbGVkIHRoZQ0KPiA+IGVycm9yIGJ5IGRyb3BwaW5nIHRoZSBjbGVhbiBwYWdlLg0KPg0KPiBJ
J20gbm90IHN1cmUgd2hldGhlciB0aGVyZSdzIGFub3RoZXIgc2NlbmUgdGhhdCBjYW4gbWFrZSB3
YWxrX3BhZ2VfcmFuZ2UoKSByZXR1cm5zIDAuIEJ1dCBpZiB0aGUNCj4gb25seSByZWFzb24gZm9y
IHdhbGtfcGFnZV9yYW5nZSgpIHJldHVybmluZyAwIGlzIHRoZSBwb2lzb24gcGFnZSBpcyBhIGNs
ZWFuIHBhZ2UgYW5kIGl0J3MgZHJvcHBlZCwNCj4gdGhlbiB0aGlzIG1vZGlmaWNhdGlvbiBzaG91
bGQgYmUgYXBwcm9wcmlhdGUuIFdpdGggdGhpcyBjaGFuZ2UsIHRoZSBjYWxsZXJzIG5ldmVyIHNl
bmQgU0lHQlVTIG5vdy4NCj4gVGhleSBtaWdodCBuZWVkIHRvIGJlIGNoYW5nZWQgdG9vLg0KDQpO
b3RlIHRoZXJlIHNob3VsZG4ndCBiZSBhIFNJR0JVUyB3aGVuIHRoZSBhY3Rpb24gd2FzICJkcm9w
cGluZyBhIGNsZWFuIHBhZ2UiLiBGdWxsIHJlY292ZXJ5DQppcyBwb3NzaWJsZSBpbiB0aGlzIGNh
c2UgKHVzZXIgcHJvY2VzcyB0YWtlcyAjUEYsIExpbnV4IGFsbG9jYXRlcyBhIG5ldyBwYWdlIGFu
ZCBmaWxscyBieSByZWFkaW5nDQpmcm9tIHN0b3JhZ2UpLg0KDQotVG9ueQ0K

