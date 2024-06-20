Return-Path: <linux-edac+bounces-1319-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 396C4910C0D
	for <lists+linux-edac@lfdr.de>; Thu, 20 Jun 2024 18:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6C6E1F22DC3
	for <lists+linux-edac@lfdr.de>; Thu, 20 Jun 2024 16:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699391B140B;
	Thu, 20 Jun 2024 16:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L1zBam+T"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6E91CD3D;
	Thu, 20 Jun 2024 16:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718900433; cv=fail; b=pRWwLHVJbjxF9zJHe0woV3nhhltIxHcDcrb8w4yC+3LSq0W+a1JtDjh5ytDKNzgEEkSqnk2bh0Q69H2uHk8ugUxy6g3Y9hoBXhcTgIYoemyYEV0etKYA0zSy8UVjDjYKsc8nH+PYBtRTbtLYoocjPW/rKByIPWm+g5FCi1LdQzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718900433; c=relaxed/simple;
	bh=UVueoXzhajMWew6Pi2gW8cMX5z1OxubFg6VGfkh4vgc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LONp4gX1YP4Zv8KsQ9Fdx8v1H80YmWxFOlHQfLN3rSWk6V0DB7L11J56OhHAd5ycekV7n9kpuO+3gvK+KUOjc1mP+opMq1P0TX8yCfqnW27Vo9Yc67Fe8rLc7MuJzXtk7nN+PqI+w8Fd93L1/bvMCphal8IG6Uba6gkAo/9KR6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L1zBam+T; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718900431; x=1750436431;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UVueoXzhajMWew6Pi2gW8cMX5z1OxubFg6VGfkh4vgc=;
  b=L1zBam+TeMXO10Y38HcJQQixaTLRMkVPU6k3F7HmtMGfWiEKVgSdLVbC
   6HjxNlxysZGcq5uIgSkmHOBB0NzyIOX7Nvb5MPCdnZMV59YgO/IKUMYD+
   Bc9u34wD8ynSMXuu9AkiKGjCwbIfr+KKyFdi1FdVB+GnSCqiHCLnIT43o
   o26tA9QQN62uvS379Wpkkk8he6qGNCI9Zjwn98tdVDvBKCY9BW+1Vq5VW
   XMShdP8ZwkOgNA1hpUXCdJw08h9RgZoDGShiOYKLtHzsGfdcxo9zI/pM2
   wx4IdIorUWuHUj4LALKpA5mF0ZSqUhYDKblzQk6SSbZQ9zZPXHGUC8UUq
   Q==;
X-CSE-ConnectionGUID: qWdgjH05TYO+LmsdfbNQEQ==
X-CSE-MsgGUID: Mgwe962VR0OWS+LJubnu3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="15772345"
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="15772345"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 09:20:30 -0700
X-CSE-ConnectionGUID: HxcAAmJzQ52TKhHcwyRjIA==
X-CSE-MsgGUID: ygzmHg5sS1Gj0oSdbd2xFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="42754348"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Jun 2024 09:20:30 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 09:20:29 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 09:20:28 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 20 Jun 2024 09:20:28 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Jun 2024 09:20:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=alAPrm4hKZbWP8U0vzq93eWdYFQDvAgbUIX7e8Ab49lK0AXyenzHwsa5JhMB6Pwt88r/JZWidRvBte3EGx00Kz5E8blG4qYjhZHc1C88fu5bi3PT8dPL+TWxUW3z7RGVP2SXmYlC7/k1gDU2lJlZKoUSW597Q212ic58oZ4XiCQFZTdzDSL9ej+g3PLGjLotnF1uMvf9bWnBtgia7BdGFvw/UW3ljzEy5M8amPGKwb3FqA2QhQxXCTh0d3wom2rffxeFd56c9jqfgh+KfxoODO9FSGZivzKGdsNQVuL6sIqL00xL+//X2ifJQMRCrRtSolEdvcOC1xolnDlwmwO1dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVueoXzhajMWew6Pi2gW8cMX5z1OxubFg6VGfkh4vgc=;
 b=NzCd8urPTJXAOIRD9cf5pkjYmBkaSYMnZ1/g2K+bt7GdOADojSkstm+PpG3Aom1BG+8OaauuUuv+NP4vZP04Yx+DJmt9a3OKSTpXnsAXzUQ12MfWLP89+6BliqYzTNHwECF2+kCSF+iSyTYAvtyfTq2o1eXNms94Z1K12Yl7T4Hr21mrlwFLGlYZyjKUFkwE2qh1YIK/J4hu5QPQCoVfwxWKcGlFJFWpk42+nsL3gikAi6bLb818OpQ44kuBaWxmJMW3viyNhGhOwTbQrgkH9vyWTyuVEQVmvIBa8ugXOGy6el1zxeNp3KAlaXVEDhzmiT822DVchzH46ZpWew/nlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DS0PR11MB7263.namprd11.prod.outlook.com (2603:10b6:8:13f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Thu, 20 Jun
 2024 16:20:21 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%5]) with mapi id 15.20.7698.017; Thu, 20 Jun 2024
 16:20:21 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "$(name)" <qirui.001@bytedance.com>
