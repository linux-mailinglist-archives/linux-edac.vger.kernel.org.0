Return-Path: <linux-edac+bounces-3174-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F07EA3E30B
	for <lists+linux-edac@lfdr.de>; Thu, 20 Feb 2025 18:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF0351896816
	for <lists+linux-edac@lfdr.de>; Thu, 20 Feb 2025 17:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31156213E6B;
	Thu, 20 Feb 2025 17:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IHUhwUvP"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4982B9AA;
	Thu, 20 Feb 2025 17:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740073863; cv=fail; b=tKxZo9WVhIenYI+ghCAP4QxqaQ2iDzX+yBQtc8zamGdALXA/PVNuItxbeydiQUBqVJp0r4/UyptKQCULG2yHxzxwQw0fS4RqYh5MeCwgm7C3N6mtZwRWW8kPhRFuxykgUWpR9AyQI34qekeVHzWhq3Pa+JChVIxoXXfd6RQ4MnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740073863; c=relaxed/simple;
	bh=GhG3lbkbOdm/PnP9wI3VQC87w/uR8yuKPE8tAxLzhtg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jb8Eltl/gS2AVVsA57qnmPuxbwT5ECEW7r4d71mqPQxGyLsoV7oumkZxvsM7BdLBXhvxVVgyZwRoqY35o5y77zRncHuBTcFwsyQG5GxXtN/8LR/3KjFqBml+/1xwpucfbAHIS6G5Y/AYPJ7u6nMpoj27i47R41KKXsZxfbaIa68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IHUhwUvP; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740073861; x=1771609861;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GhG3lbkbOdm/PnP9wI3VQC87w/uR8yuKPE8tAxLzhtg=;
  b=IHUhwUvPXBfobayTbY3N/ePkrNhsErMnS+ZxNOf7YZekwgKoer6p0Q8J
   urzxcdoe35dE0Yr97xm32jjJ2aGGfSqjvEXuBV8DBNGYG+cLfatTOp/7q
   r3fB2IlpAaKNr1s2tRA5dMSWCmvZ3KhTDwLnT/Rx0fA2zWJt2wKi64bB5
   GO0rtrBXcnbVtEwn5MpHzkcZhkhzVzZmreJ6YFEKVYKMLqftI6RMt2wWS
   53DfKOuHHMxbpS3goA1zxMG5X8YFXMlrVFWJJ7ruz0MZLGWpA+mwSPIu9
   cPxDMqpYRXrpfUYloUSChffLlvKNPFEoGtJFmtBts7w65GVJJokoIrUUE
   Q==;
