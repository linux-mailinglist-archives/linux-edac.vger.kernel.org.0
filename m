Return-Path: <linux-edac+bounces-2201-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B58E79AC169
	for <lists+linux-edac@lfdr.de>; Wed, 23 Oct 2024 10:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3895A1F20A9C
	for <lists+linux-edac@lfdr.de>; Wed, 23 Oct 2024 08:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62379155352;
	Wed, 23 Oct 2024 08:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lvdinjEx"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AF0487BE;
	Wed, 23 Oct 2024 08:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729671630; cv=fail; b=PCmO7efGnN1ZMVC5IBRyegKS9fFjpqfwhlrpyRe1ssuxowc+MFkb6/RiMKVBuohiT0ekUwLb+9f59Hqm+gHtuE/QDVdR+erULnrLkpiOsLZ3hSU3Svc16e10H4cW9dzMpQ9ktsMsnHyCcFqCa3XbRymVESj3dFSzhcqB2giyPSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729671630; c=relaxed/simple;
	bh=kXu3TGbtmC5KrBw/463lBNYvs+KA4bMhTxOSBynUBt0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lVSVMmnI5Zu/+4j96OK4tZRn2Z9gO4XJ8a5243ym17uDLXXvY1IyEvvk75Lp8sRXF3xc+7J/JsDLoHbClHre/FoJ9sFH0QE9NJKQSXQfvHPAWn8zZAm3YzQVagigiQCATispoNOQvBDLPHrZZtvmKNFLGfQIGnkMbAP9Cfopj3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lvdinjEx; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729671629; x=1761207629;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kXu3TGbtmC5KrBw/463lBNYvs+KA4bMhTxOSBynUBt0=;
  b=lvdinjExb2Q5Z2q7ySokr+1o7e2m4LOsclAfeUYPJg0YTZYyiCTCJQ6X
   LE6JOcVsSKk69ZTViMEGVm9VGplfsXvWQWuzIG/lWEO4+sKMBhwlwxCpz
   iWG16D9EI2uJLvPQsO2yX+d1Op/EA+DpTc4XsxkEyV02ZIRNpIzFBUaic
   S2CFBu3jCdI3ad9AzQSwd/OomWjqBxfhJQ3WpJrZhlSoDUcNuR4vzSseP
   KEgVMh9aTi5g7T14DT4Wwei7vGWYptLi+rlPMEQpOo8PWuVSKsmCuO2Ks
   8fyIXiNFmWr8+eTmPCnAhTbo6Z9sUZHu2HP0bUYnR5VBLaW5cdg499kfF
   Q==;
X-CSE-ConnectionGUID: 1Q6qd5MTRjaNoYkxC5Bnrg==
X-CSE-MsgGUID: dgOvd3dFSH+gvVSBnO8tDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="54645663"
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="54645663"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 01:20:28 -0700
X-CSE-ConnectionGUID: iErRmLP5Sx6P4crgwTW6Xw==
X-CSE-MsgGUID: l1jwGlyFT2atWAgDKKMP/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="84707640"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2024 01:20:28 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 01:20:27 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 23 Oct 2024 01:20:27 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 01:20:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N3OjWUYylabphaW7MWn+A8q5HiN4d8eQlEkhUa2UOazfVtD+BJHIWY3h9N6YsBQJyKnhstHzyCfIk6thiJ3PkHNVi8ks7ZqTZaVTBiuQDJAC3lJuGgPyLZ31ymYQsTstSG2SkGAyZ98MibRXNGm2LcXv1Zw9QmntldYVw71F/vhrvdEQpVkwc41TqSosrjp96sddYJMsL3rTopJbsNr9cwEzF+D3Mcce2Z9TuUDvWEwrXdN34dmJxygCosBrlvTsU+XCQfQcMMbeVzKkhWTZUlFEBRrW6MsS52ZQyb2TaeEgf/xcKwvRGUoI7QuLXANmdw2l9Aly0VY0Ft9/iI6j3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kXu3TGbtmC5KrBw/463lBNYvs+KA4bMhTxOSBynUBt0=;
 b=FNNiIDLvb/PBY75LtUAH5NDJ7PGZsEOK+IlbhNFK8ABY6W1GJtvjSwfd9HlI/Degd7thdi7sanMgNlC5LTyesn45jSAQMJcKIDkl/J5xepxB+MLUlyyS3nT2SKI7FwC2yA14ANdbDew/fZes41KfaLJeakkJ2TztInWAFJzWSTSmn8puY7tSfvke8wVNWq6yM7qiYOZKHyXx1qvZkx4b7KgNWnC8yMW61e7RXpzXIlP4kqEoaBBPn8XDnk6KPMJnSOZtJFIsIrP7AV0wHtwG/hKbv4jN4AEIn2y9UuNfI5XA25zgD45UoPMdOxMy396S2FLULEHLsmWflGEOdzahKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by MW3PR11MB4586.namprd11.prod.outlook.com (2603:10b6:303:5e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Wed, 23 Oct
 2024 08:20:22 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%7]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 08:20:22 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: "Hansen, Dave" <dave.hansen@intel.com>, "Luck, Tony"
	<tony.luck@intel.com>, "Mehta, Sohil" <sohil.mehta@intel.com>
