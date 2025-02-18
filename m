Return-Path: <linux-edac+bounces-3113-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC3DA39110
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 04:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C8ED7A3A06
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 02:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341A114A09E;
	Tue, 18 Feb 2025 03:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R2K28Xiy"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868D19475;
	Tue, 18 Feb 2025 03:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739847635; cv=fail; b=iTFhK4xxAcFWstXcfQe8J837R0aNoQYX2wLK/Nme9hltMRiAOKnTZA9se+XGnnjmzxlxLhJyIcvXtHS1MKyOC9EhFOFDG199qoZS9ruVxUFJCAk+JMMn2VMYv96Jf/YIf3Bm8ZoPMFVhNEzJ7SSiiPkyKOBi5VKEpZl3LG9pVeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739847635; c=relaxed/simple;
	bh=vf0XhD6WeJQd72vjvV/kTHXux+SDXZivbZbN9MarCKU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cUYfbgXeY/OVOqSP7D69okL4W9p8LPB0XxDAhKQsuh4jyAQOedzBasK/oA/HUQUV4YHYwA+GtF6ajl1/CVuzet3QWuO+52ULN3vRFtHXQ18YK+EFJ7+6xBKD8Oef9O5i31vaXwqvqfTRY+ePXIQQ7dkptG23gAhyzA/M/dJXYGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R2K28Xiy; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739847634; x=1771383634;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vf0XhD6WeJQd72vjvV/kTHXux+SDXZivbZbN9MarCKU=;
  b=R2K28XiyxThWF2SCQCQQrCbWN8FyuJfEcs/NhqS1N7v6TnCYRvDfgazK
   AJbRyuzU7XNNHBNIfmB4iiRpp3bLhxub4m9yhEIg6ZQ+RUDymRxhCMROK
   M6niBKsA03P8EqGq27yVB8Pk0f2uIFxmrbRNUumt2qQ7c//TBsTCnVgD9
   AAni3WQc6PQZ6cPbi9T5rlkYIpQEXy2KUZfEGtAJImrDbRH70Vx2+TMG/
   +PjNlESLXOtObZ6PJPbc7CZYCw4SJYlZj3Vqb585ZBVi78LzzTaZ7Hh8B
   3WJDESwcVBVC/yPRMEKcUGIcL3NZCCtAbBv670YFOtQytKWKEiHC6q0ao
   w==;
X-CSE-ConnectionGUID: bEHGUN/XR0e22LyQvj7Gcg==
X-CSE-MsgGUID: Y/yFSnt9Rrmgv+LOddT7QA==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="44457553"
X-IronPort-AV: E=Sophos;i="6.13,294,1732608000"; 
   d="scan'208";a="44457553"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 19:00:33 -0800
