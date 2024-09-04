Return-Path: <linux-edac+bounces-1805-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 824A696AF25
	for <lists+linux-edac@lfdr.de>; Wed,  4 Sep 2024 05:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B60D284891
	for <lists+linux-edac@lfdr.de>; Wed,  4 Sep 2024 03:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B6A3EA64;
	Wed,  4 Sep 2024 03:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wkh7vsAW"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4B14A15;
	Wed,  4 Sep 2024 03:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725420029; cv=fail; b=oJxcfyjxgXpIPC6561EsvnoRcVU9kiZWxkYygWX2rivjrQwrWelXrd1dGjPi8ABH/qm/+sbtzPCEmBfxlM3JONX/qH3/ay33QDjkE3pfSeaTSquL+dflUtXvtqwSfx4bGYsS/k3GOJGZhI1iNBXLYP98BGcF9Ev2AHS5WEij5K8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725420029; c=relaxed/simple;
	bh=Mw0RcTi0tDvjhK/rgPjPZYzU2wN5nvp/kUvNEblfyOM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kjLiwsSS2GwgVtSHtMkk5XIYHiE9FsVqr/+gDAxc2HDN5D1zhb9n+G5WXzBNKG+d+eABG+8p1Y5wJz0CfnZuP+wjSakZtwR9qhQxqteX86j6B3dPQtj3/PUnqBZ2g6JFXdYAwZQkOU9jWmHaTuFIAaBgtTMdUoVeLxpNBCRvSGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wkh7vsAW; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725420027; x=1756956027;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Mw0RcTi0tDvjhK/rgPjPZYzU2wN5nvp/kUvNEblfyOM=;
  b=Wkh7vsAWwNeKxdVVjQ6ModSLV4LyU7UoYIpi67tuW9JRf3m47h25B6EY
   Ha0bywPdN5GzkHdAvtbvu847jRDNoLtaCnJiPmNXkB8Uy53uwf4Kes4ty
   1a+Ubrj91q0OnC4/tRwGsWR2u+qq7L7BP25f3xjXZ0I82trlBDhhdCjw3
   8CmEL+kY9CZRSaTJmVqDjowUoAE06VbKqghAXI3w20m+Lk5p/MkKLHvtD
   LVUk0M901GGe9CEu9mQEGy2mXnCqyvu/vbV4xb+LPxIhMTyDR1y0n8v3T
   c9p8Jr/N6ojjM5yUNJn2KmgTPyUD2D043grRpd2n3SHc5KvdpWk1hiH6g
   A==;
X-CSE-ConnectionGUID: LJRykRZ2RLqOmB6CCY43kw==
X-CSE-MsgGUID: N7TPWSjZRvy61uFZjhKxyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="23564780"
X-IronPort-AV: E=Sophos;i="6.10,200,1719903600"; 
   d="scan'208";a="23564780"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 20:08:25 -0700
X-CSE-ConnectionGUID: bVq0aup4QhOmn+RV6q9Taw==
X-CSE-MsgGUID: VxEUEUAoR56bQa8rJwQBhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,200,1719903600"; 
   d="scan'208";a="69908445"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Sep 2024 20:08:25 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 3 Sep 2024 20:08:24 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 3 Sep 2024 20:08:24 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 3 Sep 2024 20:08:24 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 3 Sep 2024 20:08:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z3mVjtcOf8G7CuyZoxRoNgAsF/o/eF9NV7sOT21Mq2fZzG+GdwYlU46sF2zecQpjHNUCfLla3IJ5Xe31os/wC2IdCkfOt/3N86henzY9NH3B9/PNyY44MNeBR+Vm+X0rBZFBt76la8RRNkRoZgrVeleSIkdEY5oQh3ZtBsG+3gOUmoe0W2C/ZvF88hifWHqkXDbYgVG7dIfm5+zkzAVya3zZaD0wxXqyDQ2S6zY+WjLisHeFg9xiPILNqihHSXBNlxr2V2nl8tP42V4EPwM5ruGShjfCLpmTGDJx+drcl7/ALAYjf2Zi94a87IE4M9BHDJpUCz5nppxS04OmADn5CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mw0RcTi0tDvjhK/rgPjPZYzU2wN5nvp/kUvNEblfyOM=;
 b=ZprWokdF0Q1Xm92O+VxzIwKK2h6WTEHQdNrazHVeYbJHhZ5JQRKw4GuT+QRWSgL96ov3oPxaGxceDWMn6P1S5ksSxoUOugSI2gTO3x8bdFn4FyozMkGmHG1AD+qHnP6mgNGYOCTY67BkEG0h0OoW9pbGn9vZtzZTcrJ7FjH6Op9seHml28Fw8IGES68qkitPNdpP3iFshmJt+btNkZ2F49mWxzCP72h3Tu1yYy1a3wWwwWcNCQlDHnpIoWwDK/52/4i6BGp4L8ttXFuARiwsGAyVzb5aDfZxmmrEKUUJ5q9ZJZDBA20or225V9nHQkZB0W5nPQLaGTTfoeqsVaO/MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by SJ0PR11MB4800.namprd11.prod.outlook.com (2603:10b6:a03:2af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 03:08:21 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%5]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 03:08:21 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: "Luck, Tony" <tony.luck@intel.com>
