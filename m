Return-Path: <linux-edac+bounces-3944-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA659ABC8D1
	for <lists+linux-edac@lfdr.de>; Mon, 19 May 2025 23:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90A963AE005
	for <lists+linux-edac@lfdr.de>; Mon, 19 May 2025 21:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA6921ADC7;
	Mon, 19 May 2025 21:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HINiW166"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF621D63FC;
	Mon, 19 May 2025 21:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747688498; cv=fail; b=iUKcIB2nZ37hN+dMdsqcyw+T6vp6Ha2pm5LZHmnsIBDQFmYcpSBmRphbdQXeq1N51PKIMKflwCz84TxlO9+D8Qzjjp9dplJyyu1h9P340OlsZdzaNwDSgLqigF8gB6WO/3wnoLxdWNCC899WhudlnuSS/WkSqGyguUYoNT4EuUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747688498; c=relaxed/simple;
	bh=xwGJzeLC9nOa+CIQVlSDotMz8l+vk0WixDcFr+DhLMI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cHeYTTFQLxv6qYvxEDfYI0wKNbBwHs1z3Yinr2PsD4YccwL51my7iad0aMymFJJgQwCLNB4bVG2kFp1xm48COuEJAtTsvQL119UjdT/kxwKEbUCnYOjum1FsJ6UY7rMh19rx42U2jEhlCYc3ZDaX4UhRnIeTuIkxi0KfvBPs0NM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HINiW166; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747688497; x=1779224497;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=xwGJzeLC9nOa+CIQVlSDotMz8l+vk0WixDcFr+DhLMI=;
  b=HINiW1669HVdb6LbNhUXBvUhaMkPOAJwD9oaBhKAahRjM3TXpiL8gcIe
   on+90WroMfVChw2EchQ1RNp5c8/hDRiQeaAZkwYeOgr0hcdv7s5mECen5
   3fDYRxeq0prGHWCHXFZaMzfpdN2zILaY44+h8k0Gqn7IZVcCwWoVLpBHt
   2UXxmkOYO9d3tzQ3pGORtOWkpEqKszHmduYMWT6/MMd9Z+PFTTEGXTJBq
   WPYa8RryAcyeis7OqOz52sGN/qaqI2T7TFskfGixanI+QGvYpbvMoEhyO
   +mBkW+z/TyzzpUgSTUXtl+doAZgz9uhiWjS9TfhC8cPeTRr70wQk6gHLH
   g==;
X-CSE-ConnectionGUID: oLOFJqCrTZiB9jhloTlX5A==
X-CSE-MsgGUID: H06B+ggdRnikERetFxwkmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="60637982"
X-IronPort-AV: E=Sophos;i="6.15,301,1739865600"; 
   d="scan'208";a="60637982"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 14:01:33 -0700
X-CSE-ConnectionGUID: TV8D1XVQQOGOcpDuH7rcYw==
X-CSE-MsgGUID: wqZHv2HHTHW25NCG/ylCRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,301,1739865600"; 
   d="scan'208";a="139386670"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 14:01:31 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 19 May 2025 14:01:30 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 19 May 2025 14:01:30 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 19 May 2025 14:01:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WTTVw+8quM1U/VDd5R21D1G/w+0G3qrEKqEdmUotPWlTsYyVJVS8T5VWQgXeG9eKj0RXh9V7dvvR31lFBgNThkwpl7GR67sA+mOhila4WE2CBzBKai08RsVFYmPAW0H2eenj8yT1MFzMUeGt88y0L4C3J3GQqrQAyaT3RqFU+J+IWGPLHCcZbQavz0UIM1BdPrZzMRxjPoT+enetxV895xqUtWR6TJC/ukEno3i5R1eMOenL5f8u1j5jtTWjnKdyu1g8U4MYUqH6ruokoAIgX6EchJN3pDh+LRf9dfj8n/+E0cRuNSXbZzY/MFl4T+BaNq+0QfnJEHHojN7qpg/IiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hVc3sgcEvuy7WqQ9vLRAyCWkegsXDOIRs5ZN9OmsmYg=;
 b=ZZ1gZ9GPGMGPRNXOhqn78GTuV9w6ua+QF9O+uipZa9e/lJm5MGq6ySmD1Y3LaJ/Soblg8j+DS+F8gm5rPPnp3KUh35jH5zwJGNHkHIDJvG3dhZa2RuJPjpf1kmHKQ/MlYHuakqRt0Iib6oGxjUPSdFOrvJqyW6GQEbDaiTNYNa8NeeS90+R6mSQv7FWMP1tMxZMUyf+o+OMtTRAkDuMAphV7N6q97+/j03nAiB3oAdaJuI21rboQK4A7HOqDtDTl/m2kZXEIqALEzqwND+RckFDdTxHxS0mc95AW3epf9GL7ee0V8MXUBbnUkPkMP0hzTZIjdZVEchys/p6WBMriXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by DS7PR11MB7905.namprd11.prod.outlook.com (2603:10b6:8:ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 21:01:28 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%5]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 21:01:28 +0000