CC: "bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH] x86/mce: count the number of occurrences of each MCE
 severity
Thread-Topic: [PATCH] x86/mce: count the number of occurrences of each MCE
 severity
Thread-Index: AQHawX0xJTiAPghlyEueMSNTNwYZZLHNxjqQgAJ2MQCAAJlvEA==
Date: Thu, 20 Jun 2024 16:20:20 +0000
Message-ID: <SJ1PR11MB6083E1173846A5C8B4529D25FCC82@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <SJ1PR11MB6083AC9C721D46D3CCF9846BFCCE2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240620070140.12854-1-qirui.001@bytedance.com>
In-Reply-To: <20240620070140.12854-1-qirui.001@bytedance.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DS0PR11MB7263:EE_
x-ms-office365-filtering-correlation-id: 8c4c12bf-7f88-4768-57fe-08dc9144e1b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info: =?utf-8?B?Tko1dG91anBYWWlSQlVDVmI0dmRnR3QrcldoL1V5YnFTK3hBUE1mN3o4RG4x?=
 =?utf-8?B?eG5sNmpMMTJLd3M4blRKeHNrOFRIQUtCTGZyWWZJbFF4ajV4dmpleWcycUll?=
 =?utf-8?B?SHJ5RUJTT0lmb1Vna3AzUkdGa21TeGN5MnhCZW1NMHRZYmlpaEZnVWxXZ2hC?=
 =?utf-8?B?MUlwbE5vSWVIWDl1bzZuUFJCWlZpOENGaXd1Y2VUaFo1aTViNHBHMElZSnhC?=
 =?utf-8?B?T1BSeDVrcGlXcVJJc0dxTi9wV0Fya2RzNlNqWklmRHR2RXI1SVh0SWlpSmYy?=
 =?utf-8?B?Z2JBZy91aUgwR3JwV0JBb0VCb1F3bzdGVlZZY3F6WlZQZ25LUEpWcHcwUkxL?=
 =?utf-8?B?K010UTM3am9oMWxsYTdRUzdRYU1IK0hJUUVVeDhTWlhKTGZjSUkyeGNqMGVL?=
 =?utf-8?B?Nm00WmFtbUhvL2RFQy94R1RHUlRWS1dYWVp2T2FOYkUrWThDWXNUb2M5N3NJ?=
 =?utf-8?B?YjR6YUk4Zk1aUTQ4Q3hVN005djAwT3RUN25LMXRHUnA4NkFMOTlScTlrc3cw?=
 =?utf-8?B?UGdYK0RJc1dHOVpZRjRIakR3MldYY3JVcXRPNTQrR1RjUGRscE8weld5NkQw?=
 =?utf-8?B?bzdwYUN4WHBsbVAveWhvTU5uOXNQVEZPc2pWREgxZ0wvejY0U3RhcG1Ya2lx?=
 =?utf-8?B?NERNVVVUY2YvRE9WWjdZbHl5RjZ6aHRjZi90ZGVlbjRzeXowOUU0SnhaNUps?=
 =?utf-8?B?WHdmdUJISHlOWGVXS2ErVDZpU0RkSGkwRG9yRnpvODhvbFRlNUt6SmU2YTN3?=
 =?utf-8?B?ZkNYbkNiMGZELzJSYUFNU1NyZVBmZFRkbmpJcXRXNnljYkdGRmJtVDZRd3lh?=
 =?utf-8?B?aDlMb3VXeEZBVWlaaVc5R0VVZXBtTFRaUG1pVXZvR01KYXNPL2dWRmJ3MXU2?=
 =?utf-8?B?ZndSU2lycGxQOExrbTlLVXM3ZEJvR015d1hEb2gxbzdJN0NVTWdHRlZKNkNZ?=
 =?utf-8?B?S3lqWDNRTkE1NDdVZlBpRmRLRUdtZklwUWxxdk1PNmJQWndUSkNQYitJVlMr?=
 =?utf-8?B?b0JHK1c1V1hhSnZ6U0JZNGNVbWZBRERKSDJDNXdnWkhRRHF6WTlaUjNrbmdJ?=
 =?utf-8?B?b1BJb1NTNnpMOVE1S1VMeEhiTFZMdHpsM1VsQ0c4bFhjWndVN0RZYUdldHNi?=
 =?utf-8?B?T3hSbXcrU2dXOUc0VnV4bFdyWHNDQXhxZ0lJWTIyOENOZ1dxVVl2ajh5QnVL?=
 =?utf-8?B?YmphZ25UcXR5Zm9ndmtkK242TWVVeUliUDhOR2MvOGIxUkE3UVNSZmJjMkFk?=
 =?utf-8?B?LzRydzVNdy9xOVhUb1BjbGIyOU5GRnFta09Hd3IxOE9Hb04rS1BnM2dzTkMw?=
 =?utf-8?B?eXQrT3V5VlRqY2V3SW1vWVZQVVNxeGROdjV3YXFRM25jdkF1dzFmYWhzWGR4?=
 =?utf-8?B?MXpSMXJNY3p1RUk3V1hzN1hOSVA0ZmlzRjZoZERpL3dkUVdYeXB0ZVZOU2dm?=
 =?utf-8?B?OEJnRFZ6MU1wSVJyaHo1Mzh4VjhzTkkxcE5ZT092WFh2MGN4cXEzdjFuYkNR?=
 =?utf-8?B?UDRsaHh4SDY5SGZaYmJoMGxzeGwxS2NSb1NUek43UFRBSHJZUGsrRndoaUlw?=
 =?utf-8?B?UXQreGNxUk9GcEdlNlRqSE1KWmVlTTFoUTQyTzUrUGpMaTVRU2NRNldKTU5M?=
 =?utf-8?B?WmRta081TU1tSXR6SFpyWkd5dExhemJCcE1OM2hlaVhCbDgrMnpFWlpvQXF1?=
 =?utf-8?B?RU9ydjRzeTZHalFISzBiWDlFdkhBK0pqTFYyMCtBZkhDRjhjYVFLUnJpOGEz?=
 =?utf-8?B?MDBtYmZ6a2RJQlJ5NEFXakJZK0twNmVjWmRRazdCUm5pTzJpekZ4UnVRQWEr?=
 =?utf-8?Q?KDW5xu6536L3W5cAY1zvOpuqm+Nk85AkYgEfE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VkdFaENxd054VGlzOXRnMEFwQmFUSFdNSDI0TXRjNU9IdTVhZHMvaGN0YmFX?=
 =?utf-8?B?YVplWWoyU0IzemsxdTluMTBHbUlVTytLcVpDeXpUWUNZRmgwRFBvMzBRVVAx?=
 =?utf-8?B?L1V6N0ltcGN4ZE5hYld0c3JWNUVQYTJWQ3ZtNDJ0ZzBqN2NFUkMwUGVDZDBz?=
 =?utf-8?B?dzdrNVExVENYbWhsYmt4SUM3N25PaDZpZFVaMHFpV2ZOWGJLL21BODhVRE5X?=
 =?utf-8?B?U282WDJLVCtuL2dYUFVtdEZISVZ2dk1hNEc5WmNoZE9hZTRzQlpDbC9JZVdz?=
 =?utf-8?B?RFR6SVRGVWZRdldiZ1pKNDFkLzdQUXRlVTVCYXYyWnd0UU1BeHVRdDVJd1hs?=
 =?utf-8?B?eFJBNHR3WUwwU0hlRjNGVDJPZ0NwbFRUTnlacldSYXhWcjRYV3hiZW9iTk9Q?=
 =?utf-8?B?MmN4YzhCQ0Q0SVVqYURla09pQmxYV3Q1RGhjcDBvcDFUQmd0WEEvMTVzMWd6?=
 =?utf-8?B?K1VkUzFWRG5ndVZZa2V4cEhpTSsrUW10Nm9RNnY1M21EdW4yRWhUY1VVSDJE?=
 =?utf-8?B?MjRncVI5S1NtZXZ6bnBIb2JxV0hBcVluYmYxYkNWTWdNTkZraWRYc1l0OHcy?=
 =?utf-8?B?YVpEenB2amwwY0FlQTFsbFBlR1NnaWlqZXZXMXpjYWtrY0gwQUJTS0R0dWxw?=
 =?utf-8?B?dkhNSU5PLzd1aHZoa00rMHZEUkMwdWpLcWt2azhtWEpRaVJ3SitKUlBLYmhH?=
 =?utf-8?B?UDJBSEZRQzRSNHlZVHJrY3N4VW1FMjYrcUhFKzdmWVg3SFIzSmVkc0ZhUnl2?=
 =?utf-8?B?ck5KTW5lN1dTR3ZIM2pLdnhBSTBsR2cvcDhTdlEzQ1E4QmZneERmdTQ2am9a?=
 =?utf-8?B?djdhSitnNTZHZzZ0bSt5dERBYUxOKzBIZmphcS9HdGNYTzZodWNVSys0aUp3?=
 =?utf-8?B?Q3hSNE1sZHpnN093d0pUZ0I3ZmhnTnpZYmtFNlp2N2pqRWVmREdUT3BtZkZx?=
 =?utf-8?B?VjV4Wmc3QUwyd2dML08wUHNLaDQxdFNqejhERGl0S0xzMVYxWkxyVklqbHVP?=
 =?utf-8?B?TFJkWitKOWZyckh5WlhndHMwN2owS1ZVaS8xQlFiVk9Od2FjMHlieDFjb01i?=
 =?utf-8?B?Q0ZTRVhsZWV5Y1JyMmNVbUV2dU92WVVPSHQrZk5RSHJvZ0pLQzZQSTdwSmNx?=
 =?utf-8?B?MWptcjRaY0ZnVU1tdGxSdXFzMUo1NG5jbW1nY1VpVGFENHVPbkNmbmIxd3ha?=
 =?utf-8?B?QWc0SU84WjBQMHBQd3V6UnJOZFUxOWpoeXJFemVEZjMwdXZUV2pqeDdQUFM1?=
 =?utf-8?B?cFB4aGo1RVZRcWlEY0QwcEl4NDVJSHZtTVYxMHZ3UkxaOEpYbVBjZ3BJL09N?=
 =?utf-8?B?eUZmNE1QaldQN2ZJNGY3QTJmQnZZTi9WdWhFa0h1ZS9DSFhXajIwRkNQSzZS?=
 =?utf-8?B?VEF2cGZvZW9YcHJPT2V6azBaa3BRQm1jQVY5cHgyRXpRdDRDWHpjSXZDTHNU?=
 =?utf-8?B?WUJDbHhpTElrNDlFQUZEczluNmNDbWNYVmlWb0lQNnJDVVAvZWhQdWNuVlB1?=
 =?utf-8?B?bVNnbVdsaHNYaWFMWHoxWm1LckRJVUtiWTJYS2RWaGtvc0xjTDRhc3JvbmlQ?=
 =?utf-8?B?N05lM3V2KzRKb0oyekxOUHB5dW0remJMT1M5eUZ5OC91SGIyZVVobWRRVlA5?=
 =?utf-8?B?SDJMdUJFVmkxZVZUT3Fob3h2V2ZGYVVteFJraXJ1SlphQXdoTms1Y1krQ28z?=
 =?utf-8?B?ejU5c1VKN2pDQ1BFaXV4SjMvY0g2dnNPN25MMlZiQ3MwQjhGVjFaZjhWRHlN?=
 =?utf-8?B?RXUwbkFhVnExS08ybkowY1AwY3dZelVudDFaaXV6KzNuNlFJUnh4bkFTcGhK?=
 =?utf-8?B?dTRuN3g5NXh2dnp1ZXgxQXVSdUlldHc3REhCWWphTVlzc0NncUorUVJmVUVL?=
 =?utf-8?B?RkFTaVVFU3I2YncyQzgyMGd6ekJ5Z3JYbWNEN09KNEtjNVVqT0FSSXZ4UGJC?=
 =?utf-8?B?UGZJdU82dVFNbm9yZzlsa3BuMDFvRURuT2Y4VC92bWh0Q3pvL01QSmEwaVFN?=
 =?utf-8?B?M0hoSlg5bzhLNEFBVlJzR0RzdkFFeGNsblViVG9RQmJzdTdRd0hWZVQ1M0dL?=
 =?utf-8?B?MDY5QWFrcHhQNWVPNENMMFQ2Q1h1Sjkyay8xLzVZYUxnTWZPR1R5SnpNMnRJ?=
 =?utf-8?Q?LdPBeWmP22Oo/Kawr5QDs36kn?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c4c12bf-7f88-4768-57fe-08dc9144e1b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2024 16:20:20.9932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q2vvke2cNyaw5BNzaORNG566qsHHh9H6XZxKZT4e9lOLKerbV0Pf0YiRAtqrBu12Q/L3f4Vhag40rdSmbp9H5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7263
