Return-Path: <linux-edac+bounces-3124-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE19A3954E
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 09:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34CBC189A82C
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 08:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9096722CBD0;
	Tue, 18 Feb 2025 08:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S2sRffcF"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA0E22B8AC;
	Tue, 18 Feb 2025 08:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739867011; cv=fail; b=PFaJ5pNlrZxGOCjO2Kl3pDLFCEjpIVMTV7TPIYmJOSiPaPc8haTLZtNDj7Kz0CcGLMmc5HZcPYCImES4JL5YAAS7yC7Q5SrAw6J5WVxQ6A8uUZs7jV/cBqBZiZqyBWSlGHAbhVDi9Uo3dXN+YTAHAsALaGxR1pN2H1xjLmUIGX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739867011; c=relaxed/simple;
	bh=QVlFQMx8KwMV0T9XQe/KF5rXQWnZgephaNdpUx9sMdE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g/U3/x/Pp9q8nYmNIT8MAmC9MXfWoBbgJKkMIhPDSJozouTRWzCruNXwlsxA9NiPoyqoNQ6Y7JxNljCiB6KzdKWd9q1mLOOf6aY/1+IUsFl+VBKAIDvXox8d0KPOZPwK/F2TdH/oa+Sy8nhanlVG6VV+FFBWR9upGR7NTrumdlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S2sRffcF; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739867010; x=1771403010;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QVlFQMx8KwMV0T9XQe/KF5rXQWnZgephaNdpUx9sMdE=;
  b=S2sRffcF24/hNyzCGX08+L3HGloX8bP44q9WIJAzDqEsM4DmoXkQg1s2
   YgXlnfC/jRkM9hRAGlTgPo3KpaT7XaRFNCPCH/YnaM1rsU7re29WRBmgV
   YSS+EKN4HDOvyc4A6qx3rtCZAT6oS2FsZC470zioROBz/OIOO5AWcyvod
   plZjBxS50xk7RWIgYpW9d7Y2kh6OtkGduSoUc3Qrc9j7aXyy+qSVhDfhX
   ckjq8vz3PdVht1e6cy9ZjKiKF7inkRrwl0BkMfTn27vQaNyMRzDGg6wu7
   D+EHnGgsWJJgUobcdWozSUXVBj6alEZ1GpW/TCW43Z0qGWZJhdYqeARvB
   w==;
X-CSE-ConnectionGUID: zbfxQIIaQredx78Gtpk1gQ==
X-CSE-MsgGUID: Si0HVduQQNi4Pf8Ry2oH/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="40256470"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="40256470"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 00:23:28 -0800
X-CSE-ConnectionGUID: OJPEvmK2SB29snJCMVK6rg==
X-CSE-MsgGUID: 2/OmFfV5T3uo6S+rxJgaGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="114070325"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 00:23:27 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 18 Feb 2025 00:23:26 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Feb 2025 00:23:26 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Feb 2025 00:23:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xBqulledUq9QaBe2PwblgL9ziIGhbENWqaD2gVB4U/rgvTBrtxVYJ7s6bTrkStE8pF+PmWfTNA09oHW/kt9696Kmg7KWkddgxyYkglZw7n6fcDmlThYURch3Yf5SO8eNRLLQbz+Y1l3w6qDVyFj4Da3g+ZztA2vLNUvntRNLa1dB9M1/lV/cBpnNJ2teDaRuOR9pmd5PTb/Oxp69+3ut8dFTGPXnt23cBqbWULRLOj+/gPzKxYn+29h6gvu5J2oRwtnehl8K+4atP0BKSZuns14gH/bvlyiBH+/EeqgNO5nbUp0P33vT2SIi0aJj6i23Rl8X4s8Q/bqjEWAuOQpjfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QVlFQMx8KwMV0T9XQe/KF5rXQWnZgephaNdpUx9sMdE=;
 b=vWMy+kIMR8ukYh4tbWYJKiCfIE/GwyAQLRnS+IkCAwOcoAPD2c4uq2ToOYqzcXxJa+I/3wWWqs9dhCz9z+CYyApp9Jga1wc51CFF7r9cR77bmQbdvMB5K3aH+X9tfXC+rahNN/RczwqpTwuXArISpcBVTbZgDnM3YhLpmDkxXsSdWYbSvVC71SdNXpOCaBMXNxlsKPXcKbZmt7I615iCFXDMnaXBXbGawffMTgBnyPOZl7i+lav6F29JtAmCWMMNyMc5/X0+E4+eQW1QX+Iyd+bYzgXYz0ReTy+p8i8GAk9u2EHcZAvDiizR/ubH2yQ6vtyZoG2NSf1Ij+LOE/UVdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by SN7PR11MB8025.namprd11.prod.outlook.com (2603:10b6:806:2dc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 08:23:22 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%4]) with mapi id 15.20.8422.012; Tue, 18 Feb 2025
 08:23:22 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>, "x86@kernel.org" <x86@kernel.org>,
	"Luck, Tony" <tony.luck@intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"Smita.KoralahalliChannabasappa@amd.com"
	<Smita.KoralahalliChannabasappa@amd.com>
