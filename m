Return-Path: <linux-edac+bounces-1383-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B0891896A
	for <lists+linux-edac@lfdr.de>; Wed, 26 Jun 2024 19:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 842971F21263
	for <lists+linux-edac@lfdr.de>; Wed, 26 Jun 2024 17:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB09218FDAD;
	Wed, 26 Jun 2024 17:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XknplF+0"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7E318FDA2;
	Wed, 26 Jun 2024 17:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719421901; cv=fail; b=H4qkj4kKiH7jctMadOJzM4w3rntUK5vHucnAZczGWcgy6pshfXv7nlesSVweybGIrFhv5omorsV9uLYGdlrx1m7ct377doTSoShj9wO5fBgtuz8RhrIW/BBZ8p6k7V7hrrA/7Et0DpyuJUIZyjceMt44Pk2UssFxGMqy2fdGJ4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719421901; c=relaxed/simple;
	bh=pSBhb4nZkJEbhtxxRjb9fFe0Z9ndbEIjzZQLxZUv3yE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rFRPb/hmQIOt6HQrokKcVyjBwbAY57rxuHiRPEmyf/e9AHNIhen7CrFUqc46roPIb6NV8H7fnYvH6L8FtOmgiG/bQ+/73nbzAY81KPjn0SpSMZuXYf5isa4jvpZM4bC+jyj9FzpFfRkEi6MNgfsW9JJra/Gj8VcBwWjDzeByISE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XknplF+0; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719421900; x=1750957900;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pSBhb4nZkJEbhtxxRjb9fFe0Z9ndbEIjzZQLxZUv3yE=;
  b=XknplF+0u8yNGFracetbBuWq94ar2VvtvMO+W1ezET+2L1QyqoqxJXga
   lK4Xy7Kav08D2PHzgNbKYNnrwCRr0/pIIzLrXGcvyhjOYnwauf3n3nlyt
   n/Zg2cPW6p1DfQX0ElXQdV82uupquG/Xvm1QlolWQe9XaVYTk5ueuMno0
   Qjp1iqxDVSmm4ckQjYBcO5Nliyr5MiWukiDiScP0sIdhQE/Y6iM4dHIPf
   RMp3hkfERUYw1OaAKBKfOQbW8rfSP3yQFaHeGIcdkrnr+PWKd3mfR9+GW
   PNONfUnW8gThS0CdYlksW+t/dlcZVDGGlqwi+3P7g76Fs7Sy+LaUa/1+6
   g==;
X-CSE-ConnectionGUID: MIXy7TnDQpubNIKowuiOrQ==
X-CSE-MsgGUID: RPVSdng1Q5aSNr2LFkGaOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="27194718"
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; 
   d="scan'208";a="27194718"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 10:11:38 -0700
X-CSE-ConnectionGUID: BH1Z6aMwR6+GZ1PcdvYiqQ==
X-CSE-MsgGUID: kLkozzvpSw2MhroOsd1+QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; 
   d="scan'208";a="49037594"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Jun 2024 10:11:33 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 26 Jun 2024 10:11:32 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 26 Jun 2024 10:11:32 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 26 Jun 2024 10:11:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JPvZfuyrMHkkK9GwQg49w9yl9jbQt7uiL+R5S7w38bPq1VPcfPcdGt0g7P1FUJxRAVfkg+aYKK4b2LYzGNDfrGU33zKPLlSsK86BAHYPnD9tRqGzDDhxi8gnAuTLBKhJQfLeSh5TW6x6vcHog6lOIwLWf7TFbV5zjyXcr9jPaKGXdsban2NHS5MnI4FxH5T/hY2eNdt03mj/k2EC+rz6HWwsXTq+Mgv8TuEhdWUIpBmJGAtHJXS+PqcafeHDVYoMdq8BpwXDZvOmSztr8+Cpb+Zj1K2K53uvJTQxt3iEbqdeDfkSwec9UdHCc0H95j8DW0O9RvwWIPF8o/Ni/k3Uhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pSBhb4nZkJEbhtxxRjb9fFe0Z9ndbEIjzZQLxZUv3yE=;
 b=n5lhsk1oGO0HR3GrufWlUTF5Ew2jd5I+xmAhB8IJioVTqO5NL2KjrSvHke1i+RSVgyQAEFTsegh3Ui+QCgd8dN29zzAZ0wg5G3uyBs7/ehEQ0xwnwvSmaMnWo590IFCzQ+fPpKfybUXnjL5MNP4N2xJCOUOOPPM+DJPNWf0gqlmYacRnNW6C3W7zcfqySK+4KKZhJTR1T+9ftX56/WcZXOuMDxqx9prb3000gXtj6QZA2U0mmrRzDgtuKTYsXvepCkhlwyzZqlN/3y3f86N6dS3UZZVT4farT5Z2lEzGYx4p+gakOtdFzGzrNe5SbzP70P4O8emA7XcbA5t7aHXWMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DS0PR11MB6517.namprd11.prod.outlook.com (2603:10b6:8:d3::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.32; Wed, 26 Jun 2024 17:11:29 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%5]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 17:11:29 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
