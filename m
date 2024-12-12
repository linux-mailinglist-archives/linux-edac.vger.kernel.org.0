Return-Path: <linux-edac+bounces-2705-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB2A9EFAAE
	for <lists+linux-edac@lfdr.de>; Thu, 12 Dec 2024 19:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29077168D6F
	for <lists+linux-edac@lfdr.de>; Thu, 12 Dec 2024 18:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAE522C37C;
	Thu, 12 Dec 2024 18:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VTSxv8gk"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCFE22EA07;
	Thu, 12 Dec 2024 18:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026981; cv=fail; b=uBhZ9sgeaV71RIc50z4QtRYfX216YW20eU+ZZJqgxL5qMYIHUmlp6C7Kn8vIMCpwr03NJIy2acSY7uZpIk+zDQAiwFxqZKlsIrMRWd9c6YFEPRWdrEqM7nUvz0A/VYEk7VTpnurJjIS129JJDj1PquyiSyaNQCEk6haOVZMHj6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026981; c=relaxed/simple;
	bh=K1atChhkfmOdO7DxVjEp1WQ/8ky6EGTxZBwZglfN6YE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k+Yec053JF6bp0plw70sPbXfssktKgL2kURVlcR+lVXjUna4wCiI+feww6OD5CxmkOfPBSdUa8Y39mfEu+fLbyx1PTM/Szk1RR0t9lSUenlTYc2eIbkoxzgxgbHj1MpPFKH981oxHAwP2N+E6LBeKFk//1qiYgDOm9DIUjDNVgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VTSxv8gk; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734026980; x=1765562980;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=K1atChhkfmOdO7DxVjEp1WQ/8ky6EGTxZBwZglfN6YE=;
  b=VTSxv8gkunVOoa7qM3bdkJTo112/1IqW8waLEr1vGah7IHclb2rtHPBp
   fkSUGaliMFbBNB6gxJUHNpXRxBGathIz5wYjn5Ut3877jexuBE5BtVxyS
   egMyqZXX3vf1dtm1GSx4KVvMjVJpHjYrXZE72qdq6E+s6Uw+AMrv2v1Yt
   oNYEklTBGwzPN4A2nbca7cJ+y+dbTKn6ju925zReOsgqViAOHCBXypdYI
   vIhcvy66yIiw8gH0fNKvCTKJFJjJnwHrdEsFmDG/4hH6f6pGtRcDKo6Mb
   Rq+o+7fjg1ue1XNCIN2oDuLC6MW9y1HyNvkkXeGEYIIM6f7jsSf7W1gfl
   Q==;
X-CSE-ConnectionGUID: KAKiiOUcRsaHcYbY59OkCw==
X-CSE-MsgGUID: legymUp1QWOF29QHS2BceA==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="45071164"
X-IronPort-AV: E=Sophos;i="6.12,229,1728975600"; 
   d="scan'208";a="45071164"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 10:09:39 -0800
X-CSE-ConnectionGUID: iM3MJpesSEmkLih58eHQ0Q==
X-CSE-MsgGUID: hYaIB2OxQ1KCgZbUlpA7fA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="127303228"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Dec 2024 10:09:34 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 12 Dec 2024 10:09:28 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 12 Dec 2024 10:09:28 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Dec 2024 10:09:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qa+JF94WI/jSGmzFTDWtTGR4CzMGuPskeyMjAFtXEkFu2NrdvlZgI2MR9+XtaBv+5MJPwL/4OSYMdeVGzdaswombjyNWU520lclQv0xiNwgQb9wucg8rU3oCMM+C+P50ZJ9JRUEBY+y5fhY0bcoYu3vOEIUEWH9yvxat25RlYrE8J7NRVOLX6C5JDV5ADOTDGSI1Hcr0j0rpF/gUlgMqBvZBCg0tYlxRELCnY2XeB6RIGPugdf2Ef3aGJc13vEqwU2tKgfjTwIckrf3ZQovzA3LXIMfaPOw6Ufdc0Jn+rAGpMiySuY2nVbM1Mxfg5HqrcmkwCfdm0shWxduhyMZ/pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bvflYMs9o+n4DI/oG4mp8w7nIQgNZxIKb8e4seNZYec=;
 b=mdpme3HjCH81146ra7tEAz+4p0zMRmBxKnfqSCFt+TuvvaXoyy0aAocjNazcIE6Hp5xVFfmhsYtIaP4jYc94f7n/Cx1SZE6ODt3sFqwVErVjRDDpLMVQHqu8Nvluewgn7jc3ntYj/6H2hNO5oViIE8Y9VZLo7U/yjE6jI1nkZy07jLbohjHQv2z9tJ3juDVhZaLBVynfUzfk9T9TeJGpbeeQ7dMgNYU5HlhzLGCcSMiAULBlfp5MljhiyIJHMsMJ35AbZA2C0R+MC6qdQicawGEOWF5hjcAKz07SH43KePUM2R0eXV8YTKHIDu//ZVo4+oemSQS0S/zNEwHGsMOGcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by MW4PR11MB6838.namprd11.prod.outlook.com (2603:10b6:303:213::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.14; Thu, 12 Dec
 2024 18:08:42 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%3]) with mapi id 15.20.8207.020; Thu, 12 Dec 2024
 18:08:42 +0000