Subject: RE: [PATCH v2 14/16] x86/mce/amd: Enable interrupt vectors once
 per-CPU on SMCA systems
Thread-Topic: [PATCH v2 14/16] x86/mce/amd: Enable interrupt vectors once
 per-CPU on SMCA systems
Thread-Index: AQHbfjnDAo84fxtR2Em9QfhGgPHSG7NMupkQ
Date: Tue, 18 Feb 2025 08:23:22 +0000
Message-ID: <CY8PR11MB713437893EB56A76A5685A6489FA2@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20250213-wip-mca-updates-v2-0-3636547fe05f@amd.com>
 <20250213-wip-mca-updates-v2-14-3636547fe05f@amd.com>
In-Reply-To: <20250213-wip-mca-updates-v2-14-3636547fe05f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|SN7PR11MB8025:EE_
x-ms-office365-filtering-correlation-id: 3318ce7e-83f2-44e0-b34c-08dd4ff58204
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?V1lUU3ZPMlFiWkNMbXI4M1VVN0IyQmkvWTF6a0JPNU84OGppSGtaWVlUcHpY?=
 =?utf-8?B?ZTN0akoyR3VwY2MrcWJZS0FZM3Z5TXF3M0djazNOMWphN2h5ZHFTNGp6WFZy?=
 =?utf-8?B?L1ZnTDU2SjZmaHFZQXNCeTkvNlFHS25tQ2dyUWpVbituY3I4QnRrNGNNT0M2?=
 =?utf-8?B?S0ZtUjZNZWRBUnNXRGV6YXhReS9uUW11eHVIQTNGd1pSNnpFYnhJNlIrdWxL?=
 =?utf-8?B?OGJKVU5aMWo0aUZ2T0VwTGRIa0hxZ0MrR280RGI4cHhob2ZUREZyMkl0cVdk?=
 =?utf-8?B?UzhMWHNVS1B6WUlQMVNiSEdhdWpKSlA2QTNyRmJjSklIRS9WcTJjTHdEQjFW?=
 =?utf-8?B?czNTdjhTckVId0hDNk9FMS9jQVkzOWdSV1pVQ0FscFdjUmMzK0JEYytrVlJj?=
 =?utf-8?B?ek1aVmhhdCtzcmEvaWFOd0cxVmVHUCs0UmErbzZVck1nMFBlcEJFRnA3U2tz?=
 =?utf-8?B?VVZWMHcveTJYUXkyNllaZ1huMTNvbmVUMCtQSTM2YktLdURPV0xpQTBNOERh?=
 =?utf-8?B?R1dTcm52dnlzR2JrS3JCeDRZWTR6c0Y0T1hZRGgwNzFlYU1IYUhRaDhMaUE5?=
 =?utf-8?B?WkNlclVmSndHYW56ZVRXbWF2UnMxQ3Nmc0ZTd2tEZzRNSGpQUEcyV1FVNHFX?=
 =?utf-8?B?dFEwMUh6VG9ZQ09XWGFaZFJNcWl3L1RYdmdqdEdVOVArZVZrUWlVOUZReEt1?=
 =?utf-8?B?WWpkUUtraStUZ1JkY3hBc2pLODJjcmc2UlFFOHZ6VE52SWZDL2Z4RFVxTThs?=
 =?utf-8?B?STdVSmlRSytCR054Mno5NHBMazNWMGE1UG9sVTZVR1BPbmd1WCtYWDArSWFV?=
 =?utf-8?B?T1dScUZNY2RHa1VZWlEzUnkzbTJNRmhsMW12dDdncTlFMEw5eXFMZE9pV3ox?=
 =?utf-8?B?c0NaMjNJcmlMNElpWUI1VktPZmdvNjIwT1JyQ1hLWEF4Q1RlUkszT1U5VFZX?=
 =?utf-8?B?ZTl1TGIxSG1OTGdnL1lkZk5UZHFUSzJuRWVOMmltY2ZRNE5zK0JYSWxrMDZy?=
 =?utf-8?B?MEtIZktra2ZzcnV6YWpCY1ZncWpWak9jSTB2RTlIZ2hzUmxVMzVYaEpGbElJ?=
 =?utf-8?B?aDlGRVIreGtDaDlaQUFuZVRYQlZHZE9SRDRUR0txQkJYbjhQSG5ZaTFSMkU1?=
 =?utf-8?B?MFFXM1loUEw1bGlqNTM0YVlKOFhTTy9Eb01nWmo5V08rYnJUcDJqejhvb1pU?=
 =?utf-8?B?TXl6RmhuQ3FHbW1tWDUyVU1rZ1Q2a25iMm9PeTRTSU9iZHZKZklkaTRTdWda?=
 =?utf-8?B?Y1RuMk1kNGJuWjdwMjJVU3puTTRkYWtVZWd1VTZ3clJSZHdoUXNzcGF6K0Ra?=
 =?utf-8?B?blBkNEdqL1orRmVtaGc4OHlBZXg2N05xcEV2TnZLSTl2ejUxQWpkWWR0SEp4?=
 =?utf-8?B?c0xhbkRrUFJwMnYvOG8vcytldS85Z3NIak5hZ0pCRVJrckFhckF4ZDlaL21a?=
 =?utf-8?B?SUdhSjhqNGNEa2k0QmN5ZW5JUjVKVFk5YnFzbXpkOUxzc1Zhd3BZblFxZjFy?=
 =?utf-8?B?TmFIanE3RkgrMm5jdmMrRSs3UzBNNGY0TG55OWJvTnFMd3NDMXV5S0UvRWMy?=
 =?utf-8?B?T0pyWDZGRVBqbDY1ZDhFUnR3SXlYd3U4OC9HN1RrSFUxempTcWhhZnlUSU8w?=
 =?utf-8?B?TjdRbTlTN1duUTk0VzR6TSsrM1pvNzc4a3RXNGdzT3lSUTU5Vk9mUmluejhZ?=
 =?utf-8?B?dmhiN3A4T3BvUVFPc2pnS0FzcDhBb1Vta3czWE1QY00wQUhYbk9zb25nY3lr?=
 =?utf-8?B?VDEvS3FYNFJ4eURiMG5Fb3hEZGpOVG9YL1NiSXFqTDUvdzUxaWRZVnVyeVBH?=
 =?utf-8?B?bkNyRVg1NitselRmRFV5NDF4a2hPZWQydnJWWGhaTFNtZnJ2aVZnOTRwR3lD?=
 =?utf-8?B?L0FWSm1HZEcwMFd6aHJGMzRwRXZxaTZpL2Y4cUtPYm04MjBnZndIUDFXNEJI?=
 =?utf-8?Q?FrBgsOwCVtBrudz9OU76ukQS0BYij6QB?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bDBOQmNQVmVtN1A2SGtCSndnMEY0b2tOZ3FtK3F2Vkxla0ZyR2pZd3FQOG11?=
 =?utf-8?B?ZllIQjdiWi9pVXM4MzlqRzUxdE1BSXN1emg2d0wydmpXajlMWlllb0ZDMlNj?=
 =?utf-8?B?TGQ1KzZPZzh0ZW1ZS2xwVmtVMXFVc0JEYXpYOFdXQ2FkaEJrRUxnTWlheXd2?=
 =?utf-8?B?TjVERkZOOGFwYlhYNE05aW1lL29mR1NYbXZMR0RUVGgyZDAraGNHZDdFb2Ny?=
 =?utf-8?B?cGJUeTRFL2p4M2RVK21UMnlJYk56blNVUWFMTGZjT3ViLzloWE5ISk1ScTBL?=
 =?utf-8?B?clc2Z2lvNjY0TnFxZW0wYTBwOEhJbzBadml2WUZZditDcFphZ0JkTEJ6MDR1?=
 =?utf-8?B?VHVIUUdWK0czZWp5VGpEaWlJbmwxbFJRMXMxY1VNMCt1aTE5L3VBT245alI3?=
 =?utf-8?B?a2JkaDVBMHd5VTFRMU53UXZSc05ud3VheHFsa2p2UTlMQTVLMHZsdmZiZWZI?=
 =?utf-8?B?aFFSMlgvTXRVWCt2dzUvUDFTTEpvZjNDb08yMEdoMmk4TkZGckFpcVdUclhE?=
 =?utf-8?B?RzFaelhzMDlKSUJnQ3F5UEM3UldiYnEvYTFuWEluMldvWERvWWJLMWoralZN?=
 =?utf-8?B?enc0bjB0U2d4K080b1dGTGNka0xpYWhGazc5QkI3M0t1MUtuMWpsaUVjaklJ?=
 =?utf-8?B?bFVvQVFxVWh3UTJFWDMyeWQ5bEFsdzgzNWNIemEvcmRnOHo2Qmtob0Zua0FT?=
 =?utf-8?B?eG45ZUt6TktXcVh5WVFlNzhpRS9JaENlYlNXYVJJa2xJUzh3eUhYejREaEhN?=
 =?utf-8?B?WDdyOVhMTzB5WS9QSGFlejl6QUtONlNackt5QlNEeU53d255enRKdVB0N1A4?=
 =?utf-8?B?UEpYT0FlNy82WklSK1lCQVg5SkYxV1hyWk5jT3hqVEpiMkRLR3AwZGx1VzFi?=
 =?utf-8?B?TU02SzE4dVNvL05IeFozN214QXM2dHJCNVJjVHFrd1lsRUlSdnF6dmV3N09R?=
 =?utf-8?B?N0FQa0hyelRiSVBZSE1ZaEVYVExTS0NnTWNYWWhZQ2R0Rm55N2Y1M0RqY1NE?=
 =?utf-8?B?T2JpMW5TdU5CZ1hkMFRVS2czT2FSQTd2T2VsNFNEdjV4Vjd0VE5NanRlN1Vm?=
 =?utf-8?B?eHQ1QldjVUZhb1ltQWV0cHBVV0Q1MDltcGRVUGxrZXA5OG04MWgrWUl4Umd4?=
 =?utf-8?B?NEVGajFiU2tTTWJ2bGwvZ1VXenE2ZzVhaWdkMXdoUGNjMlZDM0FqaTVjbEtR?=
 =?utf-8?B?OUhrTzNWd0tLcHNDYzQ2bFY3bjEyZjBWRjVJeHNhNnB0R1ZUZGErNEFLTHJt?=
 =?utf-8?B?N2R2dktVU24zOHUrRzE5WnVSdUx6RFlMbnlESzlXVFpDY3piSTNJWHRFNmtp?=
 =?utf-8?B?VHVjR2EvLzdGaUE0eDdqNG04WmZlWUUvWEl3QmE5RVZJN3JsK3pGS3BNdjRz?=
 =?utf-8?B?dy9YemdVVUs1OXM0bVNIUTZaTzFRY3JnTHBYM3ZoNmxTYmtRVStweFFQWnRU?=
 =?utf-8?B?bk1JTFY3c203bW9ZYkd3Wms0TU5DcHpQak1QbHNIcUhIZG5UcitVd2JLdnI0?=
 =?utf-8?B?TFlKZDd1amxBRmtSalBqeXl4TG1WbnMwUXJzSXlxRzRwdC9jYWg4S09pQlAv?=
 =?utf-8?B?TVltNHBTVU1iTVpIaHZnWEdHOUFiZ1B3RDdxamxCa1lNTDlTTlo5UjlwdXgv?=
 =?utf-8?B?cHZBL1N1U0RNU2t3d2pIc1VnRzQxYk1pVnlVd0g5d2dsS0JQS1c4MUFpWHd5?=
 =?utf-8?B?cFRxeDBCYWdXWnpqWnlaRGFhSnV0K0dxMGFUTTg3U3liZjM0Z3FPVXpaN1Fy?=
 =?utf-8?B?cnN1Y1prV0F2WWVUWTBPMnVYNXpTNC9ZUndNelMwWXVsVkNFZGRrNVZqZVJB?=
 =?utf-8?B?V3dnZ0pFWnArVGRhclRxajJUbGNTbXpHR0toMmJFZER3WnNWdzFzdTZIbEVE?=
 =?utf-8?B?K0NabjF4dnhYcEpCUkZNUjVRTDZFM2x5ZUNacHQ3ZTlDUEFndTBpb2lvYk9W?=
 =?utf-8?B?YXJKd3BaSUJEbEN3MXl4WDFnUit2U1JGNHdXQmJzREZWM09JUXJjUko3NGpO?=
 =?utf-8?B?S1crUGtlcW0yYi8zTUNGTHZmeW1VSkc1MUdEVnFZaEJoNVN0enArdXBDb29O?=
 =?utf-8?B?d1Q1dHM3RENRSVFCOHlLclgzUjBVV1FjQTZBbGFqQjNFNitxM09JdHZVOUdy?=
 =?utf-8?Q?1e7nT4mWnJVZUjfhaD1+nQ/i/?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3318ce7e-83f2-44e0-b34c-08dd4ff58204
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 08:23:22.3350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r/NZQItS92WYsjv9aIcQwAmuLOmUNb/GvPHLo8tQNs5IbbXRBJJRvwEdHIzX7fU6dcnSbaEM5bPk9CMmC/lxSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8025
X-OriginatorOrg: intel.com