X-CSE-ConnectionGUID: qqYmetpaSnCQnGaOEBAdIQ==
X-CSE-MsgGUID: JyjE6SGCSuWRhOeXdAtQyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115167422"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 19:00:15 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 17 Feb 2025 19:00:14 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 17 Feb 2025 19:00:14 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Feb 2025 19:00:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nm6xziEG6BSoN5ogO0QtA7cEsARUI2yEf/0lF5dpSTUvHU5Ermbc1Y6qA6gj/3NUL4uEbnSWOuLt6eZs8m+H5xHbXnxdm0E8MllS0QPa0Gvby29VmDLnHDuDdwLEp+Q5tPVgXDEvC2MLSHFXpFpWu3TEdr9/iWDWPc/QI8Orfoz6oLPVqt9PBo7TdihpU11IDqdfL560H9K7mRcSs4SRYZN+mC/QCifRBaMAXhobN0mX66nx33Zx0lHtdXT/57M93F6q1tLj3+Irl/Ba0Fs/yBsHhf3vofjZzMb3lIkVYelqnwM7emQjMP2aCOXMnpuLrxkpNLfWDOuDa0Oic9lW7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vf0XhD6WeJQd72vjvV/kTHXux+SDXZivbZbN9MarCKU=;
 b=dWyFFy3qTxqUmh07LT1QhA1MztFyxMPe9QLFSsK948/96PQiUR6lkavbK9Ad8BbBe86fcQppn6snzakQeXjkI0vMYAy+JyIXSvPb1md7cNiqa3zcPoj9IOyrBlH+tBcSupvG8OIOMqySziNGwoqUqQOR3EatPockfDzij5BA0QrWnGPPcpx2EZsQsvotsM+Fa4xRgTbubawnQ5h4PxHqfYNWkviSb6k5GUJnM3etyWrIAwpcyZuLUt4+65i2bw5rVt7XaYFU744kt10/A4hLhzVYOybK74qXL8O1epOgV/vIAIA1Q/LDm6jHZTsrSVrSWAMjYDwitAowDv4cBSq1WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by CYXPR11MB8712.namprd11.prod.outlook.com (2603:10b6:930:df::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 03:00:13 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%4]) with mapi id 15.20.8422.012; Tue, 18 Feb 2025
 03:00:12 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>, "x86@kernel.org" <x86@kernel.org>,
	"Luck, Tony" <tony.luck@intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"Smita.KoralahalliChannabasappa@amd.com"
	<Smita.KoralahalliChannabasappa@amd.com>
Subject: RE: [PATCH v2 06/16] x86/mce: Remove __mcheck_cpu_init_early()
Thread-Topic: [PATCH v2 06/16] x86/mce: Remove __mcheck_cpu_init_early()
Thread-Index: AQHbfjfLYmLvDGoz0UGZGZ/ZkTfGI7NMZAwA
Date: Tue, 18 Feb 2025 03:00:12 +0000
Message-ID: <CY8PR11MB7134FBAFC4CC37B06C9AE7ED89FA2@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20250213-wip-mca-updates-v2-0-3636547fe05f@amd.com>
 <20250213-wip-mca-updates-v2-6-3636547fe05f@amd.com>