CC: Avadhut Naik <avadhut.naik@amd.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"rafael@kernel.org" <rafael@kernel.org>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, "lenb@kernel.org"
	<lenb@kernel.org>, "mchehab@kernel.org" <mchehab@kernel.org>,
	"james.morse@arm.com" <james.morse@arm.com>, "airlied@gmail.com"
	<airlied@gmail.com>, "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
	"john.allen@amd.com" <john.allen@amd.com>, "avadnaik@amd.com"
	<avadnaik@amd.com>
Subject: RE: [PATCH v2 1/4] x86/mce: Add wrapper for struct mce to export
 vendor specific info
Thread-Topic: [PATCH v2 1/4] x86/mce: Add wrapper for struct mce to export
 vendor specific info
Thread-Index: AQHaxznXxbgnHKUXckeoL7fhByc4nLHZ3S6AgABqGzA=
Date: Wed, 26 Jun 2024 17:11:29 +0000
Message-ID: <SJ1PR11MB608351F8BF89ECCAF08831A6FCD62@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240625195624.2565741-1-avadhut.naik@amd.com>
 <20240625195624.2565741-2-avadhut.naik@amd.com>
 <20240626104427.GNZnvxC1JHclKwwKQU@fat_crate.local>
In-Reply-To: <20240626104427.GNZnvxC1JHclKwwKQU@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DS0PR11MB6517:EE_
x-ms-office365-filtering-correlation-id: 649110d2-38f6-4ee6-95a7-08dc960304e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230038|366014|376012|7416012|1800799022|38070700016;
x-microsoft-antispam-message-info: =?utf-8?B?Sk1pc0s0L2ErWkFyN2lJaXI5SUlIb0VmRllXY1l2eThEWUtCTS8yWFRNaTQ5?=
 =?utf-8?B?bGlLeVpBOCtRaVl5cVlMZERlVk5iU1VwMGtQRnRxZVFDNTh2NUZ4WHlFR2ti?=
 =?utf-8?B?UXNnLzF0aW9yNDB6TWtQdWpieFhhaXhLVjN1Y3RpUDgwSndyNzFaQS9BNmpQ?=
 =?utf-8?B?K3ZzMUREeFFpRlhpNWxyQmZKU0wxU2NqWUd2UnRnRUhaZTZ4LzV6QkZNK1dq?=
 =?utf-8?B?ekUvdEVTV1ZxeUMyUGVlSUV1dE1WcG1FWTJHR3lqNzNzbVhJVXEyWVlXbGRK?=
 =?utf-8?B?bmM3Q2JpU09YL2ZrNmVhcDZXQlp5Zk5zNmtYOFVab0NKd0JUdTdiZ0tiNmRL?=
 =?utf-8?B?QjFsTm9oQ1Q1clFKVG8zWlJ0aGQrOVZqQ2RONVR1Nnh6dWxCU05oSWdKOVlF?=
 =?utf-8?B?RXltY2wvZUVDdFE0b0E2aWQ5UmI5UWRpKzd5S3AxNXNvSVJReW5LK3MzeG1H?=
 =?utf-8?B?MkVOUUliQnRvckIwMU1JRGpiNmNUZXRqU1ZwN3pVTDlHeEVNaEZZVUFyQXdD?=
 =?utf-8?B?aW9YcnNsM0RtZlJtbktmbHBQZnVxUGwxSUNIL2xBK21rdnNKQ0tYU3ZiUG9n?=
 =?utf-8?B?WldIRDB3MXhWUGhQVFN1MUtkczl4RlFJcXNtWjZlL2xISlV2VGY4UmJNTndE?=
 =?utf-8?B?MldsQ2dtbTh5b1pnM3BFUFI5bFJrekV5UWVLOXFnZ1M2ZmpONnErM1YrekRu?=
 =?utf-8?B?VlpHMXArTk1UUldBcFFHZjViMW8rdk9rVnZ4S0NINjE4akorbXFLUk9MR2Nm?=
 =?utf-8?B?Z0ZvQ29XZkkwN3FOd0NYMHJKV2QwY0p3UTVnaTM1ZFdPeXlpQlYrMUxyU0Uz?=
 =?utf-8?B?REVLZVdJay9BeXc4aXFtMDBjUmdmNVY0dm9hSVgwV2dSSWRQQ3hyenRrZG42?=
 =?utf-8?B?VG5TLzkxcGhHWWlZd0lQR2g1WjJMOVp5alFWS2E5S3AwR25yZFJxSForcHZn?=
 =?utf-8?B?dWRmVmpYWTQ3YW51L0R4ZmJYMkRnbGUxR3RUOEI2Y2o5aFBJYVUrWnBtNElM?=
 =?utf-8?B?eE5udGxXTHJOSDZrMDRhamJuU2lNeDI5UlYvUVRLZVFIdHVZUVdkNEF1TUQ5?=
 =?utf-8?B?NXhkSndXZGl0a0lBWUd0U2xrZHBPa2p4Q1NjWk53KzVWWE9mdmcxOGM3K29L?=
 =?utf-8?B?bExpV2psZkwyaUpHaE9SaGpob3AvV1Zobk1QbzlDbzVrL0o3cWFTRGxRRUtW?=
 =?utf-8?B?QjJBOUdPZFRPNlBIS25tYVBPcit6MmhEZHJad09rQnM2NHhKZTZ3cjZHQjFr?=
 =?utf-8?B?WnA2QW9jcFRnSms0U01zbS9HN1ZzRVg0bURLYVRUUXorL3VtWnVmZEM4cTdj?=
 =?utf-8?B?bGVtTUpNKytGaHVrWjZqRE1keUVKUUtCT0IyeHhlTXNrTDRMbG56clpmVm5Z?=
 =?utf-8?B?cnNiK25jdE1Hb2xja1g3bGIySEozanZEMUFiU3FFbENWYjM4ZzZxSE9KTEtC?=
 =?utf-8?B?dFY2TGIwUU1CdWt4UlFsc3hOMUMvbHpqdm1PNTFHa3dTMVVFUlYrOTVoRVdr?=
 =?utf-8?B?cXdNVVkwN2ZIQzlkSGZCQjQyWmhkRnloZWFhWXIza3N5MWlDZkpIa3BkbDl4?=
 =?utf-8?B?SkUxR1JWU2hEd2wyOWZRaGNOTjFTRzl0TUM3ZERJbFFlQXpNUmlaeUpGdlA4?=
 =?utf-8?B?eEZSeTVhL2RQdWJvNTRSU0ZUQzNIUzhzVzFWckFMZS92bVV4TFJLd2VMWmk4?=
 =?utf-8?B?Wll5VWVMVmdkd0R0SzRwVm02d3orcVg4cW1NcE82cFMwUE9TWTdUZmNRTWhz?=
 =?utf-8?B?dEdTRWJ0WkUxUDFuckloYm43UTZLYnFpdDN6anhxMXRFSmphMEw1a2F2Z2dk?=
 =?utf-8?Q?YvNAqUHXBqjJKBShkxWZvokkkcQiVXLd9SoX4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(7416012)(1800799022)(38070700016);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TlAwL3FiU0IzTEltK2ZHSVNGazN4a0xWUDdiR0I5cDNsbCsycm5ZWlVtTitp?=
 =?utf-8?B?RjlwQ1hMdUJGTm92cExLVkovdERpQjlHY05KU0s1ejJjdzh2TDBzTnplS29p?=
 =?utf-8?B?d0JZRGR4U2FOT2lmOVptZ2RuL1FhSGVBZC9CemFqYTlRZzZvVmxnWTF0TS9D?=
 =?utf-8?B?dHRrZFc2a1ZEakRoRGRDdzAxN3RPTWhDRnFGZnhzdzVNaE5QY1VZdEVjRGFi?=
 =?utf-8?B?bW1FWmY0bE5tSWxFNFF0blprenI5dGM1MjNDa1JmMkFVSk1hc1VyUFRYTGV5?=
 =?utf-8?B?b3RtNGtWOTFYMHFBS0dyeU56VFRYMXhzODlMUlVSWG5yeEZ6T0U4VjNoV2ZF?=
 =?utf-8?B?bXFLTWljSFVCU25Ybm9xRk4vd01XOGh3M0VVQ1lwYU5wRE5KTVNSdEYxT2NK?=
 =?utf-8?B?elZ3RXYrbWRvY2NlU0JPMkZrM2htUThyRXJtRXgzazVWTWNWT2l0aVErRXh0?=
 =?utf-8?B?bmNpL1NNN1JWWkZjUnQ5dVJUM0syMzh2cW5EaFFSbkViSWM5emF0V0h4WWJl?=
 =?utf-8?B?RkU0TE9NY0gxcnU0T0xtSFo2bVNQTUIvbStyZTRpaGU4TjdMMHRuK1V2R29j?=
 =?utf-8?B?ODBpWnZrKysvQ25QZ2x6bVVTd0Y4T0lUNGYvSHBOeEJCOGZjMUIvZm5tN0k0?=
 =?utf-8?B?YnArWmMxNlppdUVJcVhFYnptaXEwUjJya1o5bnhwQjNycmQyOEdkcEhXNVQv?=
 =?utf-8?B?WnBpb0lNbjFtQk1oU08zMjhZQ280OXJIMFQyODdMRUpwMFFZbm10S0phdWEv?=
 =?utf-8?B?VzZnQ1JzbEwxRE5mS0pSMWNxdGEvcjdvVytkcS9HcWJDMFc3NUloZ2FCMFJZ?=
 =?utf-8?B?WTVLcUFyeGdhcnVFSTdTbS9rb3FGWFBJQ0F6aGI3YlBiZ0tnb3haWFJ5V2pJ?=
 =?utf-8?B?TGg1Zkl6RHFYQ2ZnUTdUN082WWVibWl0eDhBK0pzbkcyNTN2dllEd3lncytp?=
 =?utf-8?B?OUVjdXRrS1dIWVF0WnQ2NVBnT1c0N0JYdUs1UWJjdkRCQTRGckxYUG5ibHRE?=
 =?utf-8?B?ME5iQmFDcGtKS29pdlN6T2lVZk5xRkltbkxsZTZwTHE5d2xBeDR5eWhSV0ZK?=
 =?utf-8?B?TEpvRk1XU2lCUTNVejJjZmd1b0UrZ3puS0FxRjhESWpqcEJBNWZKekV0SVhi?=
 =?utf-8?B?MmNsN1I3bHJCVStmNXZFc0dCYU9xdW5JenBIdjNKT215U2ZiZ21VS2R0ZnM4?=
 =?utf-8?B?eDFLNkFzNEt5MjhEbkhFTzE3OGE1eDZuZUtMcUYrTUhLNldsZ05qaHg2ZTNV?=
 =?utf-8?B?NVJmOE1vc0hrT21lVzJVYzZISHJDUG80MFV3Y3N3d1U4bzloczhJNS9LZzVT?=
 =?utf-8?B?QnBOUzVUTWpoUm9NN2hDWnIrUERpNnpkanNCa3REWXVjWWlQNnVHTlJ1RVlo?=
 =?utf-8?B?dGhYRmNndFBzL2VCdGxDTlJCZGx0NmZtaFo0WkNDelJ2bnhVRXRoOEtNOFBq?=
 =?utf-8?B?ckR2cWMvVFI1S2kwRnE1VnRRbVl4ZWNtUWxpR2kzWWdoNFVLOHYvTDVMd0hP?=
 =?utf-8?B?UEoyOXFvYzY1OUQrTlRxQmgveFZsNTJieWJsN3BPeG52K2dSTFBPY3VHdkYr?=
 =?utf-8?B?MXBwUHFRZjR4Vkl1a2xNcjVDMlBTdlZXS0VGc1NQVGdKTWcyY0V3Z0Vqd3gz?=
 =?utf-8?B?ck14Tnp0UWxLc3E4ZFVhSWJXU3QrM2Z1NWZzKytML3hHYlVQNVJ2bFpjTFpW?=
 =?utf-8?B?RTdyVDFJYnY4ZkgvUkxWRVByT0JvOGFrTXBiWExsNCtkQzFmWGVwcTV1TmpS?=
 =?utf-8?B?QXVJaHV0dHZTWlpTc2lFcjFMNmdiTHNmNlUxOGx2OENKVkcwNzBuem5OSkVC?=
 =?utf-8?B?elhzYzNhdUZ4TUhPZzhCWk5xN24yY1lncHkrdGRGYnU3RVFySFJRK1M0b0tl?=
 =?utf-8?B?WlVHYXRvK0ZKVE5BMHk0QnlQeTJ6WitUZU94U1VQT2dxdVJzZWtBSE5Rd1Iy?=
 =?utf-8?B?ckZ6eHpseUZjVzBBR3UrWUVZMDZMQkJaeFpHVlpDWVQ3ZnZJRkVsUmhEVWdj?=
 =?utf-8?B?Ym1Rc2duWThXZ0pydWQyRTM4MEthbzRsVTN1cXFJMERsVk1jbXZhcy85V21X?=
 =?utf-8?B?VlYwNzM3dHFDWUJBWW5nUm9OdUxYMlQ2ZExQT2tRME1sanpOMGx4SkxySGxV?=
 =?utf-8?Q?JS2THhchCwOJciB4rXnauCkuZ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 649110d2-38f6-4ee6-95a7-08dc960304e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2024 17:11:29.0933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QYjrgMHGRhwHISzyIzohlN6xJzxzvRdiMnh7uaX8y2allsHWnWWjCE7VFXK3POPlnDjzB4KR4dS51vRKTPKL4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6517
