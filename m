Return-Path: <linux-edac+bounces-2970-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B672DA2B999
	for <lists+linux-edac@lfdr.de>; Fri,  7 Feb 2025 04:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEF5E3A03E0
	for <lists+linux-edac@lfdr.de>; Fri,  7 Feb 2025 03:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9692315B99E;
	Fri,  7 Feb 2025 03:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VRLDkxpN"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79404EB51
	for <linux-edac@vger.kernel.org>; Fri,  7 Feb 2025 03:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738898374; cv=fail; b=DYglMFrIfWIxzVRMn277Y0Xh/U7D6uVEys0Xk5zakR/dZO2Ejv+tW+RXJFy4z7yExbOop+1mB0l0ZLhjK0p/XIQMcuVc7vrusQtiQUWKwlYl2VT28ifbz8j/cODBMjbGvvmd4yDPI6I/4YHlRg5+XZ+KJL+naBJLNQTdPKbyEsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738898374; c=relaxed/simple;
	bh=V0YcGaR6g2hc2VpMmIwaz+MZkK/Ma7QyZ0aQKgydd6M=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DepvZHB2ErJkx7AUldPcGggzlCoKCYrnBFRZeCe98X6bB25ZEwfjs0HcMqAkmO02RkjV86z/rhlV4ai6NputPs8jQUoeidpDOWvewydxeDx0g9/+UiidoBaoBitnIaGUY96g6Wyl+NSo4bind9gMLe77ppHwy9DDVImKI8Yuwo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VRLDkxpN; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738898373; x=1770434373;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=V0YcGaR6g2hc2VpMmIwaz+MZkK/Ma7QyZ0aQKgydd6M=;
  b=VRLDkxpNuHsMPiDSjAyCkef6397SkEsRqjSy/ktYZMeKk3KrtnT32DzS
   a7+s13N9a5I1wZaon0WRwO2Om5cwPnSFbJehtJAcuEnl3d9PxOQJnV06T
   2YHTCaTRiKVEuLzQRXZJ8mAYb2D936AG4XArHhzHNQZYHmKpy483Oi6xF
   sD+sq0L+C42FfVtBpZvcvKKVFb8TjSSliwcROmrPkbxFrYRaQad6IcvT4
   3lBuq+mr4EmaKaSJQelPkafzUEns0LWSoggjGmF/XekSMOpqYXNKB8I/K
   /r+bbdgo9ptglpVJKpgQ4loYd4i/7a/j2m2hG6GDPifl10p99dpx8I1rr
   A==;
X-CSE-ConnectionGUID: bxSti1jiQdC+OtHl7v2Adw==
X-CSE-MsgGUID: VgEmujYqTwmEps1vOeKqlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="50516051"
X-IronPort-AV: E=Sophos;i="6.13,266,1732608000"; 
   d="scan'208";a="50516051"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 19:19:26 -0800
