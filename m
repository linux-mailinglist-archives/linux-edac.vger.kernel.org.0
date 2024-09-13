Return-Path: <linux-edac+bounces-1871-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD5B97865F
	for <lists+linux-edac@lfdr.de>; Fri, 13 Sep 2024 19:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFC1C1F26CEA
	for <lists+linux-edac@lfdr.de>; Fri, 13 Sep 2024 17:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA0D74429;
	Fri, 13 Sep 2024 17:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cX190W4C"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BF74F20E
	for <linux-edac@vger.kernel.org>; Fri, 13 Sep 2024 17:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726247120; cv=fail; b=FvRkiKLbLyk/FaoKtU4nj4oKYgTJr691+AiE3/BxqQcnC3DbPnkeTjRszLzQEaILzuLIEQuV9SJ9fo8TI8aMRbq1SDY2uEJvDkxuW7COyHc3zBO5gTuuNKCpswDs0FqsJ/L8varxpbIgU70jtoKS+xEbeSNYPy/W297qGcEbeRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726247120; c=relaxed/simple;
	bh=cBPh6pfEn8zOcCemj2LlJJIYUwQY/8SbQJKlz+WMiUM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fR9ZxOlRMzDQoijPST1+Snesf8snGAYM6QsvULJwqVmpjnSHxiiYX9qs5KuGnQUV2UZPOkYyCeuL+SkAarvhFpyN0GzjU9BalEmKlqESxEKsfWRieGN/DPneiqRTZ27XtSUB0Nm71MG5yESgFSjmKPTOLktXBIfZchfd9eKiE/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cX190W4C; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726247119; x=1757783119;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=cBPh6pfEn8zOcCemj2LlJJIYUwQY/8SbQJKlz+WMiUM=;
  b=cX190W4C6bMnuCjkudMOl0Vdav1EKySlE0DadECp+JafY74eO+0G4EPt
   6X7NAyYjFlIPyOxgnY4nYeg0uGsTZ10guXTFKN/DLCPwzwhKPMgu98w3t
   LOzh7sy7pJPZVCC7G/9W1Pjmqtw7KX08HixlF0AP6aJxqrsTL5EXfHhpA
   kwHM2r4OEbLx5n19OsyzNWhwCIGoMLqzvDGzUgQv8fb1q1dyrLml6npIr
   Mj1Qx1ceJX6Nio8RxRXxKVhejXCbO23FKCFrJNd21E6j3HDei6cQb8QVs
   Gj05tIbSYuSe85JCxGeBmf9vHw70CUxc1NH5cMHuGh7HLh958vttij7Nx
   Q==;
X-CSE-ConnectionGUID: QsRhVrkSQB2F7C8fyuM39w==
X-CSE-MsgGUID: DWYaSg5zTb6Qv2VBKGVLkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="25037674"
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="25037674"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 10:05:19 -0700
X-CSE-ConnectionGUID: ExNQWWgqS1iZ8slGlovPyQ==
X-CSE-MsgGUID: bfb1+SRxSdWMi4Jk2wciqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="68376325"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Sep 2024 10:05:18 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 13 Sep 2024 10:05:18 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 13 Sep 2024 10:05:18 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 13 Sep 2024 10:05:18 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 13 Sep 2024 10:05:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RaARLa0a3nh8NPTZ1jdD4twew/giYXwoUxg7f0Y4XajdeuYEZF69/FPt1MABCZPKbIjaA4S7VlwKqWkk9HlssLGQ9P3VaLjo6fFOXtR6Rdxn67KAW3DhQpqiQeuVJmED7GJ4vPFA0gs8ZFdWqtTcmg5NK71gPrN9cF9WSwXSkdpwAO8EMvn6Ju2ErHJAedkO4ZJFJoaOfIWUPvaeYHAIXL0NO9EfhZg4lo8ZH70rAauvc1MDak5HVkNZvGBbTjMuy5lbxkx4WO+T36TngYqYGFpWulT3tbTsCEaHvmpmwL9fXId9StYWgmaNCNBAyWdaE793RjBNs1kT2ycO6Tj7PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cBPh6pfEn8zOcCemj2LlJJIYUwQY/8SbQJKlz+WMiUM=;
 b=QuJUi4hRFDbn5WwEfhIdw0DPJNanciX+aB+Oyg74l/iaxJ2N+4Vc6XCeOUUiS7ZE219WmiaanHQmt0qmwBjiR6t0WiSmIVYOqJBH6K0P6/vsR057cpFLavzVgd8KwMrlLb+4oylBGqUlatjna6m/59AKBJcSHgaZhfQAxCqnihP5Ozqg/Wfch18dfZCedDsQesqk0JeQFi8l/GYDoZbiIyWQMLNNACC/e2PHQUWCya6z/xrXy6bLVPWhSKi7LTOuRv0xnEIwqEVjguSwXkgIodkLPBqBJX5A+keSCnTORGkrjRDKKbachZ71bOwi9j2j88bDFJFZcGHkkL5vW+ag7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by MW3PR11MB4540.namprd11.prod.outlook.com (2603:10b6:303:56::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.19; Fri, 13 Sep
 2024 17:05:15 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%4]) with mapi id 15.20.7939.022; Fri, 13 Sep 2024
 17:05:15 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Askar Safin <safinaskar@zohomail.com>, linux-edac
	<linux-edac@vger.kernel.org>