In-Reply-To: <20250213-wip-mca-updates-v2-6-3636547fe05f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|CYXPR11MB8712:EE_
x-ms-office365-filtering-correlation-id: cef60769-835e-4a07-0ec4-08dd4fc85cfe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WGVjOWM3b2FXQUVub0ZqT1dOOExiWm1oWUhSUDhQR294Tk1rOSt3ZGNINjRl?=
 =?utf-8?B?QzBMYXZ3T0pqVzdXTEFNVVovdWxGRG12bzFhcVkweFdnTDI3SGdzVDlOczNU?=
 =?utf-8?B?UjA4UWgxV2FYZTZmeTMvMWdFWHErTjVocTFzcnpiY29YdmdyWGh6RUp4SUhH?=
 =?utf-8?B?TjhxOVRMOVlMR3FwRU9Dcm9XbVJDK04vSDBQWUtWeldzK3ZXNGlDdGVFdGM5?=
 =?utf-8?B?TE5WVkUwWmJJQ09mUVhxZFJ1M29iSFk2dG1CSWpyZExTV004TlJ1TndnWi9h?=
 =?utf-8?B?dkpWbElXYWFRK0pDejdpYTJrYmN1aEJWdUxHN01JUk5BWFg4T3dKR0dXVC9X?=
 =?utf-8?B?VXZ1dG9qSkY5Q1AvRnU5VXdjUmVJaXYzSzNPbkZCd1ZDbXRSNC9rbzN2ZXpm?=
 =?utf-8?B?QXdlbEc4QittUlZ3bGZ1VklYODlGZnZETWg5UktaVTVvY2owUUFnK2tNM3Vr?=
 =?utf-8?B?VDIyaml5aE5ZRyttT1dzdEV6bC9kZFRxSkZ2NllaQlMwSUk0dGlvRDkySnB1?=
 =?utf-8?B?MTNZaHZ2RFlrT01sY0xNOFhSd21rS0tpWkhsMU5zdXJqZit2TWJLdXFoY2V6?=
 =?utf-8?B?R3dVSnlIVk5wdTlPNHFiTm5nL1IyVk9xNzVsT2lGci8yRmNxRTJqUExMMmRF?=
 =?utf-8?B?OVNIWWh6K3ZNN05ZVFBTTDN0TzJRakUzckMycUIxc2hOcXNxb0ZIZTZtRWRM?=
 =?utf-8?B?dFFJODNkT2VBS2JvRTNzcG9BVEJ5MDF1WStNTmVxb1dMTjdIYm9DOWpOUC9n?=
 =?utf-8?B?N0Q1SXBUb3NNNHhJdFV2THR1SHF2MlJHQU1hWFMxRjYrSHpkcmd3dXYxSUl6?=
 =?utf-8?B?UFlDcjhORU51Z1dzYmRpNUZnb2ZCOEE4VmVjR3FrWUx5cU9iS1paOE9lWDlZ?=
 =?utf-8?B?bEsyUzdLK0FtVW1XNkwxVmJYdHYwV1AwMVBscDJzRzZEcm0ySzRucG9HUkRo?=
 =?utf-8?B?TmRlU09QWUc0Y0M3U2QzTTRpc0praExpK2FnTWZTQUV0Q09zS1ZqTlhVQU9j?=
 =?utf-8?B?V0xyclNvRGx0OFAvQ3ltRVJGL3NvbGhXU0JIc2dKMk82YnozU0tVWjVnZ0dP?=
 =?utf-8?B?aW1waGViSDNleTdkajgyMGM1bDFMOUNaQWtGWGNWaFpJdERaN3dZNFFBcS9l?=
 =?utf-8?B?am5zMkNLVnFuZjViRUtsVWkwUFFBMkZ2ODVzbGhyR1czaWljN1UvbzRpSzNp?=
 =?utf-8?B?dmkybHk2ZzJIbFRncVZRNUFiNjYyNU5CcXk2dTNnUTJobW1OY3VUWXBJZmpm?=
 =?utf-8?B?eVRlZnpCa09sanA3WDg3VUFqWGpwU1QzSm83NGZxMzRMcmYzS3ArZklHMzZZ?=
 =?utf-8?B?N0s1a0QxOGdHRWl4VEs1U3V4U3NQQkpjQ2hBUjdvTG9XUTdsQ2ZHbnZ0b2E5?=
 =?utf-8?B?dFJDb3gvRFdxdUlCOXRoK3FJTW5wa09NYnJseVNVbXk2NjhGSEpMUldPNCtn?=
 =?utf-8?B?cTFQd3JrdlRLd3FobWJoYlRNbzMrYURvMmFKZDYwMWt3RU1nM1pBZVA5UWZB?=
 =?utf-8?B?cldBcUNFeUN6K3kzclRHalArUzFkOHpDUnE5Zk5FK2pCUzdFcGJjM3lPZ3lX?=
 =?utf-8?B?VkU4Vk5ESlQ4SUx5eGRrMEcvT3o5eGkrUGlFYkppUmpoT0MxRTVXaWk4NGJR?=
 =?utf-8?B?TFZqd2VZS0FHY2xtZFJGUmRyQVlwRzFtY1o3QnpySmU4OTh1am1tMzd1Z254?=
 =?utf-8?B?RjZ3aUxtK1VPUk5EamZzTU10OWR4ZzBzVEluSXNtM0dpc1ZaWWJzcW1uN2cr?=
 =?utf-8?B?RGpjQVNESUk4RHBvQnlDR0xoQ0R1MDZTVGNCamZKL3dkRXUzcDY2bFdUK3I0?=
 =?utf-8?B?YnhaT1lWOXhiRkg1OC9FZEVrY0FUVFpBZFNKZWdtcU9jamtuYUZjZURKM3M4?=
 =?utf-8?B?MHpLTHZaeEFFbzdxbUdzaFJHeXpIakxoakVmU3BGd1pRL3RjZTRkQ0x6cm5y?=
 =?utf-8?Q?H1SIMhmZ6k8zZdjzkilQwMoZRUr/parM?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWFCR0liUlA5OGJ1QWpBdFBxOWxUcjd3WFFGN2Fkb24rcVNHRWdDZ1p4TXZj?=
 =?utf-8?B?a3ZIK2RidlJndmVzYVQxekVvU3pyNFBnNHRKaXB1eGFJdDBzbjl3ZDRSbTZ0?=
 =?utf-8?B?UmFnc1RqK1lFQ3V3akdtYUFKQ1JzQ0VEa2VVZ2FUcVNmUW11MGVPRXp0T3BW?=
 =?utf-8?B?RjhleStTWHkyNFFlaUZUcFg0cGFLUzFHcGl1Y2c5R0llSDh6ZVR4VzBzWVY2?=
 =?utf-8?B?d0k2dEJxcXA1dEl4TXlCRjNoa3R0cHkxMzgvYnZ5SlFBUDFDOEVKclJ5VEQv?=
 =?utf-8?B?bzNxaXpEZXZTNHpMRVAvWERkUDlOK1Y5NTI5VGU4QmNwS1NvNUY3TGFYRVgy?=
 =?utf-8?B?WlR3ekN0K2hzMkFoL1h2dzdvM0kxSThoTzdZSXNha1ZrdmFVMm1ER1FwUHo5?=
 =?utf-8?B?ZzVHM1dnWUlrenFSSDF3Mk40d0JmYjVENGh1Mk1OSkQ0eWphQU5EL2hlN2dp?=
 =?utf-8?B?a3ErSHluRlJ4WXhrNTl6NisrNG0rcEVxdXFhRmdjbUJ6WG9STHZYRzduU0Zo?=
 =?utf-8?B?ZU45OFduNmZLeURmTitCYTR0aGJEWGY5ci9RSWNnVnI2OEpyTTZ5bXZjRlVo?=
 =?utf-8?B?WjZuYStsYjJjWVl4d1YyV2ErWVRNbjlMd0kzWWhscGpOK29majJoV21leHZJ?=
 =?utf-8?B?anUzd0VXVmJjR3Y2bFAvT2M2bnZBbUQ3ZXhYRVY4WUkrS2tqTDZOd05PY2Rt?=
 =?utf-8?B?WDVraEpqcWlhMitXbkpFL25zMVV1VEQwV0dqcFpsYVgrRWFSNUVMdDNHcXRy?=
 =?utf-8?B?Y3R2NEtHRjNKZW50OEdOVXJncWk4alFEWGZrNThDUDlCTlpDQkJZRTdtQUFW?=
 =?utf-8?B?aFZFQUpnc1B1YXc3bURTdHB6MWVwT0NWNitXN1hUazZUSml5RjdXVlZhKzdJ?=
 =?utf-8?B?b2tNazYzRWhVdnpsS0ZMdjVFZDVtQys3bFV2dTVONGtEaE8wS0ZxVnNiZ2E1?=
 =?utf-8?B?dllGSkZuUDdnL01SSGVRZXQrRGw0YlpZMnl0TlhZcFFFMHFqZWNZdzhrUHpl?=
 =?utf-8?B?UXFNNnRGaHZMVElUQ2RFNUcrdUQ1UDZKRlQ0a2E3WGJsbG8zR2dZTXZwNWpr?=
 =?utf-8?B?RzgzNzhPblVSV2kxQmxWOEpWU25SeGhKbnY2U3RLNnJZeUR6WFQyMC9obU9Z?=
 =?utf-8?B?RS9ORkZvb0Nha3BPaHl4OU40VGZRWEpXSisrcVlZTEIzRFZDM1FMYm1SZWMr?=
 =?utf-8?B?THBRdHc0Z09NbXA3V3ZmQU5DS0dGc1hnbWxzeWtPc0hRaDg2T0l0UXh3VE4v?=
 =?utf-8?B?MXgxam5CZHdCWTB1Zzl5U1p2NlB1ajRNNWs3WFRtSWYwb2NiQWNsOCt3VEY1?=
 =?utf-8?B?b1dlRklnTGUyai93OGxadTMvOHQ5TUhwbDN3N2hidkhORXBoWDVkZ3ZPSDVD?=
 =?utf-8?B?OFdMSEJmT2graHBxZUVtQkNOKzlETGY0NG5SVkVUdFlmU0VaMm52YTR5Kzlu?=
 =?utf-8?B?OExGQ25YTGRnTTExYzdnUUdCbWJCblhwT1h5WGRxU3FKYXdzcWM2Ly9ISXdH?=
 =?utf-8?B?WlA3UDNqOVNLM1p5cDRaRG95eTMyc0N3bHc5cW9CUXZ4T2VxWjhtUk9XaThD?=
 =?utf-8?B?NVA3ZHV6TmJqZHZNVXo4NzZpa3FzZnVlQ3pZWnFWNzV3TWNZbzVlZWFrRUlm?=
 =?utf-8?B?Zmdia1Z3MmcveWFENTZQQ3gxN1RuRld0QncrZlNHQjVhNTJNd2RUajIrZzls?=
 =?utf-8?B?UmhiL2owcW9icWV1emNEUTVBc0Fua2M3aG9TTVhxNHo2dEtDWlB3c3lRNXZk?=
 =?utf-8?B?YUg3bE5sYnlEU3cwVGt2TnZMM2VRRjZ2eERwd2JoTGZNeG9jdCtId0x1T0w4?=
 =?utf-8?B?QmkrQlEvT3V2YmdZSEYxdFY2T3YxTWVVSEpCMFJIWXlBQ1lMeGpVWm13K0VU?=
 =?utf-8?B?bWdSQkJNNTZlOXc1bit0cC9mMUZ0ZDJuNmgycVhpUTY0KzcrQzJVRWZROEox?=
 =?utf-8?B?S3E0VFRwbVFVU1IyTlRQeThOUi9OSmFkQVdiZm5tdDh2Ky9LaE5BclFFSlJU?=
 =?utf-8?B?dXVDb0ZnVWs4a0xNbHB6VW0zbndhOWVUNFl5Kzhqalg0QmdRVmd5cU1ZeHF2?=
 =?utf-8?B?YytRaVpVd2h5NGsrd3p6emYwckdEUytFMFozYTl0WkNhU0poVjhvK2svYnBx?=
 =?utf-8?Q?9UKJA99/JJLXsTJgcUVAGAIO7?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cef60769-835e-4a07-0ec4-08dd4fc85cfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 03:00:12.8366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CovCspYjqrhPS1c4l5tzWSeWMAzKfMmdowxyYpyZL26/Fvw9nkp5qLwl+/vt6tsxBPQ4Hp7hy8yqZr1UUvBuRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8712