Message-ID: <a4179200-bbf7-4f38-ab7a-d52bb74d70a8@intel.com>
Date: Thu, 12 Dec 2024 10:08:41 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] x86/mce: Remove the redundant
 mce_hygon_feature_init()
To: Qiuxu Zhuo <qiuxu.zhuo@intel.com>, <bp@alien8.de>, <tony.luck@intel.com>
CC: <tglx@linutronix.de>, <dave.hansen@linux.intel.com>, <mingo@redhat.com>,
	<hpa@zytor.com>, <yazen.ghannam@amd.com>, <nik.borisov@suse.com>,
	<x86@kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20241111060428.44258-1-qiuxu.zhuo@intel.com>
 <20241212140103.66964-1-qiuxu.zhuo@intel.com>
 <20241212140103.66964-7-qiuxu.zhuo@intel.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20241212140103.66964-7-qiuxu.zhuo@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0087.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::32) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|MW4PR11MB6838:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b726784-8bfa-4412-340c-08dd1ad802cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WGsyOVVrWU5tSUNNNzBaZzVRL3g2amNrYXJsSWc1NjBZbmZLSGNJTElEeTE5?=
 =?utf-8?B?TmN1SlVlTkw0VjdWVGptTjB5NUd6UVpuWTNIaTlqZ2h0Skd0S3E5VUFDZnI3?=
 =?utf-8?B?ajg2aXU4T2ZzQVdiWWR0bU1OWXJkNHB6RDFRNEJGRkxlZ1JhaWpVSy9Ccis5?=
 =?utf-8?B?RE5GakZvcEFlcFlmUUpnSzVjWTRmVlk0REs4VjYxME90TDcvenN0dTV3dVBC?=
 =?utf-8?B?eXNOUXZ3VGxDY0FlWmhoZDZsblF1Ty9BdGJZM2JNMlJaUTQvV1hRUFdhTUZJ?=
 =?utf-8?B?ZVNJVlVOVG1qR0VCblh0U1l2OWNQaW90N2hmUFRQbVEycXFJU2VtRENyaGMv?=
 =?utf-8?B?SVhlc1hFZDNlcnU4Z3VNOFhmdDRtRlU5SWpOaUNwcThKRnVQR2ZoVkk0ZmV0?=
 =?utf-8?B?MWJBdEJNaXk0WDA0UHNKL0ZmdUZzWHRidGgzZDJnSmhvQlZOMk9XOU10RDh6?=
 =?utf-8?B?TThzUTdaY1hFdEVqTDdKSGluN0hBdmEyRDVDd2Mwd1d0b24xb2QxNGZxZTNM?=
 =?utf-8?B?Sm5sUFFMeUV5OG45SmlNRk9NeTV6bHNaSVBWQkFmZU1OZXJ2NFVGN1I4TGU2?=
 =?utf-8?B?VjRvWVYxVStFZWtFNzFsYzIrRHhqNytwYWtBSU9CdUErRGRLdmM0eW16RWNK?=
 =?utf-8?B?TUJlWEhLdnZXK1RwaUdNeFRkMGdaVFZIQ21lOVRDZGhnQTQ1NGJmdnE3WGZ3?=
 =?utf-8?B?Qmd3ZE1oL2dTL0M1UG1nNHQ5Wm5hemFZWjdoamNSRzNudXNWWVcydVcxRzBW?=
 =?utf-8?B?NUw2OGxrVHdUNEk1YWZLQ0hncklMY0ZKdzVudjVHUUpBcTZaNXczb0ZjUU8z?=
 =?utf-8?B?blB2Vlo0c01Xc1hIdnlwaVpmVld3MDVLRThFa1B2eDhGOUdRWGRkQlp6SWkv?=
 =?utf-8?B?Ykk3aU5RTTBFNjFCbGZwcVRhVnNsUjRITzkyNDJScnh1UXBNeVppYjlzME4v?=
 =?utf-8?B?dlBSODNZWUd0eGFWcms1YUx3NzlMQ3FVSDZXYVJIZXB0UTNib1RvMGVKR0hV?=
 =?utf-8?B?RDBCZlZoMXAzOVd1WGVvN1FuYVRWcmJCUDMzRlZGWjdhRUhIT1JBeldLREhx?=
 =?utf-8?B?aXp0U3RaZmpSWWhlTnhQcmJHWDlLRlZiVDg1Ykg1TWVYaGprSzRwaVladHF4?=
 =?utf-8?B?cmZpM3VnMFVqQ1p5cVA2S1B1ai9tUXE3UHYwSi9TeUpIRXB2bnlNck9saGdD?=
 =?utf-8?B?eVlsbGQrSlZtZFBsSGlvenJ5K0dKbWJWWGVpek9ZRE0rczA0Q2Y4SXVZbE9a?=
 =?utf-8?B?VittbXFURnJVNGw3TUhVTHhYdmpOVVZWSGt4aHhUWmJSYy9QbUpYK09rdzMy?=
 =?utf-8?B?Q1ZqaEhuc3ZtK2VRL0s2YUNpR1dZWkdnRHRiZW95SUQ5ajcra2F0azFhM3M1?=
 =?utf-8?B?a0FWSjdRcDFIbFlBMmRjUTBacFNZUkxrd2lneG9IOTFoblpJL1BRUkdUVVpT?=
 =?utf-8?B?dDlwRUV3ZHg0L2Z3WVBBYk5CY0NsdHlmMisxdmNpaXlBMFU4eHZwazNQdnYy?=
 =?utf-8?B?ZHQ5OG5kM2hDeklHSkMyTHViMVRRblJwekJESEh6ZUZPODNEa2xPeDFLL1pl?=
 =?utf-8?B?TXcxQWl4ekphbUprbjVnOXVSS2J3d1lsMW9pZE0rNHJuZEZ1Z3Z6WTRvdWJ1?=
 =?utf-8?B?eHNCazE5azFuQjVzOGcvcitjL0lCTkUrYncvZ1dBUEdOYi9SaVVZRENtVTBE?=
 =?utf-8?B?dGZhN1ZLVS95NkN2M3BSZFZoQ1kwaUhPdUJsV25vSjFJWE9rN0EvZm04NmM2?=
 =?utf-8?B?QkdRbTN2VFZ6T1FhZVRuTm1EOTJvYzFYUWRYTWFuYzdWRmVoc2x2bTBQK0py?=
 =?utf-8?B?Q1ZHeXVpNkpEbDhRSHFsUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjhsSkZXOFJmK3FHL3pSeDhjTkczbUEvV2c2K0ozTE9pcHlGYTJKbnozK2dN?=
 =?utf-8?B?MXNMTTJVLzhTcmdvd3NhTWk4S3FyWWMvVFZYVkFmckdYai9QYUZRNURha2R0?=
 =?utf-8?B?ZkdyZ1BwRk94VXhoQzB4Ukw0bnBUNlUwUWJKSFJaeGhrWVNRdW9US0Z5bzBO?=
 =?utf-8?B?a2ZObTc1ei8yN05WVm1qckhjcnR1UGFmdFA0RVh3YUxhd3NFUjNZN0JNK3k1?=
 =?utf-8?B?emJKUmhnMTc3cVhnYlJHMmZWRTJjOE1XeDNZZlR6Ri9OVFpWZWJlQUgyRXJw?=
 =?utf-8?B?Vyt4b21teW93Z3A2S0dWTVd2T0tONG5vbXpJRDgyYUxxT2NXSHJYaitRU2Zm?=
 =?utf-8?B?aG5ldWsrRVVWNHZoMnlCOThZc09EQUlScUF0dFZYdWYrbTB0UTM3WWlQY0d0?=
 =?utf-8?B?ZjZxRFgyc2hsNGxMSU4xL0kvNTg1RmJIMjJHNkhOVGdyay94S2VWblkrREJW?=
 =?utf-8?B?aEpVQUppMmRQclNpSVdoVnU5WmMvUDZvZFBtS0ZDR1FWbWR5RURKN1FtWHhx?=
 =?utf-8?B?QVR4TVp5SGV1bHg2UGp5U3lXSVV0am1TQlhabWFRMlF4RlNzZDFJWXNVRWVz?=
 =?utf-8?B?VGV4K2NvNmxuSGZnVGh4RWQwZlVRcE5rV3pDN00yUU5meFZ3MFdVUlI2ckIv?=
 =?utf-8?B?dDJ4UG9WcHhUL3N2bFIrV3hhRUllUmw2NjhTbGhqWjZjMkU0Q3lHYmdWMUkv?=
 =?utf-8?B?UjFmQzdVdm83M3RRZGo0S2pVNnNJalB6bmtHRUVVNGNGcWlPVXpiKzlmQitT?=
 =?utf-8?B?a3ZibStYNHVQL1ZzZmVBQlJweERCWmkwNU9GREkwU1NVRUo3amNkUkROZHFC?=
 =?utf-8?B?L2tUZWprN0FiMU5Wd05TVUh2enBIYTRDZElMdnhkeTBacldJUHJJK0x4NVlv?=
 =?utf-8?B?cHBKaC9zWmt6R1BKL2hBTmpGd2luTzJlaTNxZ0pyZEJ4THd5a0hOUFNHVUZW?=
 =?utf-8?B?ZG9uaUdTRnYyVVp5UkZHanlhVlllZ1JsL0luandyOWdvaWVwYUowb0RVaUJC?=
 =?utf-8?B?dmRpd09xWFU4K3hXekxIVG5tdW9NWGQ4TG10Z3J1aUZZMTVZN0dzbVgyOEh4?=
 =?utf-8?B?RW1kRm9hZWxPbmE1b1ljQkJRd3hIbkVFV3Q5VkdnZ3Fsd2xoSVY5SXZMeWgr?=
 =?utf-8?B?aUJnWUdkVWpma1lackJvK093SjZlV1BJLzNseGZrbks3Tkgzb3BMeWJxelc1?=
 =?utf-8?B?eXdId0p1ZlloUW1KdVBNbXV5RnpjcmRDU1ZGNWJMbStSYTlKMmlzYU0vN2gv?=
 =?utf-8?B?YjZxeUROL01jUVZEYTZhcDhCb2ZIU28yNGlRdnRyditaWDhNMVFZSWQyWmN1?=
 =?utf-8?B?VXZZZU8vTDh3bmtEd2JhS1FJdTRMUDVXNUl4ek1oR09zQkpsajVKdWphbE5Y?=
 =?utf-8?B?QmNsWjhWN0pYNVErUmt0dllLZlArTWs1MU1pTDJYczBjWWx3aFdNYUs2MEZn?=
 =?utf-8?B?RXduSERBWGRBdFRSMmhTcnJnT2ZkdFNzTnhqZGNyaUdBOG9ldzBTSkVoVkha?=
 =?utf-8?B?azlWTEtFcTZUS0p5Y21IWWFMKzM4blo2QTRtZndXVVJ0N3BoVjV5UWFER0li?=
 =?utf-8?B?UnFtTm5OeHhNV1pTTFp1SHpBdXpOcjI4NnZ0R0x1cGFxUEdUUUVkK2VZQ3FX?=
 =?utf-8?B?czBYa2pTdVZTSDFiWHcxNnh4YVBjcE5rcElzS1BpdU0wYzd2ZDVzMVQ2aWl3?=
 =?utf-8?B?Q2xoeHBYeGFpaTVIYS9rZ0h0bktkT2ZDbGplRVczbWxoNms1WUF6TWhVMDEv?=
 =?utf-8?B?ZFNTVUJuY1pqTmNlcGt2S1ROenVaYUZtTk1ZSkZiOEtQYkFuazdHekFxcW81?=
 =?utf-8?B?bkgwYmxzSk5wQXJiODRwc05YZGtac2JZN0lwR3FUQUxVZXRQSTFKYm14dHlG?=
 =?utf-8?B?OWZYT3ZRR21NLzlsRTYwK2NZUUFheVVaTmpubVF0ZUFZY2puZzdXcGdHMFNQ?=
 =?utf-8?B?eE55L3RqWUM2TWRncHBQbnVrWks5U0tSSTU0alFETTgyekl2TmJhVDR4UUds?=
 =?utf-8?B?bytGUDJiNm1VUnZNOThmUUdDcjBlZTBUUVFReU5md3cxS3RLUjM5bFpkZy9W?=
 =?utf-8?B?U2V2bWRxRG5lVHBQNzdyN0IxSmEzcVprd2RSTVhsbDlUREQwUmpJZkdwL0Rh?=
 =?utf-8?Q?WUVy96CURdCKj4kxQj2N0oYHX?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b726784-8bfa-4412-340c-08dd1ad802cf
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 18:08:42.0377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5BbxSRYgUdebONMnHlP5zI/NERJR7ryEu7zH1VYhjEsXtark11dWrlakz6ibQD91WUu3T+xZy5/ST3naXBnbSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6838
X-OriginatorOrg: intel.com

On 12/12/2024 6:01 AM, Qiuxu Zhuo wrote:
> Get HYGON to directly call mce_amd_feature_init() and remove the
> redundant mce_hygon_feature_init().
> 
> Suggested-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> ---

Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>