CC: "bp@alien8.de" <bp@alien8.de>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"x86@kernel.org" <x86@kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 06/10] x86/mce: Convert multiple if () statements into
 a switch() statement
Thread-Topic: [PATCH v2 06/10] x86/mce: Convert multiple if () statements into
 a switch() statement
Thread-Index: AQHbH8qMGT1zWO0jCkCWfyye27yAq7KM7JIAgAAIpQCAAEAyAIAAVvpwgAPafYCAAAbqAIACmD2A
Date: Wed, 23 Oct 2024 08:20:22 +0000
Message-ID: <CY8PR11MB7134E2BD84013EF41F8F5AC8894D2@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-7-qiuxu.zhuo@intel.com>
 <c928d9aa-1609-4f5f-943c-fec72091e989@intel.com>
 <ZxLBwO4HkkJG4WYn@agluck-desk3.sc.intel.com>
 <2d011a77-a46e-4589-ae91-80d8d29e4124@intel.com>
 <CY8PR11MB71348AA655274E611CFFFE6C89412@CY8PR11MB7134.namprd11.prod.outlook.com>
 <SJ1PR11MB6083262976EDEC69FFF449FAFC432@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <c9ffb6b0-9c75-4990-afb5-33094d049570@intel.com>
In-Reply-To: <c9ffb6b0-9c75-4990-afb5-33094d049570@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|MW3PR11MB4586:EE_
x-ms-office365-filtering-correlation-id: 9c90cb3c-29e2-4db8-28f7-08dcf33b89fc
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZUZ6c3o4bVRtWWF2emhoU2Fic0NnT2lMallPa25FVUhHQmhkcXVRUEVQYVc0?=
 =?utf-8?B?cXk2bzdua1hERms2TEpiVlZGT1h3MkRhODFrak9KeFlBRGNCaE5LWEU3OXVX?=
 =?utf-8?B?MExCNUZiWUFqdmxnRWlyMi9tLzErNDVRREJGOGtHVUxvcmJicW13YXRGS0dl?=
 =?utf-8?B?NVlpTFd0R1ROZDRDK2ZwUlNNelBJbERXSTdNMWFxYTIxS2M2L3VBMENTd2cz?=
 =?utf-8?B?V094UnRpb3dtQmFjd1RFeUxuMnJRdkh5enJabWNsd1YrTkduOVBIaE0wRlhR?=
 =?utf-8?B?VDlEVlBpZmEyVndLTkpoVXozdmw4MDZpNnNBR0VhSll3cW9BR2R1K2Q1aVY5?=
 =?utf-8?B?TmcwalpYYXdxZnJmVVlPNFFmRHcxWW5nTnkyZDhCeXNCLzJ2cXlNcm9ZbXU0?=
 =?utf-8?B?dHo2VjVnb0FmeUxFT0orOWNxUjc0MVBaT0lzZlJkNGs1SzBHV0V5ZWRrYVVx?=
 =?utf-8?B?Z3Q3YXhLWCs0aENLNklvUkFmR3hoWDZ4bERpMmRReHRZNUEyRmZGODVHMzBP?=
 =?utf-8?B?K2Y2QXYzaXBXR3VhbkRScVBRcFp1VEh3d1pCR0dkVUpLTzJYMTdlRTB6bHRr?=
 =?utf-8?B?U2VBUmN5eEpIeEJORmJBdmVpR09kRUJTMEo4TFJmdVZ4VGovQnV0WnFKZFho?=
 =?utf-8?B?MjJOdXNmSllxcXVVc2p2eGtBbWZrc2R4VlpoME1mYnpXeFhwdFZlNnVUOXNE?=
 =?utf-8?B?SXZGTHA5Tk1EZFJITXYvVlNtYkxqZnhQbEdsMWxKdG51eE4vYStqVmVjN2JJ?=
 =?utf-8?B?bHdLeWtLSTc2QnhZSjZmQnhKd1ZUZlpXbHNYY1BSbDBsNVFmOFYzbEU5QkVB?=
 =?utf-8?B?dE9xOVVqTnBmS2NQQlYyVUVnenBEczk5M29VQ2tKeWRxbE1LazAybGZadkUw?=
 =?utf-8?B?TGhaaGJEUjM0VmEzazVWUUJHTFVIMkpFcFMwbWU5UTMrTGtyQUV2WFVJZHJJ?=
 =?utf-8?B?MXZOaXRaMFZ2TlRkbVd6L1hyMmc1cDlvSDYxa290UEVKaTNSd0xhLzl5VFRE?=
 =?utf-8?B?bWx4SzNNWit5bmpqTUQyWW1TVzFjOW4zeTJKaFI5cDNlU01LK1N4NmZRaVNo?=
 =?utf-8?B?Z09IQTZzTHpqUTdNZkpjTVc2Y0F4eW95ZGJkWVkzc0NWNytSVVpCUTVBMEhm?=
 =?utf-8?B?TEE4U1lBRkdrbGVpbVFTZlN6WTNocHhyVjk0anAvelZpelRtV2EyNytrL05V?=
 =?utf-8?B?NTM0QWZNeFowSmd6ZHgvS3ljcFZJN3N2RWFKaHRwckZUbGlwK0JaZUx2WlN4?=
 =?utf-8?B?Q2pYVjRWemFRN29iRkNXT1dNZGYybFFmTmZQcnBqN2swWVVxUUNQTEJFdlZ3?=
 =?utf-8?B?VUM3ejR5VEorWmh2dDRLYmtNcW9ZdEVLRFRYZUJYbVpXWmJwdzdnWTRtN2xY?=
 =?utf-8?B?T01lRkUzWXdhOFdmaTZWM3V3L2pJQTFMNWR1eFhkZDl0c1ZVSTlDZEExcmR2?=
 =?utf-8?B?VVZ4cFJQZFZWNEtTK3hWNHlVbWxaTTBUVkY3eWthbDJPaGFnNmdCZ3pqdzl6?=
 =?utf-8?B?RWRoSzJtVVJ4a1NWZ3JoWlhFVnF5VFpOSnIzODNaakJoeHBRUGpDOWZPRXZI?=
 =?utf-8?B?Vjk4ZzlLZ1ZiZEhEZ2RmMFoyMnNrYXZYaGpkUmdpRlZZcUpKYlZFUUxheTNJ?=
 =?utf-8?B?TmJJNG01Y3drbEVRSXZ6RmNBd1NkQlYxeXptV2NZZXBMTnY3SjRlL28xeWxj?=
 =?utf-8?B?L0hQRmxBRjhldHFqNmFMc0hRaDJGNUJnd0t5VkpKVFdhL09CRGk5TkFRNkpO?=
 =?utf-8?B?RlJKUG1xUDVRalhVczQ2S3M2T2UvZlhtMHAyblMyanRwQ0ZkZmZqRjB4YUFs?=
 =?utf-8?Q?pQIVLS/3lVttuR9sv+7wuIXA4yGnki4zOsx1I=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WjZlN1Y0SzJ6UWk0NlVETVhha2p3ZktWTFNjendtSTg2SytHdEQ4RTdDTHU4?=
 =?utf-8?B?SktRUlFpWmtFRnNoWTlWZ29Vc0lLNEYrVlE0VEpWSXRGNHlWeDBiak9WbUl4?=
 =?utf-8?B?bnNybnZ0WWFKVTMzZVZMQmtJQWMyeThvSk5qT29SeDRvVFNOSTdZVk4wTGs3?=
 =?utf-8?B?MmRGVXlMQ2dJaFNLN05JTHN0WjIzTEtZT01wUFFLeTY0S09NemJKWm9sSWxR?=
 =?utf-8?B?UldEYXpRbnM5YzZtS3NJMHByQVo5c1lCYVJCUitKbUlEdTFIMGR2emtUL2k0?=
 =?utf-8?B?ZHRHRkx3dFlvWHNNSWpnMWpIODM1OW42VWtWK0djTENoejAweUFyQjhBVzBy?=
 =?utf-8?B?ek1lVnI0OXBoRjZ2SnRJbTJiNmcxaXBSUk56RjBHN3FOZjVtUWhHRmtob1Vz?=
 =?utf-8?B?LzYvUnN2YlBaUXd3TmFQUTlHYTNwU1FHaEpSeUUrOEx6andRaW83d0dhVzky?=
 =?utf-8?B?N1pCRlJ0MTBPK1oyZWd0Q1c2QytGd2cyb3I4em90T1NSUS9ZektiaGFUaHg5?=
 =?utf-8?B?bVdaRnRxd29zdXorQ1RSSkRXa1dkSVJTb2gxZ3pvYUdKcVVVNDMzZi9WR2tk?=
 =?utf-8?B?angyRTZnK0wwSlpwUStLaWlDVVYwL0Via3lBTFdES3UwMWVMVjk2M2ZkQXBB?=
 =?utf-8?B?S2tleU5jMHNRcXZ4R0hyQUthSUxkZ2Vqck1pdjRtUjdwRlU2SnlWcnRaeENP?=
 =?utf-8?B?UGtPM2NFNUs3RUh5TUdOZldjT2tjb09YeTc0SHY5eXEvaUZDMmkxR2w5Z2cv?=
 =?utf-8?B?ZXdtNXFXTUtYZ0tEQ2lzMUNLL2NBV1dSNThKNSsxUjdlSHo0L2tnSVl6Qzlv?=
 =?utf-8?B?WFlwYzVtaEtpNVJ3TVEwN2pyMFNUTzhtNUZEVTBUMU1uSWhQeWZLUUlwREsx?=
 =?utf-8?B?MGRPSWdiSnNxS0grNWU4ME00aXIwakhlelpsVlBzUjJPUXZGM2JvRURzMGlO?=
 =?utf-8?B?M0h3TStvU2xzd0ZvRlhrMnZCWkY4a09yMWh2UmtTYzBRVjNJNG5jOHp3OGVL?=
 =?utf-8?B?Vkc1a0V2UThOQTFDTTZOWWQzZnB4b1VjdjJucTFOYVlZZnI0RDNDUzJ4SW9V?=
 =?utf-8?B?WHQwbFFjUTY4VXh6Njg2VGZWRkhXYi9iMDh6UUpmU2JFdnJDeHBhM1k0WWR1?=
 =?utf-8?B?VEh3SlBjY3Q3MUhnNzFuWXZlbEt2ZTdUbzZIV2VoUFI4dktjeWwwOWVpR1p6?=
 =?utf-8?B?Wm1zSmhkdlEvZ3hOM2RnYW1tMkNEMi9mZFZvVVJpOThVYVZLZ0xFY1lvdTcy?=
 =?utf-8?B?M0xnMDFNdERRS0pMdlkzQzVnclR6V1ZEZlVwNW1xU1pPRWhZTzkvemRUWjJI?=
 =?utf-8?B?QlI5WlhLTzhHTWk1L1pxdGxIQWtQUVpJR2FpdHMvdyswTHBoTG5UMlgrU1Vy?=
 =?utf-8?B?NXJaRER3VEFwNndSZ3dYTWN4TmladXFFcEtNMktGRlo4c0twTDBXVSt4dnJW?=
 =?utf-8?B?WXpiTkxrLzBqLy9kVmJiOUQxd1ZSbXQxRm1NbzlZcDBGSklCQjhnTnJ6YlJU?=
 =?utf-8?B?b29wTFZUb2ZDSEEyaCtpNlJEdXlMYjdXU3hxWDc5aG03bm9mUit4YTAyblJ1?=
 =?utf-8?B?K1hMeGo5eTh6TWdlcHlNMktNSkJ0aU1xbUlRTy9uNGdTL1U3K3FTQk02WDZl?=
 =?utf-8?B?dVBOYUQ0c05OL2xIazZzVmVibjVKS21FTXkxVzMza1MxUmtVdElmenpUWGt6?=
 =?utf-8?B?VWlyVm5FZGNjNzFUWnFOTVY4ajN4dVpia0EzYnRuTGlmOFVkNnlRQW1WUDdm?=
 =?utf-8?B?QjlKTnYyY2NyVnJHZXg4V3pIUkljbWw0QlhwMjY1ckRzSHJRYmZZRjUwcy94?=
 =?utf-8?B?bXdVc1pjNFlCWFNTRnBxdVFEaWFhYm9XSDNGU0Z1cEFpZWZLdVVIemtESmds?=
 =?utf-8?B?K2xXSTQ4d1NlWm9zbmI3YjhWd21reXI3djJ5Z0FyQWg0VlA0R3RRMG05M1E5?=
 =?utf-8?B?Q1ZXTWRtY0I2L0lHT2lFclRWak5lRitESFJybzRKTy9Ic0VKeGFaMklzbDBj?=
 =?utf-8?B?M1BmNVJ1aGlkd2dZTW9GRDkxb0tKT3VMVmF4Wkt1VHNGL2xDN3ZpcFYwellS?=
 =?utf-8?B?T2ZYbVNwVEs3VWJ0dnpHdjhHa3hHcTlNNmhRSk5qVm5ZRzdIcGlaS1lydVlM?=
 =?utf-8?Q?bsECSyuvBFZg+GpBPWdCQcqgq?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c90cb3c-29e2-4db8-28f7-08dcf33b89fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 08:20:22.3356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: agx+cE/oiFY9ovwXbbGD4SsX9e5l5rgoJUwErYeXM1qJ3CMI7kP9T+1Zvm+rrIM9F1ateQE/On+E56AR3IM6gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4586