PiBGcm9tOiBZYXplbiBHaGFubmFtIDx5YXplbi5naGFubmFtQGFtZC5jb20+DQo+IFsuLi5dDQo+
IGJlaGF2aW9yLiBUaGUgZGVmZXJyZWQgZXJyb3IgaW50ZXJydXB0IGlzIHRlY2huaWNhbGx5IGFk
dmVydGlzZWQgYnkgdGhlIFNVQ0NPUg0KPiBmZWF0dXJlLiBIb3dldmVyLCB0aGlzIHdhcyBmaXJz
dCBtYWRlIGF2YWlsYWJsZSBvbiBTTUNBIHN5c3RlbXMuDQo+IFRoZXJlZm9yZSwgb25seSBzZXQg
dXAgdGhlIGRlZmVycmVkIGVycm9yIGludGVycnVwdCBvbiBTTUNBIHN5c3RlbXMgYW5kDQo+IHNp
bXBsaWZ5IHRoZSBjb2RlLg0KDQpEb2VzIHRoaXMgZGVzY3JpcHRpb24gaW1wbHkgdGhhdDoNCg0K
ICAgIGlmIG1jZV9mbGFncy5zdWNjb3IgPSB0cnVlLCB0aGVuIG1jZV9mbGFncy5zbWNhIG11c3Qg
YWxzbyBiZSB0cnVlLg0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBZYXplbiBHaGFubmFtIDx5YXpl
bi5naGFubmFtQGFtZC5jb20+DQo+IFsuLi5dDQo+IC1zdGF0aWMgdm9pZCBkZWZlcnJlZF9lcnJv
cl9pbnRlcnJ1cHRfZW5hYmxlKHN0cnVjdCBjcHVpbmZvX3g4NiAqYykgLXsNCj4gLQl1MzIgbG93
ID0gMCwgaGlnaCA9IDA7DQo+IC0JaW50IGRlZl9vZmZzZXQgPSAtMSwgZGVmX25ldzsNCj4gLQ0K
PiAtCWlmIChyZG1zcl9zYWZlKE1TUl9DVV9ERUZfRVJSLCAmbG93LCAmaGlnaCkpDQo+IC0JCXJl
dHVybjsNCj4gLQ0KPiAtCWRlZl9uZXcgPSAobG93ICYgTUFTS19ERUZfTFZUT0ZGKSA+PiA0Ow0K
PiAtCWlmICghKGxvdyAmIE1BU0tfREVGX0xWVE9GRikpIHsNCj4gLQkJcHJfZXJyKEZXX0JVRyAi
WW91ciBCSU9TIGlzIG5vdCBzZXR0aW5nIHVwIExWVCBvZmZzZXQgMHgyIGZvcg0KPiBkZWZlcnJl
ZCBlcnJvciBJUlFzIGNvcnJlY3RseS5cbiIpOw0KPiAtCQlkZWZfbmV3ID0gREVGX0xWVF9PRkY7
DQo+IC0JCWxvdyA9IChsb3cgJiB+TUFTS19ERUZfTFZUT0ZGKSB8IChERUZfTFZUX09GRiA8PCA0
KTsNCj4gLQl9DQoNClRoaXMgY29kZSBpcyBtaXNzaW5nIGZyb20gdGhpcyBwYXRjaC4NCkV4cGVj
dGVkPw0KDQo+IC0NCj4gLQlkZWZfb2Zmc2V0ID0gc2V0dXBfQVBJQ19kZWZlcnJlZF9lcnJvcihk
ZWZfb2Zmc2V0LCBkZWZfbmV3KTsNCj4gLQlpZiAoKGRlZl9vZmZzZXQgPT0gZGVmX25ldykgJiYN
Cj4gLQkgICAgKGRlZmVycmVkX2Vycm9yX2ludF92ZWN0b3IgIT0gYW1kX2RlZmVycmVkX2Vycm9y
X2ludGVycnVwdCkpDQo+IC0JCWRlZmVycmVkX2Vycm9yX2ludF92ZWN0b3IgPSBhbWRfZGVmZXJy
ZWRfZXJyb3JfaW50ZXJydXB0Ow0KPiAtDQo+IC0JaWYgKCFtY2VfZmxhZ3Muc21jYSkNCj4gLQkJ
bG93ID0gKGxvdyAmIH5NQVNLX0RFRl9JTlRfVFlQRSkgfCBERUZfSU5UX1RZUEVfQVBJQzsNCj4g
LQ0KPiAtCXdybXNyKE1TUl9DVV9ERUZfRVJSLCBsb3csIGhpZ2gpOw0KPiAtfQ0KPiAtDQoNClRo
aXMgY29kZSBpcyBtaXNzaW5nIGZyb20gdGhpcyBwYXRjaC4NCkV4cGVjdGVkPw0KDQo+ICBzdGF0
aWMgdTMyIHNtY2FfZ2V0X2Jsb2NrX2FkZHJlc3ModW5zaWduZWQgaW50IGJhbmssIHVuc2lnbmVk
IGludCBibG9jaywNCj4gIAkJCQkgIHVuc2lnbmVkIGludCBjcHUpDQo+ICB7DQo+IEBAIC01NTEs
NyArNTE2LDYgQEAgcHJlcGFyZV90aHJlc2hvbGRfYmxvY2sodW5zaWduZWQgaW50IGJhbmssIHVu
c2lnbmVkDQo+IGludCBibG9jaywgdTMyIGFkZHIsDQo+ICAJCQlpbnQgb2Zmc2V0LCB1MzIgbWlz
Y19oaWdoKQ0KPiAgew0KPiAgCXVuc2lnbmVkIGludCBjcHUgPSBzbXBfcHJvY2Vzc29yX2lkKCk7
DQo+IC0JdTMyIHNtY2FfbG93LCBzbWNhX2hpZ2g7DQo+ICAJc3RydWN0IHRocmVzaG9sZF9ibG9j
ayBiOw0KPiAgCWludCBuZXc7DQo+IA0KPiBAQCAtNTcxLDE4ICs1MzUsMTAgQEAgcHJlcGFyZV90
aHJlc2hvbGRfYmxvY2sodW5zaWduZWQgaW50IGJhbmssDQo+IHVuc2lnbmVkIGludCBibG9jaywg
dTMyIGFkZHIsDQo+ICAJX19zZXRfYml0KGJhbmssIHRoaXNfY3B1X3B0cigmbWNlX2FtZF9kYXRh
KS0+dGhyX2ludHJfYmFua3MpOw0KPiAgCWIuaW50ZXJydXB0X2VuYWJsZSA9IDE7DQo+IA0KPiAt
CWlmICghbWNlX2ZsYWdzLnNtY2EpIHsNCj4gLQkJbmV3ID0gKG1pc2NfaGlnaCAmIE1BU0tfTFZU
T0ZGX0hJKSA+PiAyMDsNCj4gLQkJZ290byBzZXRfb2Zmc2V0Ow0KPiAtCX0NCj4gLQ0KPiAtCS8q
IEdhdGhlciBMVlQgb2Zmc2V0IGZvciB0aHJlc2hvbGRpbmc6ICovDQo+IC0JaWYgKHJkbXNyX3Nh
ZmUoTVNSX0NVX0RFRl9FUlIsICZzbWNhX2xvdywgJnNtY2FfaGlnaCkpDQo+IC0JCWdvdG8gb3V0
Ow0KPiAtDQo+IC0JbmV3ID0gKHNtY2FfbG93ICYgU01DQV9USFJfTFZUX09GRikgPj4gMTI7DQo+
ICsJaWYgKG1jZV9mbGFncy5zbWNhKQ0KPiArCQlnb3RvIGRvbmU7DQo+IA0KPiAtc2V0X29mZnNl
dDoNCj4gKwluZXcgPSAobWlzY19oaWdoICYgTUFTS19MVlRPRkZfSEkpID4+IDIwOw0KPiAgCW9m
ZnNldCA9IHNldHVwX0FQSUNfbWNlX3RocmVzaG9sZChvZmZzZXQsIG5ldyk7DQo+ICAJaWYgKG9m
ZnNldCA9PSBuZXcpDQo+ICAJCXRocmVzaG9sZGluZ19pcnFfZW4gPSB0cnVlOw0KPiBAQCAtNTkw
LDcgKzU0Niw2IEBAIHByZXBhcmVfdGhyZXNob2xkX2Jsb2NrKHVuc2lnbmVkIGludCBiYW5rLCB1
bnNpZ25lZA0KPiBpbnQgYmxvY2ssIHUzMiBhZGRyLA0KPiAgZG9uZToNCj4gIAltY2VfdGhyZXNo
b2xkX2Jsb2NrX2luaXQoJmIsIG9mZnNldCk7DQo+IA0KPiAtb3V0Og0KPiAgCXJldHVybiBvZmZz
ZXQ7DQo+ICB9DQo+IA0KPiBAQCAtNjU5LDYgKzYxNCwzMiBAQCBzdGF0aWMgdm9pZCBkaXNhYmxl
X2Vycl90aHJlc2hvbGRpbmcoc3RydWN0DQo+IGNwdWluZm9feDg2ICpjLCB1bnNpZ25lZCBpbnQg
YmFuaykNCj4gIAkJd3Jtc3JsKE1TUl9LN19IV0NSLCBod2NyKTsNCj4gIH0NCj4gDQo+ICsvKg0K
PiArICogRW5hYmxlIHRoZSBBUElDIExWVCBpbnRlcnJ1cHQgdmVjdG9ycyBvbmNlIHBlci1DUFUu
IFRoaXMgc2hvdWxkIGJlDQo+ICtkb25lIGJlZm9yZSBoYXJkd2FyZSBpcw0KPiArICogcmVhZHkg
dG8gc2VuZCBpbnRlcnJ1cHRzLg0KPiArICoNCj4gKyAqIEluZGl2aWR1YWwgZXJyb3Igc291cmNl
cyBhcmUgZW5hYmxlZCBsYXRlciBkdXJpbmcgcGVyLWJhbmsgaW5pdC4NCj4gKyAqLw0KPiArc3Rh
dGljIHZvaWQgc21jYV9lbmFibGVfaW50ZXJydXB0X3ZlY3RvcnModm9pZCkNCj4gK3sNCj4gKwlz
dHJ1Y3QgbWNlX2FtZF9jcHVfZGF0YSAqZGF0YSA9IHRoaXNfY3B1X3B0cigmbWNlX2FtZF9kYXRh
KTsNCj4gKwl1NjQgbWNhX2ludHJfY2ZnLCBvZmZzZXQ7DQo+ICsNCj4gKwlpZiAoIW1jZV9mbGFn
cy5zbWNhIHx8ICFtY2VfZmxhZ3Muc3VjY29yKQ0KPiArCQlyZXR1cm47DQo+ICsNCg0KSW4gdGhl
IG9sZCBjb2RlLCB0aGUgZGVmZXJyZWQgSVJRIHNldHVwIGp1c3QgZGVwZW5kcyBvbiBtY2VfZmxh
Z3Muc3VjY29yLA0KQnV0IG5vdyBpdCBkZXBlbmRzIG9uOiBtY2VfZmxhZ3Muc21jYSAmJiBtY2Vf
ZmxhZ3Muc3VjY29yLg0KSXMgdGhpcyBleHBlY3RlZD8NCg0KPiArCWlmIChyZG1zcmxfc2FmZShN
U1JfQ1VfREVGX0VSUiwgJm1jYV9pbnRyX2NmZykpDQo+ICsJCXJldHVybjsNCj4gKw0KPiArCW9m
ZnNldCA9IChtY2FfaW50cl9jZmcgJiBTTUNBX1RIUl9MVlRfT0ZGKSA+PiAxMjsNCj4gKwlpZiAo
IXNldHVwX0FQSUNfZWlsdnQob2Zmc2V0LCBUSFJFU0hPTERfQVBJQ19WRUNUT1IsDQo+IEFQSUNf
RUlMVlRfTVNHX0ZJWCwgMCkpDQo+ICsJCWRhdGEtPnRocl9pbnRyX2VuID0gdHJ1ZTsNCj4gKw0K
PiArCW9mZnNldCA9IChtY2FfaW50cl9jZmcgJiBNQVNLX0RFRl9MVlRPRkYpID4+IDQ7DQo+ICsJ
aWYgKCFzZXR1cF9BUElDX2VpbHZ0KG9mZnNldCwgREVGRVJSRURfRVJST1JfVkVDVE9SLA0KPiBB
UElDX0VJTFZUX01TR19GSVgsIDApKQ0KPiArCQlkYXRhLT5kZnJfaW50cl9lbiA9IHRydWU7DQo+
ICt9DQo+ICsNCj4gIHN0YXRpYyB2b2lkIGFtZF9hcHBseV9xdWlya3Moc3RydWN0IGNwdWluZm9f
eDg2ICpjKSAgew0KPiAgCXN0cnVjdCBtY2VfYmFuayAqbWNlX2JhbmtzID0gdGhpc19jcHVfcHRy
KG1jZV9iYW5rc19hcnJheSk7IEBADQo+IC02OTAsMTEgKzY3MSwxNiBAQCB2b2lkIG1jZV9hbWRf
ZmVhdHVyZV9pbml0KHN0cnVjdCBjcHVpbmZvX3g4NiAqYykNCj4gDQo+ICAJYW1kX2FwcGx5X3F1
aXJrcyhjKTsNCj4gIAltY2VfZmxhZ3MuYW1kX3RocmVzaG9sZAkgPSAxOw0KPiArCXNtY2FfZW5h
YmxlX2ludGVycnVwdF92ZWN0b3JzKCk7DQo+IA0KPiAgCWZvciAoYmFuayA9IDA7IGJhbmsgPCB0
aGlzX2NwdV9yZWFkKG1jZV9udW1fYmFua3MpOyArK2JhbmspIHsNCj4gLQkJaWYgKG1jZV9mbGFn
cy5zbWNhKQ0KPiArCQlpZiAobWNlX2ZsYWdzLnNtY2EpIHsNCj4gIAkJCXNtY2FfY29uZmlndXJl
KGJhbmssIGNwdSk7DQo+IA0KPiArCQkJaWYgKCF0aGlzX2NwdV9wdHIoJm1jZV9hbWRfZGF0YSkt
PnRocl9pbnRyX2VuKQ0KPiArCQkJCWNvbnRpbnVlOw0KPiArCQl9DQo+ICsNCj4gIAkJZGlzYWJs
ZV9lcnJfdGhyZXNob2xkaW5nKGMsIGJhbmspOw0KPiANCj4gIAkJZm9yIChibG9jayA9IDA7IGJs
b2NrIDwgTlJfQkxPQ0tTOyArK2Jsb2NrKSB7IEBAIC03MTUsOQ0KPiArNzAxLDYgQEAgdm9pZCBt
Y2VfYW1kX2ZlYXR1cmVfaW5pdChzdHJ1Y3QgY3B1aW5mb194ODYgKmMpDQo+ICAJCQlvZmZzZXQg
PSBwcmVwYXJlX3RocmVzaG9sZF9ibG9jayhiYW5rLCBibG9jaywNCj4gYWRkcmVzcywgb2Zmc2V0
LCBoaWdoKTsNCj4gIAkJfQ0KPiAgCX0NCj4gLQ0KPiAtCWlmIChtY2VfZmxhZ3Muc3VjY29yKQ0K
PiAtCQlkZWZlcnJlZF9lcnJvcl9pbnRlcnJ1cHRfZW5hYmxlKGMpOw0KDQpUaGUgb2xkIGNvZGUg
dG8gc2V0IHVwIGRlZmVycmVkIGVycm9yIElSUSBqdXN0IGRlcGVuZHMgb24gbWNlX2ZsYWdzLnN1
Y2NvciwNCj4gWy4uLl0NCg==

