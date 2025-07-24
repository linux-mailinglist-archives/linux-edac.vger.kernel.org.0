Return-Path: <linux-edac+bounces-4429-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72263B10DAC
	for <lists+linux-edac@lfdr.de>; Thu, 24 Jul 2025 16:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EF19AC0E49
	for <lists+linux-edac@lfdr.de>; Thu, 24 Jul 2025 14:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F4628D8FF;
	Thu, 24 Jul 2025 14:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Klr2cZRU"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA2028D82E;
	Thu, 24 Jul 2025 14:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753367573; cv=fail; b=jCjMVHkFgNYX7508qIATLsb7l6J12w05Jw3PLYg18TKeMj+j1gjo+aNrKJToKL6EMIG7ANNWWtT4483fpWUg/+VlZaJ4q4JL6NeNi9IUH3k4Vw8bE7GzQonf/YDqn4Pevhe8kgojg/KeeL/b2+3YXOSZJT/0Xj7Ib8wEeaEV2YY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753367573; c=relaxed/simple;
	bh=dnAm/b/GVEXovRX4D5M20JUyPLZNR8KkabFgWlKtM1c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YowVhO90YJYVLBn5wtPLh1+2eLc/MLiNqro+bcGh435S+v5Ng0H0WdKSld2b4hEQwH6Zk/YVu0F4mlyoIAMolU66HD3U1WDTpxx6G8vjGViuTq93FTnEqRYkgtRyhtxOmUz6qTBNRiwW3bvQrf0S6FkzoSc1+aSaiFUeXmSIXpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Klr2cZRU; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753367571; x=1784903571;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dnAm/b/GVEXovRX4D5M20JUyPLZNR8KkabFgWlKtM1c=;
  b=Klr2cZRUzFifO5+ROv42R7ts54hEMqRP//7X8S5VzBcftlGq8x106jOn
   x58F8VYVG+QEkUwFdNZdlY3PBxba0osPD9IKEX/lzs+kbAtetF26lnLOD
   l0i0FgBIY5VNhdUw18G4PuNwRIOh6C+8LrwaS3O5aO03upr1a+MiGWy0m
   plrKrggt3bpFguXQyRMtDYsK/bz9zg/0jPdhVRI65N5kDCFURH/CxLQ7N
   h3y6cjuSablMZOLuzWNYjDF/THqVM22/kKXbnV4FIFdbwM2S2cmUk1gJX
   qkJhZV9tWa8lq3Q1dzJMskLPg1Z6vW1zvqekELS0ZhWbMWjfOYypn2M50
   g==;
X-CSE-ConnectionGUID: CFEgO9RYSFSqgSVozPPbYQ==
X-CSE-MsgGUID: wcAQqW8jR32mdJJpz/QKmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="58308023"
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="58308023"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 07:32:50 -0700
X-CSE-ConnectionGUID: FWOH5/9cSsK1xwpXnvQdaw==
X-CSE-MsgGUID: loEwVbg1QUaIUQ+f/e7Sfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="164771610"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 07:32:37 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 24 Jul 2025 07:32:36 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 24 Jul 2025 07:32:36 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.76)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 24 Jul 2025 07:32:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ClglWceCIqTpI31/FiM6Z7wK/zSGpu8PUdUzi5cy2wJQR8LYRD7bonHZqmIAOSixv8YjF5dZqTJ4d/mubAKzzrazSjmy6NdNiYFGbqQdlX6cMFIpJY0B9o+Bl+SfifQrGDvbRudu91acgrxE/dYawM/i3q2HnH1BEjwaEsCmEyR6AcCeLalSaxAbNtlTPkgA2kgYdnGpSV5oiJ/3sNWEV4J7WjJpN9Z2G24G9tR69ENizbcDZPzLdZiULWUb61ddS81u/3IxzVN39Ht9GWGfr6f5dt5rCcUK3MKCOnBKPe2eT6MLBRKCc0kwjImNrpdsVB/6HqH1Z2LpF3dtzyCrXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dnAm/b/GVEXovRX4D5M20JUyPLZNR8KkabFgWlKtM1c=;
 b=OVc10E6xPozgB8VtJd3xLBQQeYyF+t7ohOoKSWXFKScsX79IRbLvhZTMHvLn63IPX1yfxuiq50bDJGRjPOPXTWeqttRy+Y/PoauKGrXCo/67HATjZLgo0IFaufeLVjMA8ObmNhrSS6q6w3GNFVlbYKRIBRHUTf8thL+J71ZshXltvOHVHwaCzQc6Bqz42MZ5G8gFTIBWZ9JGjbxesB5v7qWSUOe9D7NHiAv+MrJQkgrvMLhA8uMc3hqWqT52EM2aQk00gsAqu2l4vCD1hHzxCd5yXbgh9YqOk6LgNvDAMZblEUxtPCU/VQNXKXZsnN37dLCv1KyxIZqR895CnD9IHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by MW5PR11MB5883.namprd11.prod.outlook.com (2603:10b6:303:19f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 14:31:53 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%7]) with mapi id 15.20.8922.037; Thu, 24 Jul 2025
 14:31:52 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Kyle Manna <kyle@kylemanna.com>, "Luck, Tony" <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>, Jason Baron <jbaron@akamai.com>