X-CSE-ConnectionGUID: xqcSUAdtS1uVPdB0eeFfdQ==
X-CSE-MsgGUID: EJai6yYjR7exXZoqbx/aQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="40103144"
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="40103144"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 09:51:00 -0800
X-CSE-ConnectionGUID: Yj/R8xFlTICDUjedYMfJag==
X-CSE-MsgGUID: LXdEW+KySKeaJ+ICpnDjqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="138328862"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 09:51:00 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 20 Feb 2025 09:50:59 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Feb 2025 09:50:59 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Feb 2025 09:50:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eMC1bjiD2v2BAXPvtM7h3uAUgCKvgGIXv45M8yU4VpLU60riHTYa4mCLqsmyNrX9vxY6US/E5hm4a7xs7uYSIYVzVasbmmDseF5Gwc2LSlEfwYJC7nrVSx3Bq8udaT4ktTbW7pnYqrJqGX77NOBtb+Dyeu8Bh7N8c+ho2svfBHKu9tiGOtNFx3ezXK1ccdTmCuZ33wtTXXaydd2Vdlrs82ZqBZ6LrUtY117K47rY6XgeX7sArbdfUITZWjd1GgAdb4Xptyy553nJNpLaf/iI2zY8lHJ6RvtVSKhTKqrP6s1FTcwRJdFCbGv/zg9yeUnnoRA8ufT5z4auHwOClgUgfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GhG3lbkbOdm/PnP9wI3VQC87w/uR8yuKPE8tAxLzhtg=;
 b=AxsWCGJObrJfggTivd2rDhPFcPZcy/WkMWKQiFAC0q0fFquLWSD19u34wyfgW8aTESBtEUmypIcN2b53G4dpP3wJ5Yzw5eShcFdlEIcfiNkrOm11EwqISJS1vBQLrWOOyOWhj6v00RQo5jQJnph1d4r5p0FKjILkE8c2gdMAoO/ugznllNUgYkse+qqWcy+7ms5zM/8mnIWKxCRn/4AEdq1MlMaI/Yua3cH9Bx5Jqucz13t+yaQu6BDOGXxKI6JupdcSia1zqP0y+MO1KKr1EfSZyYWzqfoqBi8xOCWVRc6FpF9NM/nu7kSG++rIUqM3vqRyi2W+AYGAio38/GFkVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by BL4PR11MB8823.namprd11.prod.outlook.com (2603:10b6:208:5a6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.20; Thu, 20 Feb
 2025 17:50:14 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 17:50:14 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
CC: Shuai Xue <xueshuai@linux.alibaba.com>, "nao.horiguchi@gmail.com"
	<nao.horiguchi@gmail.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "linmiaohe@huawei.com"
	<linmiaohe@huawei.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "peterz@infradead.org" <peterz@infradead.org>,
	"jpoimboe@kernel.org" <jpoimboe@kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
	"tianruidong@linux.alibaba.com" <tianruidong@linux.alibaba.com>
Subject: RE: [PATCH v2 0/5] mm/hwpoison: Fix regressions in memory failure
 handling
Thread-Topic: [PATCH v2 0/5] mm/hwpoison: Fix regressions in memory failure
 handling
Thread-Index: AQHbgQXsd1SPCL4WjEygZkFauCaLrLNMu9aAgAAzcQCAAA67gIAATn3wgAD8+ICAAJGUUIABNWeAgABptcA=
Date: Thu, 20 Feb 2025 17:50:14 +0000
Message-ID: <SJ1PR11MB608335ACA7AEC51F7F6A75D2FCC42@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20250217063335.22257-1-xueshuai@linux.alibaba.com>
 <20250218082727.GCZ7REb7OG6NTAY-V-@fat_crate.local>
 <7393bcfb-fe94-4967-b664-f32da19ae5f9@linux.alibaba.com>
 <20250218122417.GHZ7R78fPm32jKYUlx@fat_crate.local>
 <SJ1PR11MB60836781C4CE26C4B43AFF0BFCFA2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20250219081037.GAZ7WR_YmRtRvN_LKA@fat_crate.local>
 <SJ1PR11MB6083F7AC9C5AED072141B8CAFCC52@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20250220111903.GDZ7cPp1qVq3t9Jgs6@fat_crate.local>
In-Reply-To: <20250220111903.GDZ7cPp1qVq3t9Jgs6@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|BL4PR11MB8823:EE_
x-ms-office365-filtering-correlation-id: f31f7ca9-b8d6-41a3-a5dc-08dd51d7076c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MGV3YjFHTkkzZ0gwTWRkQ2FCZ1h4ZCthR2NlSWQvRWdpelpLS05xaW1ldWFz?=
 =?utf-8?B?azAyQ3E0ODZXbE4yeG5aTDhuRzFCQjlIREJ6K3FHMlhtNFJFcE1LTFJzZ1VZ?=
 =?utf-8?B?UHF5Y0l1U25LYkVOcDNLQVU5MC9xSExXRjlhV1NQd0dIZjV3aVRDQk9xY0xy?=
 =?utf-8?B?VmdKaXRaV0t4Wm1nVzNXMFVCTUd6dHQ0Mk1MSVBjNVhNSXZTU1Uwdmc4Mzly?=
 =?utf-8?B?SStMTHZ4dGlCZHMvN0VnMDJGa1dnMnFlYlV4L3Y5SkZTdU1NbzJwWWpWc3R5?=
 =?utf-8?B?S2hLeDVPbEdQT3JHbWpEWTNhWTg1RVVMdm5lb0hwRzlEY215VGMrMmljbDFT?=
 =?utf-8?B?NkJ6c01PcWt6Rmt1Q1REeWt2cmtUUmtHWnJBMDA0dUl0eUtPYnVSSEtLVldl?=
 =?utf-8?B?NmFpOEMzQ2svR3dOckVPWUlUc2U5anBwTDY4MHZ4Mm1rRmJ2RFUyUkhUSXBD?=
 =?utf-8?B?V0VaWGdsanJnTG5LblBqaFkzTm5zNVk4L21kUFJGYUtPUjdBUEtqMmVCTWQr?=
 =?utf-8?B?Z1ppaFZ1cmxwUjdRR1oyamlBbjRvVkRoSDgva0hKZVN2ZGlpTGRGVmNNOEM0?=
 =?utf-8?B?SWR1ZWdhQmpYL09vREV2a0RHOW9vTmJVa0s5UkdWRWhKYWhXdkJVVWZRWkls?=
 =?utf-8?B?TjE2Z052QmlDaS9zdFdVb2l0MlFyd3BKNlJMR1hUUS9FU0dzTFAzT3h0ekVm?=
 =?utf-8?B?Tjk5NkV6WkMzYkhkSXRvUllQQ0NPbFQ4aFIwdkIrbDNYN08wQlJGOEpmOVRL?=
 =?utf-8?B?UndXR3ZKVjYzL1ljQ2I0U3k3SWFVVDNtS2hhandCbE1qQjVtWkVqVzBzaEkx?=
 =?utf-8?B?V1NIdGRMendZRThsTWgxYkpFWkpzRUQ1R1VPd0FPVy9nS0FvWUxhR3hIdE5R?=
 =?utf-8?B?akVSME1pR3BvOGxqeTk1Y1VwWXg0Z1o2UitoNVJYWWlyeE11R0lLcGVsMFkv?=
 =?utf-8?B?dUJGNWE3MmlSYXlQakpUMzFVT3U2WDFTYmNhbG15RFNZa01GQ3l1STRUL3R4?=
 =?utf-8?B?MVZWQ2NSZHZNMDEzejU4UVRVY0tpSFZxYXk0Z1dzeHlXaHZtL3ZzWUdtNVJI?=
 =?utf-8?B?dDk3dE53UXM2cVZKWGM2ZmxVNlZCU0NFSGxRc2E3b0x4SGdkaUo4SEhrL3FV?=
 =?utf-8?B?SEhLUlFXZ3k1QTRtR1VvbmRYMU9sSUhlbU5RRElPVkt4UVI4N0MwaFdkenBm?=
 =?utf-8?B?L1FHUmRxT3lGcGpXbmR0QUw4SFZPSGQvZkZmQ0Jvc1J4K0pLeTNIRVNrZGI5?=
 =?utf-8?B?eUpIN0wrYXN4dllhby8zTXZnMG5BaFp5UTJEM3V6UFFIU2tOaVFNYUx6UmZM?=
 =?utf-8?B?dEg4Z05HdUtxdGhodWRnZGdOcHJTdVI2emYrWEY4dFljZ0V4NmZjemtUaGps?=
 =?utf-8?B?NE9xaUdzeS9OWUpSeTBpY3p4MThMajM3dE5kNTJOKzZxNXFSKzFkN0dzNWtQ?=
 =?utf-8?B?TzFCTHM5UURudERWaTZ4TkV2NlI1Y0FhY0VTNzdqWTk3TEwzQ2x5YjRQWGtB?=
 =?utf-8?B?TGV2VSsxN0hyWklBejJwd1dJbmRaTkxzYkNSMElGWDNQNzdFREhjWjFWRi9D?=
 =?utf-8?B?a3dXUWN3SDNOSHliREc2aDBpYXF2dlN2ajZ0T2ZjYlNDNHE4OVhzS2l4Y2Vp?=
 =?utf-8?B?K25yZlFrL2svMTFaSWhObFF1UVRURTAwdGsvdCtJZXNSQVFVN090ZGVRcHBZ?=
 =?utf-8?B?WURCbjZxU0s5WldkNkVWNG0vbVVEc0RMZnpFNng4QmdyWEZyVW5yYkRhRCs4?=
 =?utf-8?B?ZDcyRTFkOFRINXpqUkVoZVg0YlkwaXlBbTFyMTJLeTNHZVY2cGh5RS9FUHBH?=
 =?utf-8?B?TWNKZmFseE96T2NwczNUYTRacDJtSVBkRU41MGQ1TTgxSU91dVlSeHRHbHNs?=
 =?utf-8?B?YWtLb2d2ZFJFNTJmeHU3VUw0SnVsN09RbFc4SzdiZklocWx0V0RrVit4OGxV?=
 =?utf-8?Q?YmWTVXffPkyzL5t+Rb+NZEfjhnPCYQHA?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWs4M2JrcnRreTg5OWpFN0YrOVRnbXdseDYvU2djQ05vR0NDK1RDbGlQTWRt?=
 =?utf-8?B?NW00aW80aHdMNkRPblhkNFUyVkhsMElCQU1RdmRyVEw5V2ZtdW5oeXRXS3RD?=
 =?utf-8?B?Zzd1TEZOZ2EwQ3hzWDZrcHdiRWFxK0lMSzZKNkdYOC9BbHppU00zQUlvVHdQ?=
 =?utf-8?B?TWFEZGdsMDlVQ21jd1pUcVJBdTRnWVJYa3JiRVV6MGFuZGdOazYxelU5Nkpl?=
 =?utf-8?B?N2VtRDBDUnFxMFV2K1MvVVZZN1o5V3Fyb1NaZGJjRFM5dFFSTkRpeWQvSWs4?=
 =?utf-8?B?dXFZaFozZmEwMThUellpUE5aTHlKNjU5Y3VOanlBaVVoSkFaY0NHbjAvMmJn?=
 =?utf-8?B?VlJQd0xOK21kcFQyWFpWeU5PTjhwRDA4NThuakdtUUdWUzBTM2JKc3dqYUov?=
 =?utf-8?B?dmMrT2RCQVN5UlprQyt0WkxiNGF4dEVESEtIYUZzSG1IYkFNRWR5N1c3akRP?=
 =?utf-8?B?eUpoa2REdENqc0JydldFU1NKeUxFdXB3YW92QkhyTm9FS0JHMDBvMk05dlZv?=
 =?utf-8?B?dk96MWs0YnJOQ200QzBNdTBLQldCS3NUTGZkMnkydmYwR1ZTcHFPMzM1ZE16?=
 =?utf-8?B?a1IvdDBKdFVBUk9mOXdhU0FIS1NoTDh6WUc1aDc1aWlKL0VtcjRLYlJDdnVW?=
 =?utf-8?B?T3AzUGYyeWtrTU4yT3VEZHZJelorc0svYlB1WHhGdDdPKzNnS0FMQkpYKzNn?=
 =?utf-8?B?dzZQUldWOVhQemhMbEVXU28ydDRrSDVIMU5kN1ROV0FEQUd5WUhjckhrYXFU?=
 =?utf-8?B?WDhkZXZaMHJMdHR4K3kySjZSSk1JeE1UUiswRjc0ZHR2MjZ2elljeDhkalB3?=
 =?utf-8?B?aGtrTWVHcSttRHhRTUtoNzQxeTAwZFRQQVE4SCt2N0pLbWpQbjkwRlg1TjVQ?=
 =?utf-8?B?RlZ1Zmg5UUJTWWxrWTRhbTRWN0pobkptNUNoZFloREdSeVlobCt3dVBTSW9y?=
 =?utf-8?B?c2FzWWVvMHVkdWlnYzBSOFVRQjJjblpVaW5YMmNwYTdZNGRBcmxjMWtqUVZG?=
 =?utf-8?B?Um9sRGZ0UEJnYjhxVDJ4WDV0eEdjNEwreEF1S0plS2EwYitrTGVwQWhCc203?=
 =?utf-8?B?dFA0OXRxTVZ4TGg5bXIyNHN2dnJ2d1NnTDZsclhiaDRMNXZsWXhZZVk1cm1r?=
 =?utf-8?B?Y1FsUllCYVRqUnNaMnpLbmlvakVFYlNnRDUxdXV3cStmQWFPcjlaeGQ0M2dR?=
 =?utf-8?B?Y1Eyb1pIRmJWOFJrU0FVbm53dSs2MkUzWUdPR2NwajhWandYMDAwbUNHNFF4?=
 =?utf-8?B?M1I4TDdudGk0YWQwZGtnS0l2YjU4QlBzcHpTSTJYcUt3VFBMUGU5ZGI3NFY0?=
 =?utf-8?B?WTB5clpTU1RmblUySHNYcGMvVDQxN2Yza1pPUUUydThwMDVsck9VSGdsV0tI?=
 =?utf-8?B?a2hkMWFibWZBWGxxbXFobzhpaTJ3UFRvN3JkMzVJa0lZb2NtbXUwaEhTMWt6?=
 =?utf-8?B?OUdxeDVzMnUzV2Z2aDFPaU84bGc3RnJUUVBjTnEvVUtld3NaMzVXaXFtVlor?=
 =?utf-8?B?MzRKVDBMSk5STmxVMDUySlBZRnVFZzFVK0liMEtEbHY5TEl2YkI1d2tITW1y?=
 =?utf-8?B?d2YwOXNicVlGUW8zcklTeGNwWDJ3SWk5V1hjWVVvVkk2UHg5Qy8zTGVaWGRu?=
 =?utf-8?B?R1l0MlZrMHZROFN6TFlMVWNKZkZoL08zclFuRUcrQS8zU2FXejAzdUFuYTd6?=
 =?utf-8?B?OXp6T3doYnE3bk5aL21PQ01ib0p0aTFRUDc1K3FnMkVVSzh5dGt5VXpuaCsr?=
 =?utf-8?B?UlFJeXBzbkVlNzh3YlVuMzlYdFNzUG5iRjVXTFBGVU1WRThCdG1oY05HcUF4?=
 =?utf-8?B?cS9aYW1PYmlhdkhkQnhObXY4cXlYajEvUmxRREo1c0dvNmsyM3RzUElOK2V4?=
 =?utf-8?B?WGlFM2dzdXhaZ1prdWxBSFVZQVlwOGF4SkZUTTlkRk93SjVlME9BTzZDWURx?=
 =?utf-8?B?eklPKzBQYlRQdzNxUWlHd3NwN0ZFTURZRU5ENHZRaUZBTTYrRXVwLzBENEtw?=
 =?utf-8?B?ZEp5MW9KOTVSak5LSE92Y1VZS05ib2NHOWRLZ3pPYWt0NHZqa3hpVjhsRXh6?=
 =?utf-8?B?bFlLcU9qbk4xUlEwRzhrdy8za3lNNjZhSVdyRkhTZEp5dzVNeVRvQ0R5NjV6?=
 =?utf-8?Q?xFDGKP0SPpwUwS+TG2jBM8DH9?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f31f7ca9-b8d6-41a3-a5dc-08dd51d7076c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 17:50:14.0539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vLfyHWzvFd3JdySLEY2lpWail977eCi3sc8+/5sJA/whYYbnWgtWVVr/+8zQ9pZrk8F/eMkDGaefyY3fyUzBUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8823
X-OriginatorOrg: intel.com

PiA+IFdlIGNvdWxkLCBidXQgSSBkb24ndCBsaWtlIGl0IG11Y2guIEJ5IHRha2luZyB0aGUgcGFn
ZSBvZmZsaW5lIGZyb20gdGhlIHJlbGF0aXZlbHkNCj4gPiBraW5kIGVudmlyb25tZW50IG9mIGEg
cmVndWxhciBpbnRlcnJ1cHQsIHdlIG9mdGVuIGF2b2lkIHRha2luZyBhIG1hY2hpbmUgY2hlY2sN
Cj4gPiAod2hpY2ggaXMgYW4gdW5mcmllbmRseSBlbnZpcm9ubWVudCBmb3Igc29mdHdhcmUpLg0K
Pg0KPiBSaWdodC4NCj4NCj4gPiBXZSBjb3VsZCBtYWtlIHRoZSBhY3Rpb24gaW4gdWNfZGVjb2Rl
X25vdGlmaWVyKCkgY29uZmlndXJhYmxlLiBEZWZhdWx0PW9mZg0KPiA+IGJ1dCB3aXRoIGEgY29t
bWFuZCBsaW5lIG9wdGlvbiB0byBlbmFibGUgZm9yIHN5c3RlbXMgdGhhdCBhcmUgc3R1Y2sgd2l0
aA0KPiA+IGJyb2FkY2FzdCBtYWNoaW5lIGNoZWNrcy4NCj4NCj4gU28gd2UgY2FuIGZpZ3VyZSB0
aGF0IG91dCBkdXJpbmcgYm9vdCAtIG5vIG5lZWQgZm9yIHlldCBhbm90aGVyIGNtZGxpbmUNCj4g
b3B0aW9uLg0KDQpZdXAuIEkgdGhpbmsgdGhlIGJvb3QgdGltZSB0ZXN0IG1pZ2h0IGJlIHNvbWV0
aGluZyBsaWtlOg0KDQoJLy8gRW5hYmxlIFVDTkEgb2ZmbGluZSBmb3Igc3lzdGVtcyB3aXRoIGJy
b2FkY2FzdCBtYWNoaW5lIGNoZWNrDQoJaWYgKCEoQU1EIHx8IExNQ0UpKQ0KCQltY2VfcmVnaXN0
ZXJfZGVjb2RlX2NoYWluKCZtY2VfdWNfbmIpOw0KPg0KPiBJdCBzdGlsbCBkb2Vzbid0IGZpeCB0
aGUgcmFjZSBhbmQgSSdkIGxpa2UgdG8gZml4IHRoYXQgaW5zdGVhZCwgaW4gdGhlIG9wdGltYWwN
Cj4gY2FzZS4NCj4NCj4gQnV0IGxvb2tpbmcgYXQgU2h1YWkncyBwYXRjaCwgSSBndWVzcyBmaXhp
bmcgdGhlIHJlcG9ydGluZyBpcyBmaW5lIHRvbyAtIHdlDQo+IG5lZWQgdG8gZml4IHRoZSBjb21t
aXQgbWVzc2FnZSB0byBleHBsYWluIHdoeSB0aGlzIHRoaW5nIGV2ZW4gaGFwcGVucy4NCj4NCj4g
SS5lLiwgYmFzaWNhbGx5IHdoYXQgeW91IHdyb3RlIGFuZCBTaHVhaSBjb3VsZCB1c2UgdGhhdCBl
eHBsYW5hdGlvbiB0byB3cml0ZQ0KPiBhIGNvbW1pdCBtZXNzYWdlIGV4cGxhaW5pbmcgd2hhdCB0
aGUgc2l0dWF0aW9uIGlzIGFsb25nIHdpdGggdGhlIGJhY2tncm91bmQgc28NCj4gdGhhdCB3aGVu
IHdlIGdvIGJhY2sgdG8gdGhpcyBsYXRlciwgd2Ugd2lsbCBhY3R1YWxseSBrbm93IHdoYXQgaXMg
Z29pbmcgb24uDQoNCkFncmVlZC4gU2hhdWkgbmVlZHMgdG8gaGFydmVzdCB0aGlzIHRocmVhZCB0
byBmaWxsIG91dCB0aGUgZGV0YWlscyBpbiB0aGUgY29tbWl0DQptZXNzYWdlcy4NCg0KPg0KPiBC
dXQgbG9va2luZyBhdA0KPg0KPiAgIDA0NjU0NWE2NjFhZiAoIm1tL2h3cG9pc29uOiBmaXggZXJy
b3IgcGFnZSByZWNvdmVyZWQgYnV0IHJlcG9ydGVkICJub3QgcmVjb3ZlcmVkIiIpDQo+DQo+IFRo
YXQgdGhpbmcgd2FzIHRyeWluZyB0byBmaXggdGhlIHNhbWUgcmVwb3J0aW5nIGZhaWwuIFdoeSBk
aWRuJ3QgaXQgZG8gdGhhdD8NCj4NCj4gT29vb2gsIG5vdyBJIHNlZSB3aGF0IHRoZSBpc3N1ZSBp
cy4gSGUgZG9lc24ndCB3YW50IHRvIGtpbGwgdGhlIHByb2Nlc3Mgd2hpY2gNCj4gZ2V0cyB0aGUg
d3JvbmcgU0lHQlVTLiBNYXliZSB0aGUgY29tbWl0IHRpdGxlIHNob3VsZCd2ZSBzYWlkIHRoYXQ6
DQo+DQo+ICAgbW0vaHdwb2lzb246IERvIG5vdCBzZW5kIFNJR0JVUyB0byBwcm9jZXNzZXMgd2l0
aCByZWNvdmVyZWQgY2xlYW4gcGFnZXMNCj4NCj4gb3Igc28uDQo+DQo+IEJ1dCBob3cvd2h5IGlz
IHRoYXQgb2s/DQo+DQo+IEFyZSB3ZSBjb25maWRlbnQgdGhhdA0KPg0KPiArICAgICAgICAqIHJl
dCA9IDAgd2hlbiBwb2lzb24gcGFnZSBpcyBhIGNsZWFuIHBhZ2UgYW5kIGl0J3MgZHJvcHBlZCwg
bm8NCj4gKyAgICAgICAgKiBTSUdCVVMgaXMgbmVlZGVkLg0KPg0KPiBjYW4gKmFsd2F5cyogYW5k
ICpvbmx5KiBoYXBwZW4gd2hlbiB0aGVyZSdzIGEgQ01DSSAqYW5kKiBhICNNQyByYWNlIGFuZCB0
aGUNCj4gQ01DSSBoYXMgd29uIHRoZSByYWNlPw0KDQpUaGVyZSBhcmUgcHJvYmFibHkgb3RoZXIg
cmFjZXMuIFR3byBDUFVzIGJvdGggdGFrZSBsb2NhbCAjTUMgb24gdGhlIHNhbWUgcGFnZQ0KKG1h
eWJlIG5vdCBhbGwgdGhhdCByYXJlIGluIHRocmVhZGVkIHByb2Nlc3NlcyAuLi4gb3IgZXZlbiB3
aXRoIHNvbWUgaG90IGNvZGUgaW4gDQphIHNoYXJlZCBsaWJyYXJ5KS4NCg0KPiBDYW4gbWVtb3J5
IHBvaXNvbiByZXR1cm4gMCB0aGVyZSB0b28sIGZvciBhbm90aGVyIHJlYXNvbiBhbmQgd2UgZW5k
IHVwICpub3QNCj4ga2lsbGluZyogYSBwcm9jZXNzIHdoaWNoIHdlIHNob3VsZCBoYXZlPw0KPg0K
PiBIbW1tLg0KDQpIbW1tIGluZGVlZC4gTmVlZHMgc29tZSB0aG91Z2h0LiBUaG91Z2ggZmFpbGlu
ZyB0byBraWxsIGEgcHJvY2VzcyBsaWtlbHkgbWVhbnMNCml0IHJldHJpZXMgdGhlIGFjY2VzcyBh
bmQgY29tZXMgcmlnaHQgYmFjayB0byB0cnkgYWdhaW4gKHdpdGhvdXQgdGhlIHJhY2UgdGhpcyB0
aW1lKS4NCg0KPg0KPiA+IE9uIEludGVsIHRoYXQgd291bGQgbWVhbiBub3QgcmVnaXN0ZXJpbmcg
dGhlIG5vdGlmaWVyIGF0IGFsbC4gV2hhdCBhYm91dCBBTUQ/DQo+ID4gRG8geW91IGhhdmUgc2lt
aWxhciByYWNlcyBmb3IgTUNFX0RFRkVSUkVEX1NFVkVSSVRZIGVycm9ycz8NCj4NCj4gUHJvYmFi
bHkuIExlbW1lIGFzayBhcm91bmQuDQo+DQo+ID4gWzFdIFNvbWUgT0VNcyBzdGlsbCBkbyBub3Qg
ZW5hYmxlIExNQ0UgaW4gdGhlaXIgQklPUy4NCj4NCj4gT2gsIG9mYy4gR290dGEgbG92ZSBCSU9T
LiBUaGV5J2xsIGdldCB0aGUgbWVzc2FnZSB3aGVuIExNQ0UgYmVjb21lcyBvYnNvbGV0ZSwNCj4g
dHJ1c3QgbWUuDQo+DQo+IEFyZSB3ZSBmb3JjZS1lbmFibGluZyBMTUNFIGluIHRoaXMgY2FzZSB3
aGVuIGJvb3Rpbmc/DQoNCkxpbnV4IHRyaWVzIHRvIGVuYWJsZSBpZiBMTUNFIGlzIHN1cHBvcnRl
ZCwgYnV0IEJJT1MgaGFzIHZldG8gcG93ZXIuDQpTZWUgdGhlIGJpdCBpbiBsbWNlX3N1cHBvcnRl
ZCgpIHRoYXQgY2hlY2tzIE1TUl9JQTMyX0ZFQVRfQ1RMDQoNCi1Ub255DQoNCg0KDQo=