CC: Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>, "Mauro
 Carvalho Chehab" <mchehab@kernel.org>, Robert Richter <rric@kernel.org>,
	"Zhang, Rui" <rui.zhang@intel.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] EDAC/sb_edac: Fix the compile warning of large frame
 size
Thread-Topic: [PATCH 1/1] EDAC/sb_edac: Fix the compile warning of large frame
 size
Thread-Index: AQHa+g5k+ltF+h8f6kGrhgX2P4B2arJGktsAgABmNJA=
Date: Wed, 4 Sep 2024 03:08:21 +0000
Message-ID: <CY8PR11MB7134663DC9105E0846C61888899C2@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20240829120903.84152-1-qiuxu.zhuo@intel.com>
 <SJ1PR11MB60838520BD3696B2A6C1792DFC932@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB60838520BD3696B2A6C1792DFC932@SJ1PR11MB6083.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|SJ0PR11MB4800:EE_
x-ms-office365-filtering-correlation-id: 5ebdbed7-190e-47eb-c4e5-08dccc8ed53d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bDRFM0VKYkZCTFZKVGFlRE9qVkNUaHY2cU9rNlhKWFpEYzBnNWFGK3VidGdS?=
 =?utf-8?B?eWY1UmJVMkJjYlNGdkg1VDNFNnVINm03N25mWUdIeWd0VFExUDZWUDg0N0No?=
 =?utf-8?B?WHU5Y0xiaFd3NnlDVU5lZC85eXlnSHVaTjk2U1lGeSsrQWVweDV3L0FGb2Vh?=
 =?utf-8?B?L05jSmx2bDhuL29xMXFsdHVLcGxwZU5vd0twTnhqOHBnOHNhWCtyWlI0dVJF?=
 =?utf-8?B?V1FrM200N3p0S0FJS2FVYmZxb3JUN0ZLWk1UdWVKVk9OUUQzdFcrVFpxWm1Q?=
 =?utf-8?B?SWNwNzdtMjBRZFhrc3hpamRIRkUrTGZrandIOVcyZDN3UEJBRktXYTh5U0Zn?=
 =?utf-8?B?RGR0YmR2bUpmaXhjdjNSTGQwdXBlQStvckVaSzFGUGhVK3BxSkk3a2VzRy9K?=
 =?utf-8?B?UjJ4TDlONzU2QW5UaFNoZXo1NlFpQmdsU1NnRlBscXlKb09KUG9LTjNaakov?=
 =?utf-8?B?TGppc2JuY3g0UDVHY2c0eGwxRTBkNjVVNVhMTVB2bXZ1ODVUc1NtNm91N3do?=
 =?utf-8?B?SUtwOEJvYldxb0tIZHNRZVNaK1FBRUZ6enNtdFRxd25QSmRYSFpHYnRMYTBq?=
 =?utf-8?B?cWpIb2JEVDg2WG1CaklhZVNmWnJycUl2SG45NTJYK3pqaGJ6ayt4MEpqZ0Ex?=
 =?utf-8?B?UkdUdU0yRm5hKzhlbU43ck9HVVFZcEIrU3haVlcrMnMvUmpNR2JvWWtPMmtF?=
 =?utf-8?B?c3l2S01BT0F1OVpMSE1sODJJVWJ4OXRDb0NlbU9pbmJXUEJvZGJKSFk1d0p0?=
 =?utf-8?B?cVlDOGlDQURKRkc3QnJQSDVyZW1YREprNjZMYnNJR09ZQTcxYzE1OW5CNmI4?=
 =?utf-8?B?cFh2NWtteGdKUG9vdGpQWkEyY2dVN0VMZDZFNk9jT3B3aXpaaHBScG44VUo2?=
 =?utf-8?B?WklNOG9nM2Nxb2MrRHdITXpGSnFuZWJlTm1lK1dkT2hoSWZETGhmM1Fqb3Vv?=
 =?utf-8?B?cTZGbGFBKzFQKzNsYjNGNStIQUp2NUpQUVh1dFZBc2VKanRJbjNhNlJTNzU1?=
 =?utf-8?B?dDN4QXJQQXZEa2JQTW9DL3lkSjV4QTByTWhNTHQydHRjZmRPN0lFVkJiQTgx?=
 =?utf-8?B?dDYxZ0NmVUxuVWxRVVZETFkrQ3FFb0wvQVFSRUExTkc1S1ZkemV2eCtPWVpP?=
 =?utf-8?B?OWhHUVMvajRNaGNaaHlycFArd2tLVUZZYmlpZWFJdUVhT0VlUDV5anpxaEtY?=
 =?utf-8?B?NkxDYnduMGN5R2pVa2l4a1h1L1lsTUJsZFZXbWpsY1kwRXV1OEprQWc3ZEtV?=
 =?utf-8?B?dmhPYzJ1WFJJa3I1Ynh3SjRLUDBmZXRqVytjMmw1MEFKcnVRbStCS0kvMFlp?=
 =?utf-8?B?WUNQaDdyUlVCQU8yT0UwT2x5STZ3VlhXanFlUFQ0Rk5UQnVHVm9zb0J4YVd3?=
 =?utf-8?B?UUV3T0tZM1VwSk5UeHozNEUyUzN4WnAraEVVY3ZGSFZwQzBoNWY3WWxUTmtN?=
 =?utf-8?B?emhHSnJCNVpscGk0UlpqWFMyOE1FU1ZDTEZBV3loTkFrL3pIb0ZmN0YyN1E0?=
 =?utf-8?B?Qld4NktYOCt5LzJwd0NhNDRMZ3pkTTJwVS9mTDVXSUZWc1dnM2JsT1pDR0tM?=
 =?utf-8?B?dlNldDBUcEFEWG5kUVQwcDNUVjhtaTgwS3FUVzFYU1lYVi9CVUdZbU5IanJi?=
 =?utf-8?B?SDZRQjNkVzZOM2tJZGhCQkJZakx4ZkR1cG9DS0lKSFpvWTlibjU5a1ZWN1dH?=
 =?utf-8?B?STdYamgvUFVmSEI4NGREUU12MDB0STFic2VMTmdTajIwa0Z3MWQ2NFh6azN6?=
 =?utf-8?B?ZWFqUG0xQUYwVHFmOFZoOWdyTHQwWHFtOXNYVTRqeEVTazVPa3dXR2dHT2h6?=
 =?utf-8?B?RFVQRDY4WXlTL1czbFJ2UTZXWXliUjMxWTh3bVFDM2xNVitFdlNWRDErZEZo?=
 =?utf-8?B?dVdmWU5oWlB1cTZKd1JNY2VFcm9RUGZadzhyTmlQcDB4SWc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmhxN2p5OE9MWlp1L0s3amNoMDBCbitJc2N2NGZRWTJXQ1F6SnFrUWpUZUlR?=
 =?utf-8?B?eXpqaXFyVWhRb0xtU1MzSEN4MHhndm5jUE5tVk1PQkR4cEFDNVhtOC9wOWxa?=
 =?utf-8?B?K1JGM0YyZzhxbk9jQW5qNmRCekMwUWdnNjk5cGpudTVvT25lM2k2cUhYYVlt?=
 =?utf-8?B?TlgvOWR5dUtVWmJaYS9wY3pLd0lFQzNOZmNSdDhIWkFORm9PK3haVUt2SEJz?=
 =?utf-8?B?OENORlBRUy81RDI5UVZtbGVHb1RYV1gxSmNtbnRQSWNjR1l2NmZ0YkZWU2Jk?=
 =?utf-8?B?cjZxb0gwbytPUGVXWEJZemVvOUxyMEg1NHN5S1JSblMzNmtDN2R6S0w1OEh1?=
 =?utf-8?B?d1IycEpZV3d5aE1BcnV6SStEaWZDWkNMSEs3VjFhNlVaYUVQYXNlV2R2aFdt?=
 =?utf-8?B?SFVFaFZKUS9lTXNIMEdDOFBKRlVTRDVNaDRnS21CVGxEY1dzZEwrVjVKY2ZP?=
 =?utf-8?B?YXZOZFlnTVBtUWZVZk80VzhpUk5OcCtVYzVJNC9YVFpWdXlpdzF1NXZ1ZUVj?=
 =?utf-8?B?TitBUnhIcUFremJhNnhTWXhGR3VwbnFlbmVWM3FML25nc3EwTFBpQ0JOMlUz?=
 =?utf-8?B?TS91KzRUOVMzT1dOSnlScDBhUnJZM2pYT2JCUm5CVXZiN0ZxUHBacXFPdnUz?=
 =?utf-8?B?eE05azRNTVdmbTk3SFZoTmNxcGVucnQzRDdRWTJvd0NLcFpjY2VhcmVJUGFY?=
 =?utf-8?B?TmJZTm9DOC9nTWh3RUxDcjhsVnRMVFlxdnA1WWd5WGJ4bEFzV1JFUEFOZ1Iz?=
 =?utf-8?B?UHRuUURDOVRnYysrY1pua1FsRUt5bG5rajRFUlpkY1pUSGlHM0tDVVhMcGJH?=
 =?utf-8?B?UmxsSW95RzBVZFBhWGZ2Z0VNRVBleGRqSFZzOW5kdWkvUnhmWVI0anNmekNS?=
 =?utf-8?B?N3A2cFlQMUJlVFBZZk9FbW80aGxTTDl2dlkvM1VOSWFXOE9QSmpaUVpML0lq?=
 =?utf-8?B?SDR3RWlBcE5OSEx1NXk5TnpmcUtnSzJZUEdDUUJtN0hoeGY3WFVyUzZNTlYw?=
 =?utf-8?B?M1M0dVJSYVJVWHdTMEk1MElYUUI0b0lqc0hmOE5BY1lwVm5QNjkzb1VmZzhQ?=
 =?utf-8?B?Lzlsemhxa2VSd09OczlYWTBIdGlaWUFqR0NqN1oxOUlaTFFMSWdnb3FRL1Vr?=
 =?utf-8?B?S2ppcEdJN09IK0tlRUJGL1k4dHg4TkxLZEcwZjJ0QUxpWUNvT05KNDFQSVhi?=
 =?utf-8?B?RWVUTzlaUGlOa3p5OU01Njd4N0Q5ZEl0M2d3eExwdGYzeHZMdURPdS9iMWhs?=
 =?utf-8?B?THhtaWpza2RBU2FhK2xyQjRMejhVK0tXSno3d1V5c3ZRTkpvZzJhTHJuMnNo?=
 =?utf-8?B?akZTZEkyUE5EZGFnTmVjZndzYlAxTXhNUmJyVHYya01raTcxd2FMSTJieGNl?=
 =?utf-8?B?UWFJYW45NkpzVy81WXU4N0tUb2U1SVFCanJHUDMzWWtDakQxeVhIbHpoU09S?=
 =?utf-8?B?cXlGVEd3WmUvNWdqMXMwVWJSRjFSZWJWMVcxQXNvNytqRTNCSWUrMm5jMHBD?=
 =?utf-8?B?Mk1wallYWSs5a3NXSEtnU3ZWZ05MeVB6ZzBLOE00RTU1U0RIdTY0T29DR2gv?=
 =?utf-8?B?cTBiQ1lGdDN5SXdnMTlJaDZNLzlKZ3k3VnZBUUxqT0taTnVUb1RPRG9NVDRa?=
 =?utf-8?B?RlM2Vm9sSmJyQnl1Q09BWE4yMEVUbm8rb1BlYU5DdFpMNDdudzJUeXl0VGRT?=
 =?utf-8?B?WHIxOFdBY0E5RlRsUWJ3NWp6S0VEMkQvUlltcEYyU3ZPS3RNNjBlMGRyK1dE?=
 =?utf-8?B?b3hRNnJuR3I4QUMxZmdNQkhtTHVpRVFuVUo0dDd5ZjBFejRSL1pYWUlsL3pP?=
 =?utf-8?B?S0dFL2M4UFdnUXNWUEo2ajV6d1plMTdWNnZzMkVJZnJ1RGtXckxTdGNnVUtm?=
 =?utf-8?B?RzFiT21TTlhmMkdoNkw3N0dKbnAvVTZBSFg0L2FiK05vS2cvRTFHOC93amRX?=
 =?utf-8?B?R1NTSzU1YzAxUGkxdVBZVFhFcjcyWmt6N3VpWWRVYnB5RnBreUZpbDBoNkE1?=
 =?utf-8?B?eU81bFBhcndDdWJhYzlIaEZQZVR3V1VnV0hMUHp5ZGN6OG9sVzlwQlEvbGlC?=
 =?utf-8?B?ejV2MzZ1bFJhS1RxeHFFWGdOc0xnRGVyR1hrV0t1aWlXOWZtbUZWa1drQTlE?=
 =?utf-8?Q?vZvND/ZLK7m44iF8Nu2XpCM4e?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ebdbed7-190e-47eb-c4e5-08dccc8ed53d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2024 03:08:21.4755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /RaqkVhLaXJegOBrUXRLnuSCitSRskNuKcDlYM/S89nU8YaqsylqOQKInIBIDHv0XcqY84kB8yezzE/NF63ohA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4800