CC: James Jernigan <jameswestonjernigan@gmail.com>, James Morse
	<james.morse@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, "Robert
 Richter" <rric@kernel.org>, "Lai, Yi1" <yi1.lai@intel.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] EDAC/ie31200: Add two more Intel Alder Lake-S SoCs
 for EDAC support
Thread-Topic: [PATCH 1/1] EDAC/ie31200: Add two more Intel Alder Lake-S SoCs
 for EDAC support
Thread-Index: AQHb/GafXcVlZ3WZRkiBtd6ukhBRJbRBVQ7g
Date: Thu, 24 Jul 2025 14:31:52 +0000
Message-ID: <CY8PR11MB7134484D663C31DA1544945B895EA@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20250724064415.1134574-1-kyle@kylemanna.com>
In-Reply-To: <20250724064415.1134574-1-kyle@kylemanna.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|MW5PR11MB5883:EE_
x-ms-office365-filtering-correlation-id: 1c9bfa62-49b4-453b-e958-08ddcabed55a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Snhrd1QzODNGY0RsMkdPSWtnUTN2QmVqdVIwSCtRRElGWGY4alBMRk5NVllw?=
 =?utf-8?B?bVRrTDZtTFdMSUxVbHpSSm5kQW56aER5Q0FHWkRDNExUbUFkVHZMNzZTeHhu?=
 =?utf-8?B?NG81NFZBKzJObEZoY0VhR2g2a1UzVVR5RVpSK2owbDMxdFZKaHNsNnNoTGp2?=
 =?utf-8?B?bGZiNkRHV2hacG80Q08vWnFBK1pLZ2VXdm8ram91ZTJjN2R0Y1ltTmZ0ajR4?=
 =?utf-8?B?L0l6VmwyUXhMQWR6NGVvZDZYc1g3dVZ1L3N0OTRNY2JIWGUzYkVNaVpmNGlj?=
 =?utf-8?B?eVlOV0dYaUtEc1JOZngvY096MjVlT1h5UUZaUndwTnIzbTdDRm92RGhJeXc4?=
 =?utf-8?B?TytQMWtKbHlqMzZ3dkdNbEJjNmVqaVp3NTlHbXBsQ2dReWQ3YzdwdXUxb2U2?=
 =?utf-8?B?T3J5ZnBmT3J4eGNyTmRlQU1OdjhWK3VORWlpMk5VaUZucTlMZ1lzZGE1Zk95?=
 =?utf-8?B?WmJyVlFUWUhtakJrWjhEN3p3STlBQy92RWtjSWk4NDdtVmgzMUQzLzd1Zk85?=
 =?utf-8?B?OEFFSmowWVlzckxZZmkrYXRvYW9TZjV3SUhNS0RVdEF0OGNlQnU4SWN3QWxm?=
 =?utf-8?B?SFc5UEJJZFdDZ1hTVm9sVkNHV1JiSk02SW9nL0F1YmpuS0FrYmlOaDZLQUFC?=
 =?utf-8?B?U2g1RDhKbjMzZUpPblJyODhGKzI5UXBieVVSWFVKdnRpVmwvZjNZZ0laQVZF?=
 =?utf-8?B?cXNwWFRwRTlTT1MzTmdUazhoKy94bEVYQk1HYUtWY0t2aVdpOWlzbVdOVG5H?=
 =?utf-8?B?cThOT3RSZEh0TGM0bGk1ZHFwZThIT2JDVkwvdW1jQjZNUDUvMzNCcWQzY3kr?=
 =?utf-8?B?NGh1NU5VR2ttVVVuOUtSMG5rdzNBcXJ1WTUydFlsc1hKVzN1WnlhWko5QVFH?=
 =?utf-8?B?bkt4czRLOHUrNyt4NnB6SG1OL3JtcUQxeWZBTlQzTnNLTGhZR2I5ZmhBdVpy?=
 =?utf-8?B?eUdpRXliNkNpMmM0VS8xMmpBT2dNS3ZwV0o5TTNBb0hJQVQ1WTJHOVNTZGxR?=
 =?utf-8?B?K05NTmFCTUduR1IyRi9zRkN3bXZKWTY0YzJKbC9UQ2ZXSjlMdGtlejFwazYy?=
 =?utf-8?B?QXVjdi91ZUQwVFpDa0NtZC9OR1F1a1RnRldDMys0R1U5Wlp0S3ZFbjg2YUY1?=
 =?utf-8?B?OWFrNHZaRVFLaFhCTmdhSmI4dmRqNGd4cS9vZDZRWVllekc2STdZUWNPUjZj?=
 =?utf-8?B?ak9NdTZDaDJjanVMaGNHVTVpaFFSMnpTNDA3aXRUTjNpSUZxcERHNC84N3Nn?=
 =?utf-8?B?LzJkalV1ZXlCUVFjNEFvYlVnR0VYL0c3WjVjRHVtN3hwOHBodmduRDMzWGFa?=
 =?utf-8?B?WXo2SGQ0enkvUnRtRUxTVFZVaWNMV29KY01TRDhFYkR3RlJWTEtmL0ozMXVk?=
 =?utf-8?B?cHlXc0xNMGRoRnM0YjVra0hld0p2dGJ0eHZGRzczTHdzOWNYc21saG90cCtQ?=
 =?utf-8?B?MjNRMG5FendrSGc2bHphdGJMVWlhSVlCWERCWXlrRVRodEFaZ1FnSlMvTU91?=
 =?utf-8?B?dVBxQWw1aS9lam43M0NhRzRiL25aZlZsaDVWcE5NTEtWL21TYUhaWFppakpw?=
 =?utf-8?B?QTdCVDF5S3ZNVmZOYU9ma1FvMWpOMUxpWEJCN3NkczRjaFVRZjdzM3NnWnd6?=
 =?utf-8?B?U3J1QVhmbU5EYmsvVjgzT0hSNUdrTm5UWjNmSklHUy9JRWdORWxrQm5TMUFH?=
 =?utf-8?B?MUEvWVJUaElFdXZnWFFyemVFUWc2SlhkaENQU3VoZ1g2VEVjZnh2b1pKVjRo?=
 =?utf-8?B?OFUvWDZ5WWRsdDBuK2RDZUVKY0lhUFFsVXJsbStqOGhIMjh0d2IvZFN6WE9U?=
 =?utf-8?B?ZkNxVTg3SHBGTHg4NjNhbHFCU2RVUXZGQUZNZm9iNWVxSk1oTW1kcWN5dXE0?=
 =?utf-8?B?VUFmblI4SzNoVzFLSUtBVVlxZU5xdk1oMjhFMFVWQ2YrYnRzb3VvUDB3OXo0?=
 =?utf-8?B?RU1EZWEwUkMra3FmS1BTZFI1ZkVGQ3FMYnd4TWpOaUIvQlk1NlFQc0ZvN2Nm?=
 =?utf-8?Q?2wieujePhkifrpSsRStrVbc0HJvXbI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OENMZGJ2NjVpV3RuOFNLZ2FrZWg3dHJ3U29wUTlIb3BTTXNjZDIrTG5iaVZN?=
 =?utf-8?B?d2pEMU1rc1Vqa25UNVVsQThQT3kvOWtiem92My9zU3dzZHhrcWx2NUxMRElq?=
 =?utf-8?B?WUVSSEhkKzNGWjIvY25iZHVDanNuTzI0QVpkTXJmTDg4ek9MWGVldTFHMkor?=
 =?utf-8?B?R1lTZEZJek00enB0dEpnLzc0cFdZT2VZN2dCWi9DRExxZlV1U21XZTBCVzNY?=
 =?utf-8?B?cVhFcFpSNHp6UEd5RFFOVFdTRS90ZVNnSXQ4RVk4eU03UktMd29iK2VQeEZr?=
 =?utf-8?B?WTFOK2J1UFErZUgwMlZ3dkc2dy8xTVp2dzFPL2o0QUxvRlRaUnNWVHJ2bGlQ?=
 =?utf-8?B?Tmx4Yk9POTBnVkxOZE5iNXMzV0dCRXUzVlJjQ2dtWlhJMDFlTHpSQ3FheDJM?=
 =?utf-8?B?bGpIWDVkZ2pxeGVHMndweVFaOWw0UFpxQ3g1Q1UyVmRSelJTY2tPY2Nna2FS?=
 =?utf-8?B?TzdLS2I5S3pvS1lFSFZSU1N6STJRam1HN2lyaWJIWldvVUNQN2VNdW4vU21M?=
 =?utf-8?B?bWxSQlErMFdYNkxYaHl1dzZQZGw2ci80UGZTQkNTV0dsNHEvR0R6ZXlxL2Jn?=
 =?utf-8?B?eEdvdUxqWVcxaWtuNWp5SkhxS0dwQTNMQjM3NGhqNUY5d1lhWTFPZ1FnMlFo?=
 =?utf-8?B?dzBWUmVmTVBSUllwQWdzVkYzQU5oSWxseThubkg0M3o1YWYySWE2UHZwL09h?=
 =?utf-8?B?UmYvdy9xa2h0TG1Ldms5dFBxdzNiaGlVYm8yekZiMUVxeHVkRHRRUkRBVTZ0?=
 =?utf-8?B?UkRzdHJkUXNNbFhSdjExSlAvbzY5T1h1WjM3YWhCRFFOSEFWOVZpeFVnU0tu?=
 =?utf-8?B?ZFpxOXU4THJXUGdMWHoydGZDaXdSbU5vdTZacGQxWlozY0pydGs0ZDl0a2x5?=
 =?utf-8?B?SzdzMHVYSWYvelB4am9CODNTcTMwWTFpOExzSER5RmhMQ3huY2k0ZGNBbWY3?=
 =?utf-8?B?R3NMbUVCSnp5RVNFb2xUS0VsRWc4aG1uc2VRRXI5aE4wMWs4WnF4Y2JCT29C?=
 =?utf-8?B?anBGaW0yVDhTSEduZzc5OUJVdUZkS1IzREZjQ1FIRnNXUWp2ZCtycFpwVHBT?=
 =?utf-8?B?WndGdFpSVithR2hxMGJrVnZsMlZkOHBndTVSeGJOWWFaM25mUjEySXhYNkNv?=
 =?utf-8?B?NDFuVW5Db05QVmh0dzlKem1RSHRjcG1UQXVDRjBzNXNqdG51clk3VmNxTTVI?=
 =?utf-8?B?QWkrcU1oNFI4L1NGSGo3aGRESEJ0TkY1SUtrc1JPTkxscC81WjFxaWZhWmtU?=
 =?utf-8?B?Y1p1VU5zMnNqVkUvUWhjQUV2ekhIT0pWQXJod2MxNDRDRzJSNXJIRjVIb2Er?=
 =?utf-8?B?eWFTeHVTU05IMGpJSXFxS2Y4K1EvUUVaUlhRTnlrb2FXKzhXeDRzRXZlbC81?=
 =?utf-8?B?eVd3TUFBVjlhQlZhcmJwd1g1K0UwNXhqRzJoVkJnamQ1bzI4OTlUbC9LeVRi?=
 =?utf-8?B?czVJUGJSN05yS3ZCV1d6N2MyVmFhWUliaTJYeWhDS0JBOHVqaUNmUWdzc3VW?=
 =?utf-8?B?d2VNMGRUZ21PbVVORTdYTEl1dUxLOUc0dnhrSmFMWFpYTzdSYWVTT3pkR2tp?=
 =?utf-8?B?QTdJT3RSQWs2TC90eEdIYWNLdjBvNGJBdytRM3lBS2svUWRINkdPZ0E1c0RU?=
 =?utf-8?B?bjVDQzJTTmQ4WEdRWGRlUDRNaFEvQzh1aG5RaHVaVVNvem1Mb0hrWEZTWW5V?=
 =?utf-8?B?blUxTDNCMGRsZ21OQWJra0xDc3F6Zjg0MjhwRExXZExTNWRMVTZJNHU2Ny9U?=
 =?utf-8?B?dXpMWTBmMW94bUV2cnZoMlhna0NuNnZycE1UMlBtOU9MbG5ybmFGR1Zmb256?=
 =?utf-8?B?YzEvRmtVTitJZjBhQnIwRXcwdUp0V2l3c1pwYzQvdW4rbi8yWEVEUHN6ZWlC?=
 =?utf-8?B?dXJ3ekx3aHVtRE5kS2tuaXRmS0tUTFdQVzY0Tlp2aDdsYlNJQ3VFZXlra3d4?=
 =?utf-8?B?R2Q0ZlhDUHR6NUV3cnNMZkJJRVY4UWtUbDB1dEorRXlJQlhlOUVOeTVzanNK?=
 =?utf-8?B?eTlIc3VTVUFJc3VVM1R0SlV4Rmx6SkFJcVZqaFhrcFRERHF3dEd6OElxMzJk?=
 =?utf-8?B?U2VhMVN1Q0QvMWJsais3OE9EaCsyNFRqK3hsK2pTVExjejJwQ25Nc0RyWUhK?=
 =?utf-8?Q?cqwZGlu/NDkZYfemuK5AOpS3k?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c9bfa62-49b4-453b-e958-08ddcabed55a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2025 14:31:52.3848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PQGZHUXPMp+wZBmubgYlybucWbBr09HxzO78bC3KktGW4ESKfNl0S4Oe1B4xQwiLyF35CMJ/S7dBK0tFw31osQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5883