X-OriginatorOrg: intel.com

PiBGcm9tOiBZYXplbiBHaGFubmFtIDx5YXplbi5naGFubmFtQGFtZC5jb20+DQo+IFNlbnQ6IEZy
aWRheSwgRmVicnVhcnkgMTQsIDIwMjUgMTI6NDYgQU0NCj4gVG86IHg4NkBrZXJuZWwub3JnOyBM
dWNrLCBUb255IDx0b255Lmx1Y2tAaW50ZWwuY29tPg0KPiBDYzogbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgbGludXgtZWRhY0B2Z2VyLmtlcm5lbC5vcmc7DQo+IFNtaXRhLktvcmFsYWhh
bGxpQ2hhbm5hYmFzYXBwYUBhbWQuY29tOyBZYXplbiBHaGFubmFtDQo+IDx5YXplbi5naGFubmFt
QGFtZC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCB2MiAwNi8xNl0geDg2L21jZTogUmVtb3ZlIF9f
bWNoZWNrX2NwdV9pbml0X2Vhcmx5KCkNCj4gDQo+IFRoZSBfX21jaGVja19jcHVfaW5pdF9lYXJs
eSgpIGZ1bmN0aW9uIHdhcyBpbnRyb2R1Y2VkIHNvIHRoYXQgc29tZQ0KPiB2ZW5kb3Itc3BlY2lm
aWMgZmVhdHVyZXMgYXJlIGRldGVjdGVkIGJlZm9yZSB0aGUgZmlyc3QgTUNBIHBvbGxpbmcgZXZl
bnQgZG9uZQ0KPiBpbiBfX21jaGVja19jcHVfaW5pdF9nZW5lcmljKCkuDQo+IA0KPiBDdXJyZW50
bHksIF9fbWNoZWNrX2NwdV9pbml0X2Vhcmx5KCkgaXMgb25seSB1c2VkIG9uIEFNRC1iYXNlZCBz
eXN0ZW1zDQo+IGFuZCBhZGRpdGlvbmFsIGNvZGUgd2lsbCBiZSBuZWVkZWQgdG8gc3VwcG9ydCB2
YXJpb3VzIHN5c3RlbSBjb25maWd1cmF0aW9ucy4NCj4gDQo+IEhvd2V2ZXIsIHRoZSBjdXJyZW50
IGFuZCBmdXR1cmUgdmVuZG9yLXNwZWNpZmljIGNvZGUgc2hvdWxkIGJlIGRvbmUgZHVyaW5nDQo+
IHZlbmRvciBpbml0LiBUaGlzIGtlZXBzIGFsbCB0aGUgdmVuZG9yIGNvZGUgaW4gYSBjb21tb24g
bG9jYXRpb24gYW5kDQo+IHNpbXBsaWZpZXMgdGhlIGdlbmVyaWMgaW5pdCBmbG93Lg0KPiANCj4g
TW92ZSBhbGwgdGhlIF9fbWNoZWNrX2NwdV9pbml0X2Vhcmx5KCkgY29kZSBpbnRvIG1jZV9hbWRf
ZmVhdHVyZV9pbml0KCkuDQo+IEFsc28sIG1vdmUgX19tY2hlY2tfY3B1X2luaXRfZ2VuZXJpYygp
IGFmdGVyDQo+IF9fbWNoZWNrX2NwdV9pbml0X3ByZXBhcmVfYmFua3MoKSBzbyB0aGF0IE1DQSBp
cyBlbmFibGVkIGFmdGVyIHRoZSBmaXJzdA0KPiBNQ0EgcG9sbGluZyBldmVudC4NCg0KTWF5YmUg
cHJvdmlkaW5nIGEgYml0IG1vcmUgaW5mb3JtYXRpb24gYWJvdXQgdGhlIGZpcnN0IE1DQSBwb2xs
aW5nIGV2ZW50LCANCmFzIHNob3duIGJlbG93LCB3b3VsZCBiZSBjbGVhcmVyOg0KDQogICAiLi4u
IHNvIHRoYXQgTUNBIGlzIGVuYWJsZWQgYWZ0ZXIgdGhlIGZpcnN0IE1DQSBwb2xsaW5nIGV2ZW50
IGZvciB0aGUgbWFjaGluZSANCiAgICBjaGVja3MgbGVmdCBvdmVyIGZyb20gdGhlIHByZXZpb3Vz
IHJlc2V0LiINCg0KPiBTaWduZWQtb2ZmLWJ5OiBZYXplbiBHaGFubmFtIDx5YXplbi5naGFubmFt
QGFtZC5jb20+DQoNCk90aGVyIHRoYW4gdGhhdCwNCg0KICAgIFJldmlld2VkLWJ5OiBRaXV4dSBa
aHVvIDxxaXV4dS56aHVvQGludGVsLmNvbT4NCiAgDQo=