X-OriginatorOrg: intel.com

PiBGcm9tOiBMdWNrLCBUb255IDx0b255Lmx1Y2tAaW50ZWwuY29tPg0KPiBbLi4uXQ0KPiA+IEFz
IHRoZXJlIGlzIG5vIGNvbmN1cnJlbnQgaW52b2NhdGlvbiBvZiBzYnJpZGdlX21jZV9vdXRwdXRf
ZXJyb3IoKSwNCj4gPiBmaXggdGhpcyB3YXJuaW5nIGJ5IG1vdmluZyB0aGUgbGFyZ2Utc2l6ZSB2
YXJpYWJsZXMgJ21zZycgYW5kICdtc2dfZnVsbCcNCj4gPiBmcm9tIHRoZSBzdGFjayB0byB0aGUg
cHJlLWFsbG9jYXRlZCBkYXRhIHNlZ21lbnQuDQo+ID4NCj4gPiBSZXBvcnRlZC1ieTogWmhhbmcg
UnVpIDxydWkuemhhbmdAaW50ZWwuY29tPg0KPiA+IFRlc3RlZC1ieTogWmhhbmcgUnVpIDxydWku
emhhbmdAaW50ZWwuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFFpdXh1IFpodW8gPHFpdXh1Lnpo
dW9AaW50ZWwuY29tPg0KPiANCj4gUWl1eHUsDQo+IA0KPiBBcHBsaWVkIHRoaXMgYW5kIHRocmVl
IG90aGVyIEVEQUMgZHJpdmVyIHBhdGNoZXMgcG9zdGVkIHdoaWxlIEkgd2FzIGF3YXkgdG8NCj4g
dGhlIFJBUyBlZGFjLWRyaXZlcnMgYnJhbmNoIGFuZCBtZXJnZWQgdGhhdCBpbnRvIGVkYWMtZm9y
LW5leHQNCg0KVGhhbmtzIFRvbnkgOi0pLg0KDQoNCg==