X-CSE-ConnectionGUID: 4q4Yu8yoTkmP3xoKmbznhA==
X-CSE-MsgGUID: TcwOK3L5Qw+XvpXQMw9RLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,266,1732608000"; 
   d="scan'208";a="116438022"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Feb 2025 19:19:11 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 6 Feb 2025 19:19:10 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 6 Feb 2025 19:19:10 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 6 Feb 2025 19:19:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FRNIf35erODCs3vVZNTX6UvMXhsPRWaBz+/chuf1bshqW2joMFk1GaMP6vAjHJwpzSMWxw7/pImhjf74CcAxkGPwvH0KnZWmgnaVoa5PauCpa19vZF+xlgSWeE6lkCH3ke/T06prGyMSFOPopEFpHGrgMhbOumUSgQOpj2i4Gm82qKmxjcYwN3GMzypccv2/1ycdf3C9AB6Snp8GREuytIbzu33ngsLSnJe0Vwc6nA5tmZhPcrQmNaT10KIPCHsVY2ACfZYEiplOlro90xqez/gjTFJwu3kyt/uHsDl9VLnLXJ6/uCCSpJ6tFevadSeBg6MEMzLxm5I9PRrCjHP4Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V0YcGaR6g2hc2VpMmIwaz+MZkK/Ma7QyZ0aQKgydd6M=;
 b=cQHZ4WfHsB1UyPIeFQcUukRf/MICw1GHHCv92FCAtamMCM27Wz2xKGNF8d1p+1vmM0l5LXM/OunvX+f2EKfhgfOID99OKTheeww+CjLg4YYxMkKf6o+pav8bTMkUY0lX5+hV5oVEq/5Hnnt5aHY6CmofqC/F30fFYt4Y9CkakOzrhadU6SOZhO2gXwplMALOzRwD02iBxPC6NOKJzUpJI0q+IqkzJllHFVcDP0kgcLhBDiO0kKQZ4cDN6v6h2kxivtpsbQtBe84bsgPvCvj0T3ukvnBRgqnknSuQgXvlrFvcR9TZlzjbfkjFzIWhmIwqDXsOffswznZshnuD3Km10g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by PH7PR11MB5916.namprd11.prod.outlook.com (2603:10b6:510:13d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Fri, 7 Feb
 2025 03:18:54 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%4]) with mapi id 15.20.8398.025; Fri, 7 Feb 2025
 03:18:54 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Ramses <ramses@well-founded.dev>, Linux Edac <linux-edac@vger.kernel.org>