X-OriginatorOrg: intel.com

WW91IHNlZW0gdG8gaGF2ZSBwcm9ibGVtcyB3aXRoIHRoZSBlLW1haWwgaW5mcmFzdHJ1Y3R1cmUu
IEkgZ290IGEgZmV3IGV4dHJhIGNvcGllcw0Kb2YgdGhpcyBpbiBIVE1MIGZvcm1hdC4gVGhpcyBv
bmUgaXMgaW4gcGxhaW4gdGV4dCwgYnV0IHRoZSBGcm9tOiBoZWFkZXIgc2F5cyAiJChuYW1lKSIN
Cg0KDQo+ID4gU28geW91IGVpdGhlciBjb3ZlcmVkIGEgY2FzZSBpbiB0aGUgc2V2ZXJpdGllcyB0
YWJsZSwgb3IgeW91IGRpZG4ndC4gRG9lcyBpdA0KPiA+IGhlbHAgdG8ga25vdyB0aGF0IHlvdSBj
b3ZlcmVkIGEgY2FzZSBtdWx0aXBsZSB0aW1lcz8NCj4gPg0KPg0KPiBJbiB0aGUgZmF1bHQgaW5q
ZWN0aW9uIHRlc3QgaW4gdGhlIGxhYm9yYXRvcnksIHdlIGluamVjdCBlcnJvcnMgbXVsdGlwbGUN
Cj4gdGltZXMgYW5kIG5lZWQgYSBjb3VudGVyIHRvIHRlbGwgdXMgaG93IG1hbnkgdGltZXMgZWFj
aCBjYXNlIGhhcw0KPiBvY2N1cnJlZCBhbmQgY29tcGFyZSBpdCB3aXRoIHRoZSBleHBlY3RlZCBu
dW1iZXIgdG8gZGV0ZXJtaW5lIHRoZSB0ZXN0DQo+IHJlc3VsdHMNCg0KSW4gbXkgdGVzdGluZyBv
biBJbnRlbC94ODYgSSBkb24ndCBhbHdheXMgc2VlIGEgMToxIG1hcHBpbmcgYmV0d2VlbiBteQ0K
dGVzdCwgYW5kIHRoZSBzZXZlcml0aWVzIHJ1bGUuIFRoaXMgaXMgYmVjYXVzZSBvZiBhIGgvdyBy
YWNlIGJldHdlZW4gdGhlDQptZW1vcnkgY29udHJvbGxlciByZXBvcnRpbmcgdGhlIGVycm9yIHdo
ZW4gaXQgc2VlcyBhbiB1bmNvcnJlY3RhYmxlIEVDQw0KaXNzdWUsIGFuZCB0aGUgY29yZSB0cnlp
bmcgdG8gY29uc3VtZSB0aGUgcG9pc29uZWQgZGF0YS4gSWYgdGhlIG1lbW9yeQ0KY29udHJvbGxl
ciBzaWduYWwgd2lucyB0aGUgcmFjZSwgTGludXggdGFrZXMgdGhlIHBhZ2Ugb2ZmbGluZSBhbmQg
dGhlcmUgaXNuJ3QNCmEgcG9pc29uIGNvbnN1bXB0aW9uIGVycm9yLCBqdXN0IGEgcGFnZSBmYXVs
dC4NCg0KPiBJbiB0aGUgcHJvZHVjdGlvbiBlbnZpcm9ubWVudCwgdGhlIGNvdW50ZXIgY2FuIHJl
ZmxlY3QgdGhlIGFjdHVhbCBudW1iZXINCj4gb2YgdGltZXMgZWFjaCBNQ0UgZXJyb3IgdHlwZSBv
Y2N1cnMsIHdoaWNoIGNhbiBoZWxwIHVzIGRldGVjdCB0aGUgTUNFDQo+IGVycm9yIGRpc3RyaWJ1
dGlvbiBvZiBsYXJnZS1zY2FsZSBEYXRhIGNlbnRlciBpbmZyYXN0cnVjdHVyZQ0KDQpUaGF0IGNv
dWxkIGJlIHVzZWZ1bC4NCg0KPiA+PiBEdWUgdG8gdGhlIGxpbWl0YXRpb24gb2YgY2hhciB0eXBl
LCB0aGUgbWF4aW11bSBzdXBwb3J0ZWQgc3RhdGlzdGljcyBhcmUNCj4gPj4gY3VycmVudGx5IDI1
NSB0aW1lcw0KPiA+Pg0KPg0KPiBIb3cgYWJvdXQgY2hhbmdpbmcgY2hhciB0byB1NjQsIHdoaWNo
IGlzIGVub3VnaCBmb3IgcmVhbC13b3JsZA0KPiBzaXR1YXRpb25zIGFuZCB3b24ndCB3YXN0ZSBh
IGxvdCBvZiBtZW1vcnk/DQoNCnU2NCBzZWVtcyBsaWtlIHNlcmlvdXMgb3ZlcmtpbGwuIEEgY2hh
bmdlIGZyb20gInVuc2lnbmVkIGNoYXIiIHRvICJ1bnNpZ25lZCBpbnQiDQp3b3VsZCBrZWVwIHRy
YWNrIG9mIDQgYmlsbGlvbiBlcnJvcnMuIFRoYXQgc2VlbXMgbGlrZSBwbGVudHkgOi0pDQoNCi1U
b255DQo=