Subject: RE: Is it true that uncorrectable ECC errors always crash the system?
 (I want this) It seems my system is unsupported in edac
Thread-Topic: Is it true that uncorrectable ECC errors always crash the
 system? (I want this) It seems my system is unsupported in edac
Thread-Index: AQHbBf0IfsDjaOehJkunsM6C1cGjurJV8Hdw
Date: Fri, 13 Sep 2024 17:05:15 +0000
Message-ID: <SJ1PR11MB60836E226A36DD482E284796FC652@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <191ec4abfe4.ee5cf21f77536.5289498031536692169@zohomail.com>
In-Reply-To: <191ec4abfe4.ee5cf21f77536.5289498031536692169@zohomail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|MW3PR11MB4540:EE_
x-ms-office365-filtering-correlation-id: f6aaa734-5f5c-4101-da33-08dcd4163cb8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eG1zVGtGV1VjRDcvcGZZTE5MZG9WZ3FqbUczZXI2N2x5a2JXcFhSSTc1TXc3?=
 =?utf-8?B?YTFDblpxdU1jVEo3cEM3ZUkxQzlzUnduUkNtd0d3YlJLMnRaWHJuQkRyMTJF?=
 =?utf-8?B?OFRuY1VtSnBjaUs0WWVZRWVDcGtLYTZOOGtoY2N5ZUloYzF0MlgyTERyNlJS?=
 =?utf-8?B?Z2V0clFleGNhRU1VKzMyOHJWZ2VkT05IaHpDWXF4eHYxRFVZQytYd0NoUEx6?=
 =?utf-8?B?NmdOT0pKQ01TNkVhYXVZdXBGbHNsQ3lMbFRSQklmYTdNU0tCbEY4OVdEMTF2?=
 =?utf-8?B?cHJORmtPaGc3bERCSm5NUTV4QjNqSHdkMnNIM3grMHBDTS94bWxLbGF2YXE4?=
 =?utf-8?B?N1YvR1pOVi9IZzJmVmtUOTByQ3dTZ2RtbERiV2huWFZQRjJCd1B2MUhtWmpi?=
 =?utf-8?B?WXk5dmN1bmZDd3o5ZHI5NlRhZk5KaDBiM3RWMXZsR0NSMmZLd0E4d2hrMWF2?=
 =?utf-8?B?d2R2SkR5M0JkYVNmVHVBU0lBL0ZuR2wrQTVWRGdmMFIvdEprVXd3aXpYVytk?=
 =?utf-8?B?SkdjOUZxYS8wT1Q0bkN5Z2ltRzdINW5VWE91YjhOVytQQ214TGZlSkRxZm5Y?=
 =?utf-8?B?QnkrTDFlNExQdDhBWUkzWVBPcWZaTExCdkJ3SFJrV25sSUowVGlvL1ZWWUhw?=
 =?utf-8?B?RXVPUlJ0UlF5UmRONjR0RWdESk95Qm11YmJqWHJrd1hXalg0SDZZcmFnVXhu?=
 =?utf-8?B?Znd3RmlJK1FKangxcmRmakVESW4xRnNTenRxeTkzckI0YmtyNE1SV05POFlC?=
 =?utf-8?B?NWErK1pPTkV6U3N0enFhaHQvMU9HR1pBY3JFNVhtT0FEWkpMb2lVeXQwZUVw?=
 =?utf-8?B?UUIzL0dtRmd4ZHFMd3hFZlgzVmluT3RXUXJnbG1aVzJxdnZMVC9pTld4aFpZ?=
 =?utf-8?B?d1pHNi9aYkNTeEpQR1JIQlNxd1NnN0U2VFVkMTlDYU9SZis5WkYveWdvTExJ?=
 =?utf-8?B?QjRXU0ZRUUFSaW9SUXhwdU52NEFzRjVCdytXU3htak0yRXltcy8waC9JWURj?=
 =?utf-8?B?OTh4YnlXWURLcU9VYlpTazFtWnlLZGk4UVBxaERPOGx0Z0VlR0M0WnhmL2hl?=
 =?utf-8?B?dGIydlRkcmgyaW9BVDZqL1UyZ1lTUkVlVEJrUzMxanR3eTJ6REFOQ2s3Skd4?=
 =?utf-8?B?Uk9zN2RTN2U1OXdsekpVc1NZazBnNzArWlA1UnY0K1dIRUI0NjJheWIxNFpr?=
 =?utf-8?B?SDM1TGFBUlpLWkQwZmwxZnFaNmVDY3MxK1hBL1VXZGkya2ZxMzBsZHhpZE5r?=
 =?utf-8?B?MW9hdXRoT1lMRE9TamxXUGlnaEJ4NXRoNVcrM3c4Mk8zWTBJRklVbUl3RzZw?=
 =?utf-8?B?bXdOZi9BNjdjTWdCU2YyWERmKzU0MjBxbFQvbzF0TzBiQm5RTVJxWkJsSkps?=
 =?utf-8?B?M25RTUdGdHg2cjZadkYzVnowczhRQTB6YUJZT2p3UXlKd3QwTkc0WUJOcFFx?=
 =?utf-8?B?Q0xlUDdydEVmOFd3N0JvRE9JR2Y5Y0xGeHAwU3h6WE40YmgzWWlKbkcxNDJZ?=
 =?utf-8?B?SFNIWWJWbk81MmlyRW9GMlVNWHZZUW9JM1BiVDFjTVBsejRKbEFKZlE5TW4z?=
 =?utf-8?B?Q0VqQmh2ODF6bmtUbUY0VEZwRjRDd3R0QjkzSEhXb3RmNkl0eDBaalVGSnBK?=
 =?utf-8?B?eU10MzdaTnVUVUxZMmVacndmUy9xZ1lEN1hJdFNHaEplUUNxZTNzTXhxR2lm?=
 =?utf-8?B?amRSVDFZU21xa08rVDBiQ2FUNnJmaGdhNVA2K1ExZ3ZoVWlKbWZ0aTRmeXJw?=
 =?utf-8?B?Y1VuRXBncGVwWTFGTk9LYzRNT3pwZ3l0eFYxWXM1STZXY1I2QzJwbUJlK2tN?=
 =?utf-8?B?VllVOFhZeXNuQlpnSXUrOFFiRzlHZERUL3dWSWZkT25SQmtONzRZc0M0RWh1?=
 =?utf-8?B?VERwMXE1NVFGY3duR0czRkpFa1RGeDYrWFRNeVYrR0g4VkE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZDgzcStubVMwV3lQczNKZkYxdU0zMStObGZqcGNLZVZqZWtZNjJFL2hWWGdZ?=
 =?utf-8?B?QjhmZThaeHRaZDBCaVVUQktPcmE0eHhabitaUkxDeWRPaWRzNGtpYmpLN0NE?=
 =?utf-8?B?MkEyUUQzRkNQL0RKTmVKS05Yb2dKSkFMRHVRNERQd1gwREQydXI5NDVtYStM?=
 =?utf-8?B?NW5kYmEvMkZwOVQweUU5UjRjMzE1TTRHaGtsMlpwOHRac0tGMWszWEJFMGcz?=
 =?utf-8?B?bVNQcEZWeXBhVUpYYkxyV2dES2piNDZTQ2V5OGVhK21PQWhnMjJsMnVrVEJz?=
 =?utf-8?B?U0ZCRytJOEt2Z0Yrd0R2eGFtcCtlWHZOVEM2dzhJaEVEYnJFaWpoSjFQUlNr?=
 =?utf-8?B?cHo3TXNhQTFoOFlvZGZJalZDWnczRVpVM1ZUb1RZRlV2czRuQWhYUTYrZzRx?=
 =?utf-8?B?dmQvbXZBZUJZVVN3OVNvT1hpUlRuZmp5bFA4MkZPUjRvb3ZNY3FaQ2w4TUox?=
 =?utf-8?B?Qjk2Sk8yNTI1dnpyZUJEZHFwSUZOa0xDUXQrWEwwN3V3Y2s5djVqeXgxMnQw?=
 =?utf-8?B?cExGN0owclo4M1NhSzJ1Nk40Mlk4Q3dvVjhFZGJDbG1sc3hmS2wrYVBtZHg0?=
 =?utf-8?B?NzdXT0Z3K1dQb3djMlViZ05QYjEvY29oWDNjL3M1QTBwWEQ1cnJ3eTVQZjFT?=
 =?utf-8?B?VVp2azlqd20yUjBTNEVSQmVHQVUzT05IUFdWOHdpN2lNSktZVFUvNGRhN2NL?=
 =?utf-8?B?dWNkK1h1MTdqVFVhd2tybDM2eXpSUWwrbnlFcXRRRi9oTzBNRGF6NmxqWE8y?=
 =?utf-8?B?cXBnSy9aYkVhR1BxRGtGQkEybHU2dlkybTRtWFhoa2hYVnkrNlBma2tsVHdq?=
 =?utf-8?B?V3JmNU03M1ZVTjRYWDIxZ3VWeDFWd1pabk9HMkEwMWhPQWFyeFFlZnpSOWJL?=
 =?utf-8?B?R296R0dOaFZCbWxQSHpaQ2dGWEIvcCsvOE1JbE5SUys2K2hRQjJ3YnNwQkFL?=
 =?utf-8?B?bzN6NXRvSEhEMG9TVUNFNnRqSEhiR09jVmhROWpvYWZkaEFISmIyY3FHZ3Ar?=
 =?utf-8?B?M3NaTExxMEVmOVpJSGJqV2puRlkydGtwRTVaaWpBL1VTVHlGVDFnd0dUYURT?=
 =?utf-8?B?c3ZaRmZIU2pBVzkvOG1BSUNRZjRoZGlMMEcyRnZWdDRWS1JySS9ldU4rNTc4?=
 =?utf-8?B?SEhUdnJrQTZINUt5aXBTWHE0OVFjd0RwVmRJOE1YRzFDcFN0QXFwUVZyNzdm?=
 =?utf-8?B?UmxETXdVZ3N0RW83WW9KWkdoWi95elI4RnYzdC83UWMzaUc0TzF3SGVKQjFV?=
 =?utf-8?B?aU9DQVNQa0RiNmZQc3JGM01WUlp6alJOcmd1V09sZSt4ZzVpdGIwZjZMTTFI?=
 =?utf-8?B?Q2R1YVJRNEtJZkhaZ0RXVzh1WkdCSU1PMWJ2QndnUGo1a2FCUFdzenlzaElu?=
 =?utf-8?B?K2VrYkFmV2lVL3MwMGk1SVJPV05kTG82QmlqcGhlZ1drenQ0NGdiSWwybFV6?=
 =?utf-8?B?NmRITk0wRWV6YWlIS3NJVitJQjlZMktQTGFhUm1nNmFCaGVNa2U1SEx5Y2Vm?=
 =?utf-8?B?UzFnNmlVNUNodFBBUWRKdk5GNCtXeFV4M3hWcmR3N0N3S3pwM0JCVHhlbWxk?=
 =?utf-8?B?OHYzbU9DNHlxcHFtaXJrUDBxbjhoOFZ1c1R2dHBRVWNHWGE5UElTWFJKemhn?=
 =?utf-8?B?TDVXVjNMT1NlQmlzblNLZWdWcmUwREE0MEx6Y0U2MnAwcFA0bG8rVThBRENS?=
 =?utf-8?B?RTArQWZvblFxajRxVEtiek01WUJEMk4xbmpLS1hkQlB0cm9TZlJVOTh0N1FD?=
 =?utf-8?B?dS9iZTVmRmNRZ3ZUWFZMTTBncUZpRjdYMVZEcmx2K3hjQlg5SHowSjhkbnVS?=
 =?utf-8?B?NVM0NnRRTU55NGFISjJwVzgxaEtJdlJUOTA4MFpST1d3Zm50OWhwRnZReDhv?=
 =?utf-8?B?YmZVRHpsTWJBR1M3bnVRUytVQWVxUDVQZkJNVWE2emZEampwTGt0THdFbEN4?=
 =?utf-8?B?Nlkvd2FuanRrQjF5UUVwSkJ3NG1YRHNJb1dURnB0NVdaTXBFTDQyOU1wWGx4?=
 =?utf-8?B?Q21vOWx6UkE4YUVVenJ0WUdNWDRiV0ptcGZEbDJQZDd0SlFrcnJNQ2dWd1dU?=
 =?utf-8?B?dEh6NmhodWJuT205U0ZmYTNVUWx4VVZnSFlFYTZSODZ6eWhWcVljTVE4MWtQ?=
 =?utf-8?Q?aIdTm9Z1hS4A2e4fCD1Y6R2TA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f6aaa734-5f5c-4101-da33-08dcd4163cb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2024 17:05:15.2274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8VlWbZTSIR5SwlhTpCWuuUG61bsQOMu/yFvJvKXmF44cUvKoNY04P3mjudNJ013G3GG2ahCMYdAu5zj9Oz/k0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4540