Subject: RE: Flood of edac-related errors since 6.13
Thread-Topic: Flood of edac-related errors since 6.13
Thread-Index: AQHbeOe8nlKhFFXJVUyTVIAGkw2yWrM7Kj3Q
Date: Fri, 7 Feb 2025 03:18:53 +0000
Message-ID: <CY8PR11MB7134594FDBF7AED80E415AEC89F12@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <OISL8Rv--F-9@well-founded.dev>
In-Reply-To: <OISL8Rv--F-9@well-founded.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|PH7PR11MB5916:EE_
x-ms-office365-filtering-correlation-id: 97269e04-c8ef-4d74-f414-08dd472626b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SzMvemMvTmdnaFl2YjE2UTZFVjQ5Sld3RDg5OVh6TW8wYzlienRUd2s1QUU2?=
 =?utf-8?B?NThpUUpqVHJHWEZpRUtEQVdQQVZPaENodkxnK0FIL3dmYTJXU0ZXL2pKVWZG?=
 =?utf-8?B?TWk2N1hTVDJTa3FtU2NrWnV5MDJxUUh3WGVRd1h1bjFLRzQwQ1ZwUkpNbVgy?=
 =?utf-8?B?dFRWSm9TNVU5a3pyd3RiZ25GNE9ZeFpSVndLOEFvbE04bFdkcXFXNHEvNnNU?=
 =?utf-8?B?WXFIdmdYRDBYclFRWmFlRGFXOUc5TEU3UUl2U003RGJUcjUzUGdsdEpzc0ox?=
 =?utf-8?B?STZPWU1PQjA1VWVlWmNLR0o3U3NTSHpEeFR4a3JzYTl4RzhJVit0TEVNVmRk?=
 =?utf-8?B?amplamIrMlJYemFIUEF4cWdKUHhmNmk4czN6eStPUHpwRVIwakhqQmVVN2dk?=
 =?utf-8?B?Q0FyQ2hjSDBsOUwybEwzSHY1OW4vL1lMcnAvN1cwT0tyOE1hcXNkczd4UEc4?=
 =?utf-8?B?NHkzbVJELzUxeDFlVzB6MDlsSGpQMVN5N21ueWJSMmE5V1UxbCtiKy9sakRh?=
 =?utf-8?B?b242YzhJaTk2dXQ0MlBwUDFiRmw5MlI4OEU5T0MvU3ZiT1RxSCtmaHdYNmxX?=
 =?utf-8?B?Z2JLVTY1WmFYUEJpYlp3QmpSR2pUT0srNkU5Yzl3UUErOGY3SVVhQ2F2Nlda?=
 =?utf-8?B?dy9qbHNycmFuV0R3NHMzRHY1RGp0aDR1UmQraDBoM1A0SGM2aWxKMkpBdGhM?=
 =?utf-8?B?encydXFvRHZrMHhaZ1YvZjM4bnh2cW5rSXVjVjJUdkxZZDI3QTNYTnFNSjIw?=
 =?utf-8?B?UVVSSTdxS2JOQ1ByeVEwY2dGdEZNa1hYWHdKS0FhRGZMYTFzSy9XNDdYcVBn?=
 =?utf-8?B?NENXVnZ2Zi93YnpUTVV5NkVYVVR6czdzcm5rVkNCc2k5R0xxU3ZKSXB0Tys1?=
 =?utf-8?B?WEFQZU84bjhjOXRrVlNERmp5TTIxSnNqQXk0SzR5QXp0R1E1M2lBQmJSdCs0?=
 =?utf-8?B?Yjg0V2NiSW92bUFJbWhnVklhejFJbmlEaC9LdWozcGIxN1VnUnNFRzRHeWEw?=
 =?utf-8?B?aDhMUEYyeE92RXo3VmFidGgwbWgrMmM0OTYzVjVlT1YrQUJ3SzNLaHcvQ2hx?=
 =?utf-8?B?bEhDUzBGaXN5V1FCdkM5SHFPeWNZY3VMN3dzbzdQWkZKTzJIVy9ldlRVMTVv?=
 =?utf-8?B?SW9VYW1ibVQ5dGwwNkk4UWhZTzVNN2ZaVVAxRFloU3FYeVYzMXZpREJhR2tC?=
 =?utf-8?B?b0FQQmVRS0dLSEFMYTZFaEpPMW1xblNQK3BQVkFhbnFJd0xaVG5KSFR4YWhM?=
 =?utf-8?B?eUlVTm9Tb09JOTUwWFpJaldyaVpEbEZuQ3gxVmcrTjdtcXVRU0ZOenVJSzlM?=
 =?utf-8?B?TmxHRThqemU5SVRDMWx3ZXdVN1hxTTMrT21aalhsdjQybVZyWjIwNVg2QzVt?=
 =?utf-8?B?UnhMOFg2bkdNSjFpVlVoVU9UblpsQTE5eHZheEViRUlXUDFDMFNvQytpYnNq?=
 =?utf-8?B?VkowMHlEamhnc1JuVHBjQVJmemErQ1EyVEJSUFJIVm8zbTZ2c0pUQUM2WnhB?=
 =?utf-8?B?a0lOM1VkTTNXaTRyanZVZUxzdGpHODBrYldGcEt4c29WYUlSTUVybWZ5Mk9K?=
 =?utf-8?B?a2tFY1VQTnFydUdpTHNiYjVJdlNuL3hROWFLTnZDRkVrdURWOHQ2aFU1dlVG?=
 =?utf-8?B?MUFVOXdPMm5kRUhreHBSdVQvY1R1S1RvUG8xQUQrNzJGU0ZPVStBcnNyZC8r?=
 =?utf-8?B?alc0dnZsSlVDd1MrVkJ5UnZDcmMyMnRNM3VMamFTUEE3OEp0dXF0SFpkeWZ0?=
 =?utf-8?B?YzBlSlBCMTRIOHlVQTd1RUppVkZBdWJCVERPelMxVXFQQjJub1lmL1REZ2cz?=
 =?utf-8?B?bjEzOXRzNVpkeXRZTU1Bbzc0TDZrZmYrYWZJKzNjMllhZ2UyU3lBblgvbm8y?=
 =?utf-8?B?YnAzY0F6clFEMksrK1VUd3ZUTEtPaGpFRnhHbUdwTExldVF1MGZxL3haTFBS?=
 =?utf-8?Q?220U0PUxCBXB8CXSQWu6xbYGxMUO3IW5?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eGhxTjVxa29aU1dFVjlkZU5laVRqY09HcGNrak5QQ3VXUUM4UFdCUzF0RWJW?=
 =?utf-8?B?YWJrbXVaSUU1Z2k1S01ScmtGRkhHZUtQOEJIKyt6ZGFHd256ZlY3aU1DbGp1?=
 =?utf-8?B?ZUpMSzRvK0d6U0NtTnlLSzFzSVRsSVBORGt5RS9YSTROb2FLT0tPeWs1Snps?=
 =?utf-8?B?N1lzU09SOUZRSlpaUFRVdFdNTHdSaDVFbW0zQjdRcWpDekVGWEFpcUdsdDYy?=
 =?utf-8?B?NUJlcyt4VUI1VmdlSWk0dUVwOGFKRTA4STJsQW9hcXlPQzlrYXNXand5YjJk?=
 =?utf-8?B?VEpPbU1YcVlDYnFqR1BPK1Y4dnRXK2cxTHpOQklyTlBZc08vZVhXbm5nRkhF?=
 =?utf-8?B?SWk4ci9pRGNPS245bmxHSGNkL1JYNFYreUR5VmFmUXM5SnFGL2RrTmxzVklx?=
 =?utf-8?B?ZmE5V3hXaG83ZWh4RkMzWnAxeStpbDduSHBWMlR4S21abGpua25vVFlTc1lq?=
 =?utf-8?B?c3cvUnNTSkI4QVZ6Nytvd01tN2N3UmFHN3g5WXNzQTJOMDg4NytQRm5VblZq?=
 =?utf-8?B?TjVLUnVrZ0hJTkE2UytESjVQTVNBTkFNN21YeDVXT0t6M2FaSkJSZ2dONkRJ?=
 =?utf-8?B?OC9NSDhxbFI0UnVFQjJyU3plcGx1R291V1M0WEloWTdFalpqblkwWmN0bm5I?=
 =?utf-8?B?dW92ayttQW51aWErc3FlTFg2a1NKajlJdUpoT3dudWJjdHNhTnRScE5aWDFG?=
 =?utf-8?B?cUdoRFB2U0s5K0JCbHJJOFhIYi9EbUhBanNnT290TWZzWFZqOXBYZ0pydkFn?=
 =?utf-8?B?dm1udGR3RW1BdzlxMy91VkhvYWR5SVlRc2dnMnVabFdJbXo5VEk4YWFRQjdx?=
 =?utf-8?B?YnFuMUNQSm5OZVpsTUpYeGg0WUd1V1hORXBmM0hrM1c2UTRqUGlublBibEtU?=
 =?utf-8?B?alJiNXRNcGZWL3VCWlRrNFNqUjQ4N2R3UTN1aUJZMndZMnhuRE1PMHdHZmsv?=
 =?utf-8?B?d3NycUJJb2xkNWFvVEpLalArWHRWRE5WWjBDdnJlYWo1WU45aVU3Z2VBQUo2?=
 =?utf-8?B?N2dsT2tuOTVTaUhjRmh1OEx3OFVzbHA0bWNSWmlSLzYxbHc0UVZiVjB6Q1dU?=
 =?utf-8?B?dlBnKzhCd3N1R25wOTBGVHhjTUNTZzZydUtsYzlrc091cVFCUllaOTRnMGh2?=
 =?utf-8?B?cjdsNVU2TFM4cVplbXNUSkJIMVNLcXZCeFdPbTlBem14Q09CV0ViQnRNMjZB?=
 =?utf-8?B?alRFVHVzSjlwM0s4Z21WQnJ4QitzRlpNUlVNbmp0TURkZ1B1ZU45VGdpajRK?=
 =?utf-8?B?TnBuRGZiQy8rRTdLY3ZDTnVLQTJCNTlzSEVoNmdrNzZxUmtLWC9kcGMrSDVm?=
 =?utf-8?B?dXZZK3dkYWpUeVFGYVo0REdFdzJGc0E1c2JKcjcrTmRpRy91RWE5MUNGUTdj?=
 =?utf-8?B?N2dXYm5UUi92cjFhUWVFRk5BeWRwYWdvb0pXbm1LbExTQkc0YVczMGJjT0hv?=
 =?utf-8?B?QVlPcEpiNElqL0xsVjRQOE5obVlwblA1UlRnclRtMzd5dDdzY2tDY2txQm5F?=
 =?utf-8?B?cDEyM28zWGVnTFVPeGlPMzlTaWNQVDBHMjRXTGExdG5LMUtNMSt3ekl0amtu?=
 =?utf-8?B?czczU3pteEs5L1VFcWdtNkxMREZnNnhQaWFLSVRqRU1LcXJ4aXNibXFDOTRa?=
 =?utf-8?B?NXREejNjeDZadVhEZXRDcE82M01TeVRmUzY2UERYMysyYStVTWhOaDRkWkdP?=
 =?utf-8?B?ZnltMXhyV3psOWpOYjNjVHRHMlRrNHVvZkVzM3NWaVhqcmM5dHZ2YXZXbVd5?=
 =?utf-8?B?Mk9ncW1LVnd6TEZnK1FXOUh2YjgvUVhJUW1OWlJJV2FmMUw3S2o5N3cyeU1Q?=
 =?utf-8?B?eHZOWm5oMmlmeFlZUC9rZEVYSk5JUXoxbUtpWm9neXhUWTRrSWtSemtWR3M2?=
 =?utf-8?B?cTdadG90dEZRYVgvNUVrM1RDSWFPMi94SkcvSnhqcy8yanM1Ymx5dGlCaTNi?=
 =?utf-8?B?cU0xZG1vd1EzcUtka2Z6K0UzYTFNbjh4b0VwRXVEK0dwV25LRVZUU0x3bmhZ?=
 =?utf-8?B?dWVyVGI5WnlDeTFwcy9lMXpoMURHZjFiTzZza3ZSYnljS1ErajhvYUp0MytX?=
 =?utf-8?B?aUJQTWdEMTZyV1lUY2lmNUNKZmt4dW5CMEVqZVgvNEt3bnd3b1VFbldDc2Rp?=
 =?utf-8?Q?AKeFv1SwgIA1ikIejAKmDNowN?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 97269e04-c8ef-4d74-f414-08dd472626b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2025 03:18:53.9741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z+uT81S0nb7BkR/0Rof2qOrfLp1Fl0sTS9+wXDs+l8dettRM3K8ABbyWVyIo6RUntflaJKuF00z0TXUoUwNh0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5916