X-OriginatorOrg: intel.com

PiBUb255LCBhbnkgY29tbWVudHM/IFlvdSBvayB3aXRoIHRoaXMsIHdvdWxkIHRoYXQgZml0IGFu
eSBJbnRlbC1zcGVjaWZpYyB2ZW5kb3INCj4gZmllbGRzIHRvbyBvciBkbyB5b3UgbmVlZCBzb21l
IGFkZGl0aW9uYWwgSW50ZWwtc3BlY2lmaWMgY2hhbmdlcz8NCg0KSXQgbG9va3MgZWFzeSBlbm91
Z2ggdG8gYWRkIGFueSBJbnRlbCBzcGVjaWZpYyBiaXRzIHRvIHRoZSB1bmlvbiBsYXRlci4NCg0K
SXMgdGhlcmUgYW55d2F5IHRoYXQgdGhlIHRyYWNlIGV2ZW50IGNvdWxkIGJlICJzbWFydGVyIiBh
Ym91dCB3aGF0IHZlbmRvciBzcGVjaWZpYw0KaW5mb3JtYXRpb24gdG8gaW5jbHVkZSBiYXNlZCBv
biBib290X2NwdV9kYXRhLng4Nl92ZW5kb3I/IEFzIGN1cnJlbnRseSB3cml0dGVuDQpJbnRlbCBz
eXN0ZW1zIGFyZSBnb2luZyB0byBzZWUgMyp1NjQgZGVjb2RlZCBpbnRvIGFzY2lpLCB0aGF0IGFy
ZSBhbGwgemVyby4gTm90IGENCmh1Z2UgZGVhbCwgSSB0aGluayBpdCB3aWxsIGp1c3QgbG9vayBs
aWtlICIweDAsMHgwLDB4MCINCg0KLVRvbnkNCg==