X-OriginatorOrg: intel.com

PiBGcm9tOiBIYW5zZW4sIERhdmUgPGRhdmUuaGFuc2VuQGludGVsLmNvbT4NCj4gWy4uLl0NCj4g
T24gMTAvMjEvMjQgMDk6MDYsIEx1Y2ssIFRvbnkgd3JvdGU6DQo+ID4+ICAgICAgICAgLyoNCj4g
Pj4gICAgICAgICAgKiBBbGwgbmV3ZXIgSW50ZWwgc3lzdGVtcyBzdXBwb3J0IE1DRSBicm9hZGNh
c3RpbmcuIEVuYWJsZQ0KPiA+PiAgICAgICAgICAqIHN5bmNocm9uaXphdGlvbiB3aXRoIGEgb25l
IHNlY29uZCB0aW1lb3V0Lg0KPiA+PiAgICAgICAgICAqLw0KPiA+PiAtICAgICAgIGlmICgoYy0+
eDg2ID4gNiB8fCAoYy0+eDg2ID09IDYgJiYgYy0+eDg2X21vZGVsID49IDB4ZSkpICYmDQo+ID4+
IC0gICAgICAgICAgIGNmZy0+bW9uYXJjaF90aW1lb3V0IDwgMCkNCj4gPj4gKyAgICAgICBpZiAo
Yy0+eDg2X3ZmbSA+PSBJTlRFTF9DT1JFX1lPTkFIICYmIGNmZy0+bW9uYXJjaF90aW1lb3V0IDwN
Cj4gPj4gKyAwKQ0KPiA+PiAgICAgICAgICAgICAgICAgY2ZnLT5tb25hcmNoX3RpbWVvdXQgPSBV
U0VDX1BFUl9TRUM7DQo+ID4gVGhpcyBjaGFuZ2UgaXMgY29ycmVjdC4gQnV0IHRoZSBvbGQgY29k
ZSBtYWtlcyBpdCBtb3JlIGV4cGxpY2l0IHRoYXQNCj4gPiBDUFVzIGluIGZhbWlsaWVzID4gNiB0
YWtlIHRoaXMgYWN0aW9uLiBBcyB0aGUgYXV0aG9yIG9mIHRoZSBWRk0NCj4gPiBjaGFuZ2VzIGl0
J3MgY2xlYXIgdG8gbWUsIG1heWJlIGxlc3Mgc28gdG8gb3RoZXJzPw0KPiA+DQo+ID4gQnV0IG1h
eWJlIGl0cyBPSy4gIFRoZSBjb21tZW50IGRvZXMgaGVscCBhIGxvdC4gQW55b25lIGVsc2UgaGF2
ZSB0aG91Z2h0cw0KPiBvbiB0aGlzPw0KPiANCj4gSXQgY2VydGFpbmx5IGlzIGEgYml0IHN1YnRs
ZS4NCj4gDQo+IFRvIG1lLCB0aGUgZWFybGllciBjaGVjayB3b3VsZCBiZSBldmVuIGJldHRlciBp
ZiBpdCB3ZXJlOg0KPiANCj4gLQlpZiAoYy0+eDg2IDwgNikNCg0KVGhhbmtzLCBEYXZlLiANCk9L
LCBJJ2xsIHVwZGF0ZSBpdCBpbiB0aGUgbmV4dCB2ZXJzaW9uLiANCkFwYXJ0IGZyb20gdGhpcywg
SSdsbCBhbHNvIGFkZCBhIGNvbW1lbnQgYmVsb3csIGFzIHN1Z2dlc3RlZCBieSBTb2hpbCwgdG8g
bWFrZSBpdCBleHBsaWNpdCB0aGF0IGl0J3MgZm9yIHByaW9yIHRvIGZhbWlseSA2Lg0KDQogICAv
KiBPbGRlciBDUFVzIChwcmlvciB0byBmYW1pbHkgNikgZG9uJ3QgbmVlZCBxdWlya3MgKi8NCj4g
KwlpZiAoYy0+eDg2X3ZmbSA8IElOVEVMX1BFTlRJVU1fUFJPKQ0KPiAJCXJldHVybjsNCj4gDQo+
IFRoYXQgYXQgbGVhc3QgbWFrZXMgaXQgbW9yZSBjbGVhciB0aGF0IGl0J3MgYSByYW5nZSBvZiBt
b2RlbHMgYW5kIGF2b2lkcyBoYXZpbmcNCj4gYSAtPng4NiBjaGVjayBtaXhlZCB3aXRoIGEgLT54
ODZfdmZtIG9uZS4NCg==