X-OriginatorOrg: intel.com

VGhhbmtzIGZvciB0aGUgcmVwb3J0Lg0KDQo+IEZyb206IFJhbXNlcyA8cmFtc2VzQHdlbGwtZm91
bmRlZC5kZXY+DQo+IFNlbnQ6IEZyaWRheSwgRmVicnVhcnkgNywgMjAyNSA2OjI5IEFNDQo+IFRv
OiBMaW51eCBFZGFjIDxsaW51eC1lZGFjQHZnZXIua2VybmVsLm9yZz4NCj4gU3ViamVjdDogRmxv
b2Qgb2YgZWRhYy1yZWxhdGVkIGVycm9ycyBzaW5jZSA2LjEzDQo+IA0KPiBIaQ0KPiANCj4gU2lu
Y2UgNi4xMywgSSBnZXQgYSBmbG9vZCBvZiB0aGUgZm9sbG93aW5nIG1lc3NhZ2VzIGluIHRoZSBs
b2dzIG9mIG15IGludGVsIG4xMDANCj4gbWFjaGluZSwgYWx3YXlzIHdpdGggdGhlIGV4YWN0IHNh
bWUgbWVtb3J5IGFkZHJlc3M6DQo+IA0KPiBqYW4gMjAgMTI6NDA6NTcgYmVlbGluayBrZXJuZWw6
IEVEQUMgTUM6IFZlcjogMy4wLjAgamFuIDIwIDEyOjQwOjU3IGJlZWxpbmsNCj4ga2VybmVsOiBj
YWxsZXIgaWdlbjZfcHJvYmUrMHgxYjIvMHg4M2IgW2lnZW42X2VkYWNdIG1hcHBpbmcgbXVsdGlw
bGUgQkFScw0KPiBqYW4gMjAgMTI6NDA6NTcgYmVlbGluayBrZXJuZWw6IEVEQUMgTUMwOiBHaXZp
bmcgb3V0IGRldmljZSB0byBtb2R1bGUNCj4gaWdlbjZfZWRhYyBjb250cm9sbGVyIEludGVsX2Ns
aWVudF9Tb0MgTUMjMDogREVWIDAwMDA6MDA6MDAuMCAoUE9MTEVEKSBqYW4NCj4gMjAgMTI6NDA6
NTcgYmVlbGluayBrZXJuZWw6IEVEQUMgaWdlbjYgTUMwOiBIQU5ETElORyBJQkVDQyBNRU1PUlkN
Cj4gRVJST1IgamFuIDIwIDEyOjQwOjU3IGJlZWxpbmsga2VybmVsOiBFREFDIGlnZW42IE1DMDog
QUREUiAweDdmZmZmZmZmZTAgamFuDQo+IFsuLi5dDQo+IEkgYXNzdW1lIHRoaXMgY2hhbmdlIGlz
IGJlY2F1c2Ugb2YNCj4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5l
bC9naXQvc3RhYmxlL2xpbnV4LmdpdC9jb21taXQvP2g9djYNCj4gLjEzLjEmaWQ9ZTE0MjMyYWZh
OTQ0NDVlMDNmYzNhMDI5MWIwN2E2OGYzNDA4YzEyMA0KPiANCj4gVGhlIHN5c3RlbSB3b3JrcyBw
ZXJmZWN0bHkgZmluZSBvdGhlcndpc2UgYW5kIEkndmUgaGFkIHRoZSBtZXNzYWdlIGF0IGJvb3QN
Cj4gZm9yIGFzIGxvbmcgYXMgdGhlIGxvZ3MgZ28gYmFjayAodW50aWwgbWlkIG9jdG9iZXIgMjAy
NCkuIEkgZGlkbid0IGFjdHVhbGx5IG5vdGljZQ0KPiBpdCBiZWZvcmUsIHNvIEknbSBvbmx5IGtu
b3cgcXVlc3Rpb25pbmcgd2hhdCdzIGl0cyBzaWduaWZpY2FuY2UuDQo+IA0KPiBJcyB0aGVyZSBh
IHBvc3NpYmlsaXR5IHRoYXQgdGhpcyBpcyBhIGZhbHNlIHBvc2l0aXZlLCBvciBpcyB0aGlzIGRl
ZmluaXRlbHkgYW4NCj4gaW5kaWNhdGlvbiB0aGF0IHNvbWV0aGluZyBpcyB3cm9uZyB3aXRoIHRo
ZSBzeXN0ZW0ncyBtZW1vcnkgYW5kIEkgc2hvdWxkDQo+IHJlcGxhY2UgdGhlIERJTU0/DQoNCkl0
IHNlZW1lZCBsaWtlIGl0IHdhcyBhIGZhbHNlIHBvc2l0aXZlLg0KSSBndWVzcyB0aGUgcmVhZG91
dCBFQ0MgbG9nIHdhcyAweGZmZmZmZmZmZmZmZmZmZmYuIERvIHlvdSBoYXZlIHRoZSBvcHBvcnR1
bml0eSB0byBidWlsZA0KdGhlIGtlcm5lbCB3aXRoIHRoZSAnQ09ORklHX0VEQUNfREVCVUc9eScg
b3B0aW9uIGVuYWJsZWQgYW5kIHRoZW4gaGVscCB0byB0YWtlDQp0aGUgbG9nPyANCg0KVGhhbmtz
DQoNCi1RaXV4dQ0K