Date: Mon, 19 May 2025 14:01:23 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: <shiju.jose@huawei.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>, <dave@stgolabs.net>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<linux-edac@vger.kernel.org>, <linux-doc@vger.kernel.org>, <bp@alien8.de>,
	<tony.luck@intel.com>, <lenb@kernel.org>, <Yazen.Ghannam@amd.com>,
	<mchehab@kernel.org>, <nifan.cxl@gmail.com>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<roberto.sassu@huawei.com>, <kangkang.shen@futurewei.com>,
	<wanghuiqiang@huawei.com>
Subject: Re: [PATCH v5 7/8] cxl/edac: Add CXL memory device memory sparing
 control feature
Message-ID: <aCucI3TPynSycGug@aschofie-mobl2.lan>
References: <20250515115927.772-1-shiju.jose@huawei.com>
 <20250515115927.772-8-shiju.jose@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250515115927.772-8-shiju.jose@huawei.com>
X-ClientProxiedBy: BYAPR01CA0047.prod.exchangelabs.com (2603:10b6:a03:94::24)
 To SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|DS7PR11MB7905:EE_
X-MS-Office365-Filtering-Correlation-Id: dfdfeda3-4284-4f90-6cd7-08dd971852bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Mld1QlpZamkwanBZa1BRamN5MGFEbW5JQThMZnhOZHkxNmd1NTNMV2xBemxY?=
 =?utf-8?B?VERJRFNCNktkMkxiY3FwZ09TTVF2Y0s5YjVDT0s2NXRGYnhyQit2aVc4emxL?=
 =?utf-8?B?eEljOGZNRjNuZ0VzMDNGOENxZWxNS2FxZHdTdk9aMGJuNHRRc3FnUnRiRDVU?=
 =?utf-8?B?L3NKdGY0RE5BTzdHSFdvR0NWdFNJL1Q1eHVHb0pXYWF1ODk0dDRWUTlQQUNW?=
 =?utf-8?B?S05GUDJxY2prRUJMKzd0MCtJblA2MWlZODRDTnZsa2NxQkM1K1U3WnZWVG1l?=
 =?utf-8?B?RmZTN1lXblZ4cm9aUkcwU3NFV1RPbXVBUjN6WENzK0w4eGh1V0pYUWtkeXNr?=
 =?utf-8?B?N2NlT2V4TndjeS9SaVlmS2g2U0lxRWo2QW5aTk9tbE56ZURyTzg2RFdPVjQv?=
 =?utf-8?B?MzRZSS9scUxmWk5nUEx5N082RWdiOUdsVVhQTEZJS2NkTnQ2QkJUWldiTmNR?=
 =?utf-8?B?U3FxeXg3M3QvR202SFlrMkptV2orNUtDeUJYVHhramVtQkVhUUloSWpJd3BG?=
 =?utf-8?B?TTFKQlE5RmN2eVdoMnZqSm94KzFlSkFpN1gwTWVzVjd5L1hMOEtpTzRuZWhU?=
 =?utf-8?B?MXVqb0ZWVW1meURoWFN0Ly9GSkg2MjhxcUpZcnBLR0ZIZ2VCQXBXaVMwS1g1?=
 =?utf-8?B?T05od0xYeEd0ZnRyNWR6NVFxL1VqejRONlNGZFh1STM1NlZPWEY1R3AyY2FD?=
 =?utf-8?B?NllwOFlrN0lPbGVrdGNxREhqSDYxdVNaT3JLMjRsZS9YTmpRc1NLUUs3aTQ4?=
 =?utf-8?B?cnYyaEhhTWpxcHFmU1RnNGFXSmNGUDRUcjA2M0ZrblhDZVhhTUU5dllLOGVG?=
 =?utf-8?B?Qm13ajdNV3ROeGJ5dVFQMTF5Y09nTEo5WkN1dERUNnVEeVM3SXlMZGxrUUtB?=
 =?utf-8?B?VGY3TjFreFZRYlh1VkE1aThCYVQ0S2tUQ3dDV1pNUThDT0xGS1JrbUozaWF0?=
 =?utf-8?B?RUZ5alVILzhxcVc1cERtcm5PWVBpQVBPQjR0c2ZJWmVIeVR3Z2tKZnBkVFBE?=
 =?utf-8?B?TUtha21Gb3FMcjVYSVBCWHc0NVFlell2ZkdPNWR0UndwMWxITno5ei81c29Q?=
 =?utf-8?B?ZlRhWW5qVVFSNExISzdFc3J6Q3VaL3BtakV6N1hKZUhXNDBOSTZRenBKY0M3?=
 =?utf-8?B?N0V4SThCRGNHZXFiQjdmQjNXV0E0dFlBYzFBVEZ3bTg0VVRXeWxuNnZHenI3?=
 =?utf-8?B?ZSsrTjl3NnZvU2VHUHRPYXJNWk1TNXY0WUdPSWVscGl3RmpqL0JWYU9WcE1p?=
 =?utf-8?B?ZWFVK3VhSjF1anhmV2IrNGNFazExdlZXdTlZWlhzOHRRTGZNd2JMMmtINjhX?=
 =?utf-8?B?UFI4NDgxNDFiMk9FVHYzSWJoZ3Fjem9QR3hVWlcwclc3bk5JNzFLTE5MSHhC?=
 =?utf-8?B?eEthU0RRM3E0SXMvU3IxWk9CRFhva29lUlZ4UmNYNnNvT2c4SkdwalordUl4?=
 =?utf-8?B?NjE1aW9VR0NoNjM3ZHo5ZjFaUDJBZlJ5L3I0WStsdlovbWlMNm8wQmI3WXlx?=
 =?utf-8?B?MjNSdVE1L3RFRHVMQ2cxRGMzVk9TeFIvWVA5UWhqaG9qUzlscXgzODJCUXR4?=
 =?utf-8?B?ZlR5eCtjUk9Rb2pqZ2MxQ1RkQnBnYUVMbHBicXcxNHJoRTkvRkdkbW1yNTcv?=
 =?utf-8?B?MGpDU3NOMW5OVmMvTjh4V0FpN040MUlMb1RueWFJS2YycG12TFQvN0xhT21E?=
 =?utf-8?B?U1RyRjVna1QrWnE1M2RweUhXYnc0T29IQVNEKzZVOG9NZkx4NThMZ3I1N1lG?=
 =?utf-8?B?Ny9acUNUdzZ6WG13ai9TbkdQV01Fam56QlNCaGtzOTF6clg3R0xXdXB5ZEwr?=
 =?utf-8?B?azR3VmdDTWh3MzhWQnd0anpkT3pLMnBrbmRHeHNFUllNT3orQks0aFpxTFJK?=
 =?utf-8?B?SHZHOTRsNUJZYnRUdHlhTTJEUkg5c0hNamJMWDdUQktzQ21DdmhpUzl5cjFp?=
 =?utf-8?Q?dTC9spBuSPM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDJoemxNWlBEckJhakJFMHdtQTZpWG5Zb1JlUEpxVFdwVlQ1dHRlT0wrbTFF?=
 =?utf-8?B?UG5YQVp3TGdaTytQeU90dXMraWNHWXFsd1YvVkNuUWt4dzhSajBoSFpGaEpG?=
 =?utf-8?B?TmdqbXJ6b3Irb2RtNUxlTDRTdjY3ZFc4aDBRL1N5WnZhRCtaV0RaZnM2SENT?=
 =?utf-8?B?UURmWC9aNENiVHJEV1BkVWdUNzY4TzBXZzB6NTlWN3NGYnpPZjVZbmduKzhT?=
 =?utf-8?B?eDNVMk55WTZmWFg0d3FUQ3FOYkZSM21SVXpSY2dIQXJzblBjc2N3TldFWWpZ?=
 =?utf-8?B?MGgrZnpTMG9Yb1Z2c2FaOUpsbnhiemZPRzVIM2h2dFlDYkdKOHlXWGNWejhJ?=
 =?utf-8?B?clN0ZkZxVktidDVnbTNhR292V0x2SmhWcWpnMDEyaDEvZ3hES0pVOHU2bkZk?=
 =?utf-8?B?RGY3cm1BYlBZQzVzNHNBOGVKS3hhNXIyL2NsK0pLc3RHZVZ3Q3RJNi9OaHVO?=
 =?utf-8?B?VmI1WGhiSGQzdjVaYkJGRk5RaXVMWjMzZnFMSExKdDN5ZTlpZ280b0U1WXM5?=
 =?utf-8?B?OVZSNEdaZ3M5RGhEMVoxVXczSUpXUFpxSCtuRnEwSnRoSnA4YlpuYnFsczZE?=
 =?utf-8?B?RWtUUWRudDdpSWhGVGVqWUYrWFQrblZZYW9aejVKRFBUY3VocU15bGoxaUYr?=
 =?utf-8?B?WVRobnpxUk1MQTJkNXhsWnR0VDBRdzh1cFpjcFV0S2ZyNjVTTnFYc0VqeGhs?=
 =?utf-8?B?ODg5UEQzbzg3ckxRWUtvRkxFZFB6aTBOckptOFhGOTVXWFE4OGFTNUN3Qmd5?=
 =?utf-8?B?SWdzMTFZT2JCYy93SzZkdnZoQ3RlbGx4TGE4UWVkWXR6V0txcit5WG41b2Jz?=
 =?utf-8?B?N2ZsL05SZXJXUDZQbWlHY0JQb2xMOFFnQ2lmRElXMEc2UmpzbituZlVTdW0v?=
 =?utf-8?B?TVlDNERzVzlqRXVHZHcvZEdHdVErTkJuMDVQOVFpOGR4b2xyeVJZUTlMV00v?=
 =?utf-8?B?NkI0d0lHd0FsemhBamZWLzlibS9EZ1NXYjQ0L0NaNzVuSVBmTk9qeTZlS3Rt?=
 =?utf-8?B?K3krR1FuUGI3NkZGT0R6ZVB4QVF6TkduTzNwNHR6YktoTGJTc2lDc0NuSEZJ?=
 =?utf-8?B?bGtPNWIxZU52Y04xdmYzV25CRDVOZHVPNVpiUEVCem9ZSlRtUm9EMWNFdG9u?=
 =?utf-8?B?dUtBZDluRjU5ejVDeFJsS2JVMk1mVGcxM1RRcWF3S0s1cVMyemxwOXJUc1dV?=
 =?utf-8?B?NnFLcGFkbW83Z0k5NmowaTVJbDZSSmYycy9DZzExZk5ncWxnRENURG8zMEJv?=
 =?utf-8?B?emR1cFdhSkkvb1FuTllxVEIwaUUvaW9rSjZydHBzdXlXUHllb3BVQUJvUFNs?=
 =?utf-8?B?czZsbWthZHYxemxzR0JnY05jQWJCTFZkVWdHc2VIQWlDSk9MajRZTVF2aThH?=
 =?utf-8?B?SnpqN3JDamxxMzhZV1pLTnpxRm5DZ1JZdmdWUXB6TmNnNHpnWUVvTEtYa0pp?=
 =?utf-8?B?VFZRTW00M3RGbktoT21HYTNKS0VHVmxIbVFKQTVZR013dEhsYVorUWdqTHQ5?=
 =?utf-8?B?RFBhWTE5Mlh3REd5UVZDUXJKbDg3UzE1cGlobGJMSnJMazFWd2lvWUhkaXh5?=
 =?utf-8?B?YjEvTlFyemhmUUdwK1pkN0FGbjIyNVhvRG9GVWM0bG9oTFF6M1dhQUVpcTNj?=
 =?utf-8?B?YXd3bTVtMFFYS3BuMytuYUJ6OGdTVjFTbGFLNXN1MWlBS1ZIRXFpV1llVldR?=
 =?utf-8?B?T1NDbzNZTTIzRFVtSDcza1lJbjhhOWd1K3lwYldFZHFGK3RPSk5SaHM3OGlz?=
 =?utf-8?B?VEhJZTE4ekdPVmhzRGNIN2NLUnhPb244Nm00M25RSEVKRzZxOHUzQWtKNFlI?=
 =?utf-8?B?Nm9mejI5MnhFdzZyOE15T3dxSTVZa0FXUGh3MStGS3VObW9nL3ZWOENjdE5k?=
 =?utf-8?B?MVp3QUo2TTNrUTdoYmtWNXVXdzhZVExhbW41SmlYZ1J3Q3lqVjNxSkNDaHBj?=
 =?utf-8?B?eWZKQnJYQk5jczlpeGd1Q1BnTmpHMDExZlJ6OEhwNk5SdXFvU2dXVWpxUGNj?=
 =?utf-8?B?WFZnRndHUUlVempSbXRoL0cycmlCaUYvMDQvdHlnd21yL2hmVDFnK09aSkh3?=
 =?utf-8?B?bk81MkJDNlBmWEUwcjRmYWNaRE81OVlISkZEaFZ3Y0VPT2Z6MUZHSFhUMFhi?=
 =?utf-8?B?ZFg5VWJCQVJSZW5UMkg4R2JkVHpVQzNXNFQ3Wnc4UHVGenJIODhSRm81MnND?=
 =?utf-8?B?d1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dfdfeda3-4284-4f90-6cd7-08dd971852bf
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 21:01:28.2485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Ilzyk8YjwAoTWPBN0D8nJJTpQIoE//vVTi8fAu9aymwm1RUIFEzQXX7ZawHKTJoPNR0bKuXyEUss2crodF9uiWbBaKc71C+yABj5oVRdrk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7905
X-OriginatorOrg: intel.com

On Thu, May 15, 2025 at 12:59:23PM +0100, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
>

snip

> diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
> index 489c9996bfbc..395d56457931 100644
> --- a/drivers/cxl/core/edac.c
> +++ b/drivers/cxl/core/edac.c
> @@ -21,7 +21,17 @@
>  #include "core.h"
>  #include "trace.h"
>  
> -#define CXL_NR_EDAC_DEV_FEATURES 2
> +#define CXL_NR_EDAC_DEV_FEATURES 6
> +
> +static bool cxl_is_memdev_memory_online(const struct cxl_memdev *cxlmd)
> +{
> +	struct cxl_port *port = cxlmd->endpoint;
> +
> +	if (port && cxl_num_decoders_committed(port))
> +		return true;
> +
> +	return false;
> +}
>  

Looks like above fcn needs to be inside the below #ifdef.
Smatch is warning this when EDAC_SCRUB is off

drivers/cxl/core/edac.c:27:13: warning: ‘cxl_is_memdev_memory_online’ defined but not used [-Wunused-function]
   27 | static bool cxl_is_memdev_memory_online(const struct cxl_memdev *cxlmd)


>  #ifdef CONFIG_CXL_EDAC_SCRUB

snip to end.