X-OriginatorOrg: intel.com

PiBIaS4gSSBqdXN0IGJvdWdodCBEZWxsIFByZWNpc2lvbiA3NzgwIHdpdGggRUNDIFJBTS4gV2hl
biBJIHJ1biAiZWRhYy11dGlsIiwgSSBzZWUgIk5vIG1lbW9yeSBjb250cm9sbGVyIGRhdGEgZm91
bmQiLg0KPg0KPiBTbyBpdCBzZWVtcyBMaW51eCBkb2Vzbid0IHN1cHBvcnQgdGhpcyBFQ0MuDQo+
DQo+IElzIHRydWUgdGhhdCBFQ0Mgc3RpbGwgd29ya3M/IElzIGl0IHRydWUgdGhhdCBteSBzeXN0
ZW0gc3RpbGwgd2lsbCBjcmFzaCBpbiBjYXNlIG9mIHVuY29ycmVjdGFibGUgZXJyb3I/IE9mIGNv
dXJzZSwgSSB3YW50IHRoaXMuIEkgd2FudCBjcmFzaCBpbiBjYXNlIG9mIHVuY29ycmVjdGFibGUg
ZXJyb3IsIGJlY2F1c2UgY3Jhc2ggaXMgYmV0dGVyIHRoYW4gc2lsZW50IGRhdGEgY29ycnVwdGlv
bi4gU28sIGRvIEkgaGF2ZSBndWFyYW50ZWUgdGhhdCBjcmFzaCB3aWxsIGhhcHBlbiBpbiBjYXNl
IG9mIHVuY29ycmVjdGFibGUgZXJyb3I/DQo+DQo+IEFsc28sIHdoZW4gSSBib290IExpbnV4IDYu
MTAsIEkgc2VlICJSQVM6IENvcnJlY3RhYmxlIEVycm9ycyBjb2xsZWN0b3IgaW5pdGlhbGl6ZWQi
LiBCdXQgd2hlbiBJIGJvb3QgTGludXggNi4xLCBJIGRvbid0IHNlZSBzdWNoIG1lc3NhZ2UuIERv
ZXMgdGhpcyBtZWFuIHRoYXQgSSdtIGxlc3Mgc2FmZSBvbiA2LjE/DQoNCkVEQUMgZHJpdmVycyBv
biBMaW51eCByZXBvcnQgZXh0cmEgaW5mb3JtYXRpb24gd2hlbiBtZW1vcnkgZXJyb3JzIGhhcHBl
biAod2hpY2ggRElNTSB3YXMgdGhlIHNvdXJjZSkuDQpUaGV5IGRvbid0IGFmZmVjdCBob3cgdGhl
IGhhcmR3YXJlIGlzIGRldGVjdGluZyBhbmQgcGVyaGFwcyBjb3JyZWN0aW5nIG1lbW9yeSBlcnJv
cnMuDQoNCkknbSBub3Qgc3VyZSB3aGljaCBtb2RlbCBwcm9jZXNzb3IgaXMgaW4geW91ciA3Nzgw
IHN5c3RlbS4gIlhlb24iIENQVXMgb2Z0ZW4gc3VwcG9ydCByZWNvdmVyeSBmcm9tIHVuY29ycmVj
dGVkIG1lbW9yeSBlcnJvcnMuDQoiQ29yZSIgQ1BVcyB3aXRoIEVDQyBqdXN0IGNvcnJlY3Qgc2lu
Z2xlIGJpdCBlcnJvcnMgYW5kIGNyYXNoIG9uIHVuY29ycmVjdGVkIGVycm9ycy4NCg0KLVRvbnkN
Cg==