X-OriginatorOrg: intel.com

SGkgS3lsZSwNCg0KPiBGcm9tOiBLeWxlIE1hbm5hIDxreWxlQGt5bGVtYW5uYS5jb20+DQo+IFNl
bnQ6IFRodXJzZGF5LCBKdWx5IDI0LCAyMDI1IDI6NDQgUE0NCj4gVG86IEx1Y2ssIFRvbnkgPHRv
bnkubHVja0BpbnRlbC5jb20+OyBCb3Jpc2xhdiBQZXRrb3YgPGJwQGFsaWVuOC5kZT47IEphc29u
DQo+IEJhcm9uIDxqYmFyb25AYWthbWFpLmNvbT4NCj4gQ2M6IFpodW8sIFFpdXh1IDxxaXV4dS56
aHVvQGludGVsLmNvbT47IEphbWVzIEplcm5pZ2FuDQo+IDxqYW1lc3dlc3Rvbmplcm5pZ2FuQGdt
YWlsLmNvbT47IEphbWVzIE1vcnNlDQo+IDxqYW1lcy5tb3JzZUBhcm0uY29tPjsgTWF1cm8gQ2Fy
dmFsaG8gQ2hlaGFiIDxtY2hlaGFiQGtlcm5lbC5vcmc+Ow0KPiBSb2JlcnQgUmljaHRlciA8cnJp
Y0BrZXJuZWwub3JnPjsgTGFpLCBZaTEgPHlpMS5sYWlAaW50ZWwuY29tPjsgbGludXgtDQo+IGVk
YWNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBLeWxlIE1h
bm5hDQo+IDxreWxlQGt5bGVtYW5uYS5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCAxLzFdIEVEQUMv
aWUzMTIwMDogQWRkIHR3byBtb3JlIEludGVsIEFsZGVyIExha2UtUyBTb0NzIGZvcg0KPiBFREFD
IHN1cHBvcnQNCj4gDQo+IEhvc3QgRGV2aWNlIElEcyAoRElEMCkgY29ycmVzcG9uZCB0bzoNCj4g
KiBJbnRlbCBDb3JlIGk3LTEyNzAwSw0KPiAqIEludGVsIENvcmUgaTUtMTI2MDBLDQo+IA0KPiBT
ZWUgZG9jdW1lbnRhdGlvbjoNCj4gKiAxMnRoIEdlbmVyYXRpb24gSW50ZWzCriBDb3Jl4oSiIFBy
b2Nlc3NvcnMgRGF0YXNoZWV0DQo+ICAgICAqIFZvbHVtZSAxIG9mIDIsIERvYy4gTm8uOiA2NTUy
NTgsIFJldi46IDAxMQ0KPiAgICAgKiBodHRwczovL2VkYy5pbnRlbC5jb20vb3V0cHV0L0Rvd25s
b2FkUGRmRG9jdW1lbnQ/aWQ9ODI5NyAoUERGKQ0KPiANCj4gU2lnbmVkLW9mZi1ieTogS3lsZSBN
YW5uYSA8a3lsZUBreWxlbWFubmEuY29tPg0KPiAtLS0NCg0KRG8geW91IGhhdmUgYWNjZXNzIHRv
IHRoZXNlIG1hY2hpbmVzIHRvIGxvYWQgdGhlIGllMzEyMDBfZWRhYw0KZHJpdmVyIHdpdGggeW91
ciBwYXRjaD8gSWYgeWVzLCB3b3VsZCB5b3UgdGFrZSBkbWVzZyBsb2dzPw0KDQo+ICBkcml2ZXJz
L2VkYWMvaWUzMTIwMF9lZGFjLmMgfCA0ICsrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2Vy
dGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2VkYWMvaWUzMTIwMF9lZGFjLmMg
Yi9kcml2ZXJzL2VkYWMvaWUzMTIwMF9lZGFjLmMgaW5kZXgNCj4gYTUzNjEyYmU0YjJmLi4yMDc4
YzEyYmJlZDIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZWRhYy9pZTMxMjAwX2VkYWMuYw0KPiAr
KysgYi9kcml2ZXJzL2VkYWMvaWUzMTIwMF9lZGFjLmMNCj4gQEAgLTk0LDYgKzk0LDggQEANCj4g
DQo+ICAvKiBBbGRlciBMYWtlLVMgKi8NCj4gICNkZWZpbmUgUENJX0RFVklDRV9JRF9JTlRFTF9J
RTMxMjAwX0FETF9TXzEJMHg0NjYwDQo+ICsjZGVmaW5lIFBDSV9ERVZJQ0VfSURfSU5URUxfSUUz
MTIwMF9BRExfU18yCTB4NDY2OA0KPiArI2RlZmluZSBQQ0lfREVWSUNFX0lEX0lOVEVMX0lFMzEy
MDBfQURMX1NfMwkweDQ2NDgNCj4gDQoNCkkgZGlkbid0IGZpbmQgdGhlIHBsYWNlIGluIHlvdXIg
c3BlYyBhYm92ZSB0aGF0IGluZGljYXRlcyB0aGVzZQ0KdHdvIENQVXMgd2l0aCB0aGVzZSB0d28g
RElEcyBoYXZlIE91dC1PZi1CYW5kIEVDQyBjYXBhYmlsaXRpZXMuDQpDb3VsZCB5b3UgcG9pbnQg
aXQgb3V0IHRvIG1lPw0KDQpUaGFua3MhDQotUWl1eHUNCg0K

