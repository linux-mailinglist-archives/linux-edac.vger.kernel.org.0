Return-Path: <linux-edac+bounces-4871-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC16B898E6
	for <lists+linux-edac@lfdr.de>; Fri, 19 Sep 2025 14:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CE181893E22
	for <lists+linux-edac@lfdr.de>; Fri, 19 Sep 2025 12:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE6422A4E8;
	Fri, 19 Sep 2025 12:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RxZQm5oK"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7431E32A2;
	Fri, 19 Sep 2025 12:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758286608; cv=fail; b=B2H9TplwdHQIBBnntjiRC++1E/CmnFC91zgxZz1TR5NDAGuwOMgukGuYxJqElGIgQae+IGH/5+Fn9tHEsmwmSS0xaeNoJcqak0bbb/16l1zy8cfLrdzttgRM1sHf55/o9VIlfi9fRxdAn55vimFQjz50t6wWc6rMhDOPNz8UfOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758286608; c=relaxed/simple;
	bh=uvBk3gXpWbIokIXPjV4wXGiVPrjIf9BR2INcNlkuLk0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=McPN9BTGu8oFWsigvTNIj24iZGgX3vUlrUfFYJo4UNKVhEK3RlNuDF1q+SG4cl2xPI5qH8TP7Qy5Qtl1gzj2XeN5GVC2/+siVZaoEddCtWhJKjR+hFmqemJNHkQ3AAbV57qs3vE5WMSpCILrnFtjtuygTebz3qb5hqQTsFfYBIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RxZQm5oK; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758286607; x=1789822607;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uvBk3gXpWbIokIXPjV4wXGiVPrjIf9BR2INcNlkuLk0=;
  b=RxZQm5oKKWbWZn4JGW7755MhzTuFm/0fXQCz3fgKQGtKv2Qa+aFcZ+DT
   N6pCWxjCdj6RssZvbBr2YlV8NOHSfUZO6ySZGsGRfLf2uTAtJGPFbAeUz
   at9ldf8stPc7gkfnmjM98aD2eGNFvDfzizPaftdXx+otLMS896XjS8cwk
   tLVGa9Nahy/L8YJLjJfi3ociIeRC+/Wrjnz0qVkZUI4F5z8LnhclhqBDi
   9lRlkCFVbvR2T813jua2zk40he0KyS+6QDZed0qwaS7JrIulfD3TcDVfY
   Zqwsw6tZMGT575h66inJMNXjxv378CEpVVeZ75LLH3lbj33r65FxrXk8q
   w==;
X-CSE-ConnectionGUID: /u3MA7AOSfaGEp8uOtNKvw==
X-CSE-MsgGUID: H3pZIjv1Q2mwuw6daitnJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="86071008"
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="86071008"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 05:56:46 -0700
X-CSE-ConnectionGUID: 4uBcuC9JQSOU5zx2OSyZYg==
X-CSE-MsgGUID: gtOxQO8+SRG8fOJ/eRDC8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="199537368"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 05:56:45 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 19 Sep 2025 05:56:44 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 19 Sep 2025 05:56:44 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.71)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 19 Sep 2025 05:56:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tSE02Vh89XCLgnVfpmhxiOiw03OyxmnY25kEX4Z8hDeHSqw4XnMOY6Od96xmPhXnuVmYKWh+a+rKEcmU3tdFvpLkEDkEjT+zZjDnZuNNZWJnVqoQCYvWj6K0Ih46/BIrgWMxC0KuLekL92H7YGiMHJBB4RLYUIIZTyl9O3/8Iby9qVAlFynDZqPs4M1+jrzrWIC/avSf9iZCiFrq7AOvWcFWpb0y8PXGLDI1EXAmESDFwv3YqT3J9cXOu3THN0vxXANUtvFw9p2Y3yc8lW/N/2kD67tSmFVPBwJXDadq8dHrdALRCr2TTHJoOVkyJPJSpcD53t8oe3HpTXZIJaqk3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uvBk3gXpWbIokIXPjV4wXGiVPrjIf9BR2INcNlkuLk0=;
 b=j8iDtkV8Tmtb68c4BXkYLIQ8U/x8ORBS9CbsOQvoooLJx8cka4xY+fPglrxpkSJX4uKIgLp0d0PbUr9GYxkqJJcUUkjmw0RU3cOvZakSkSA0YiWZ4cw2893rSj7LGR2wIeEgnGyLizmr4tcLL5hbtrljqsVwtMeoeV4WMb90IFPXzvKQ2uerT5j9CWmPd/r69kgAVaafNCgRrYW+/Kw127Q6cqBHMduQxOII69/xSeZaXTruzwuuUyFBiIXHgnHfTg6gCnOEnazw8edztqZ4O9Y48KTgy+2K8nxo0hhD4ij0Xu7ngP+n96zg4qMtqqN6hU/gFmOQ7K+nkvJHaOMoYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB7130.namprd11.prod.outlook.com (2603:10b6:806:29f::10)
 by CH3PR11MB7202.namprd11.prod.outlook.com (2603:10b6:610:142::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Fri, 19 Sep
 2025 12:56:37 +0000
Received: from SA1PR11MB7130.namprd11.prod.outlook.com
 ([fe80::fc98:7fe:bac0:f2d4]) by SA1PR11MB7130.namprd11.prod.outlook.com
 ([fe80::fc98:7fe:bac0:f2d4%5]) with mapi id 15.20.9094.021; Fri, 19 Sep 2025
 12:56:37 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Rui Qi <qirui.001@bytedance.com>, "Luck, Tony" <tony.luck@intel.com>,
	"bp@alien8.de" <bp@alien8.de>, "mchehab@kernel.org" <mchehab@kernel.org>,
	"james.morse@arm.com" <james.morse@arm.com>, "rric@kernel.org"
	<rric@kernel.org>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] EDAC/skx_common: Fix allocation check when
 adxl_component_count is 0
Thread-Topic: [PATCH] EDAC/skx_common: Fix allocation check when
 adxl_component_count is 0
Thread-Index: AQHcKJY5IQ46go9fgUePyl/3K8vyr7SadHmw
Date: Fri, 19 Sep 2025 12:56:37 +0000
Message-ID: <SA1PR11MB7130D0C4D54EBAD854CB18B68911A@SA1PR11MB7130.namprd11.prod.outlook.com>
References: <20250918121704.45116-1-qirui.001@bytedance.com>
In-Reply-To: <20250918121704.45116-1-qirui.001@bytedance.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB7130:EE_|CH3PR11MB7202:EE_
x-ms-office365-filtering-correlation-id: ef0ee9fc-6537-4314-525b-08ddf77bf806
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?qxvvZ0gYchZ+D9x2vX7a5TeOgPVEU9FqgxyZ3pxZSTfefpFCGRBqo1yYLqcR?=
 =?us-ascii?Q?lFLeIWMB3zLR3I9lGFXAZ/gBfnZKGMcajSnv80P6ZF+L5ry8lmfEzXLOV9JJ?=
 =?us-ascii?Q?UKDEagK1cwKw4XRTL3xmCnZvwB0KUxLR6YYCMUDXBEZ+hMc2lt3YKjbnA0Az?=
 =?us-ascii?Q?x34VXxJDoKx2X3/qZ8qrmbarezcx6+SlU85m70CV/nuFEiL/uL9otySC3U0F?=
 =?us-ascii?Q?Yt8JgPPXBpyjRJSCQTkpcR8RFiu54ZqeTxxWvMWMG9r1DtbwYY7kL/+jcaGv?=
 =?us-ascii?Q?kXiefVtT0Ola/WzYJ0eavYzrg/M6ID5aIH9RpbbIbYocJY8HNMDlkkzUTA4E?=
 =?us-ascii?Q?sguCJF8K87qD/o0T9ntOqV0pW28wBJnSPytdU/XimaKLYzVRvL3aqnbp6fUN?=
 =?us-ascii?Q?mW/AjuxSgXWf+QJ4Uzq9Kwa1crD+Fh7qd+FagrOBVXWAAKFOOCrU8M3z3+7h?=
 =?us-ascii?Q?MESRzLKgzQ8qSRlk7qC44mqjSEVB/SXzI9QHoLa1gtOwwyafDZH1hH2Vms/i?=
 =?us-ascii?Q?ij6dvpLV7nHzTzJfgcwuXj7ycYcokAw+3t346wWuonFuNavTXGm0IF+fi0GC?=
 =?us-ascii?Q?SW47yrrgMVciM7bfrlYsM79bhnGoqXxl6e9wwevm2gI7PBfrxy13dI0qcKUM?=
 =?us-ascii?Q?4blLvzVvDIH9LmCgh/BoEglzy/FQEpIbUhUE6HFIbNiOKoQM013GJGF6VP7C?=
 =?us-ascii?Q?jWR1ZnTATsMZbtzjRbgXveIiJikkvv+D3PfRMNZ4ATHcAxjOES7J9/4xnFv8?=
 =?us-ascii?Q?0YgcN8EGIWUxXMBNzPIGIv64vbys1YfwWjIffutkarYYL9Wg5gGNmvh2DchH?=
 =?us-ascii?Q?oZrVRxu7N0QbtQ1DSgwjc/XEDOWaxFvK8ZZ0D9oQlwb6l3vZeDtVK2i9/ddf?=
 =?us-ascii?Q?Mz7ixdYksli5kFWLUiiF2xapIxgDpWiGqOtaJCvNcfItvyfYoCWV70cvltNs?=
 =?us-ascii?Q?SiUBM4srp80ODCrTLDLlCPbIRWPjf6SUGrX4CnlxIzGb71gX0URbzTvowp+i?=
 =?us-ascii?Q?CNkA5nCiMOXHwd+Ngo3FJWzIFDRk2Ow5pIBXzLaD9061OpTqs8SMOxT7b22g?=
 =?us-ascii?Q?BgZ1P5Vf4oCOx1sfK1A1WDabllvfBtkH6lMkV19POKksymeO3c2RDboeF4o/?=
 =?us-ascii?Q?w59s7EHeCOYjlrLO83Xx+m6FK7gBr83gD7LBbabB14ZLiDUWxza4M7hAmMw/?=
 =?us-ascii?Q?HVeQfZ2v4obl9AbGrS58Q3v3uKuPDbwAJ0etFeVCk94j97/7okvz37j50XjS?=
 =?us-ascii?Q?pBWkyrJo1EegpEdubmOWIrmi35d98971CL4Nd82G+rbfB/HEgtSRXOgnTavg?=
 =?us-ascii?Q?A9+LWSnTDGt+sSsi9CmLHsvDZtCTO5o8tyI+4+ypGC9Rh5rSwdf6AkZAK6Z8?=
 =?us-ascii?Q?8kyv97eOiIbhfwvJgkqujxzNG7FTr3MvT5ALb6d/pf5RRYaNYpyhT3qljQSb?=
 =?us-ascii?Q?JlnJ1QB4EE0TkM58pLMuZG2yv3xRNsj36BZyc1+rGOUrBRqyJ8NZ1g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB7130.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PCDJf+kat0y/MNtOE8U2pjXDk7HyKJK8OlHGDe/1Mod9JjZXqKj4UUkvmgty?=
 =?us-ascii?Q?fIwutjU+unEC0AqGFDM0GQL8IQVwnA76eW8FNVmWneqnED7FWH3g82U2e3ff?=
 =?us-ascii?Q?h4VSR4PeIFZ3ODtVZoKk+Wg8JxDVGJ5RJV527axyXYRTvIye80bxvJ+6yGiy?=
 =?us-ascii?Q?yXa4sEhALTJax/KdpaouDFEo0ymsNjKM0DQjRaudiuYOukGqann9TLzMUo/A?=
 =?us-ascii?Q?WSQvMIBkxvUQ8czTe9ErBTTXZ6HQeSLu9aQc03NSvE836PAnZF9lh21eDnmd?=
 =?us-ascii?Q?QCgVcJYIY6HHfOREO9Oqcrcxbb7BSC8U1d1d1FXh/NsE7j6CjehXIIGAFNKC?=
 =?us-ascii?Q?lMh199XAgEAaOD73ZoaxqPnUKOb9ubQeN0yWH+HJyvQegr17euwzHe9oRKRG?=
 =?us-ascii?Q?5E82ihVyfVRO3e+XWp88kHBrN3HduM/c8GTDLDeP5xyi80SWF1wSpMtE0cGj?=
 =?us-ascii?Q?/0sYpTsyYPIn6REdnVN+oveRkyNKLi9y9uwRMuOFifLDLz38lXiYoiF87/LL?=
 =?us-ascii?Q?PV6PIVlu6MHtV4Dut61HBNNXlWuDdpw83BX7YV8SJiYSIw10KT38lRsLymJA?=
 =?us-ascii?Q?B1UEM4Zs1v15WzO+vt07G+dEYZYkhnnYRSuF68gMaRUtGVPlsMrnZv4sIioI?=
 =?us-ascii?Q?cJvDMoL9rppYKRqROkmEJoZN6d+nZvNyc/rL+ZyuLvxEkuonSaBl5WGXat+z?=
 =?us-ascii?Q?Kh68u5MJoWENsZEpLE7G/WPEojH268ORECeVj/Oh+UsUWU4sCHwUsvAFTOiV?=
 =?us-ascii?Q?cCuCc+rbBYZJnqJvBgP6h01nnLxsNBCIH8rmxw8xxobb84KFGr994kvmQQFO?=
 =?us-ascii?Q?MDse+qDQ+tKhmSQRqsvqNeKQ1bdyYkt0aSClF/HrIo4hu0WJ9IKZqZnMir/D?=
 =?us-ascii?Q?lJXLEDbqUIlM5zIDU9gZ4czOAXbhPEyc7fn/yj8O2rQFRQrvTsI4nJxIFHKI?=
 =?us-ascii?Q?KgLlP9acqylZ/hxr9FWV/eC39ttfeCOmIt0ghC29S/34XsuFmMdSJECI+w1D?=
 =?us-ascii?Q?ESLYhz4zpWxYk7aclkQcETWf8z7LUG52cu7caBf6wBti8/XLpsnm4G1uvBdZ?=
 =?us-ascii?Q?Qku46wPhBJwW4QRKC6BYBoDSOaUhq4fxfVO0kQ0a79dpuZmcZkwqsjmk+elQ?=
 =?us-ascii?Q?GWYBbq7Kg8o1HnDwLJvSUcQJEPRtZBK/9R7j2HKd/2CJTfTjzVzfK7ROTclu?=
 =?us-ascii?Q?cgW+CKXZwVnEdzl8Ysws0YZLeizwdRVtnWu4hmV5Csjvd7ll7qbfesLgScqw?=
 =?us-ascii?Q?wJkqLUzVcSn71hWBnzKDQOtKleX45plqmHubt0HrmAkQ5RbU1K6svI/G9b6A?=
 =?us-ascii?Q?4M7+r/y6CrzT7bkCs8G5aX2XVLtuP07DK1sJUgnWMhAhFmr0BSbZfzxEc+Z2?=
 =?us-ascii?Q?9Yrd0DSZrF9R6I9Veak2lU4tOr95gPeTtqBDrpcEWiArfZ1vEtlqXf4cRK9Z?=
 =?us-ascii?Q?eOjQPCEfPg+HqjnoZZgLdfq4XOeBBhbEKwBB0EUKXuq5JW9VqN904KghjGN+?=
 =?us-ascii?Q?K0kIO1cYoi30KjeAOylUS+jA2xRwf6v/sKrlbvoOAu4OllODXySJpgNWcimT?=
 =?us-ascii?Q?7y8ZE58zZrAyhuz+nh/HJR5lzBeeHS7s4oMgwYBX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB7130.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef0ee9fc-6537-4314-525b-08ddf77bf806
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2025 12:56:37.0282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ydEyjyBqCmPPOUWU4YJY0lqMESLxJ9ZiviE6/4a4GUNioCDmzQWmUDGgJg4sX7K0VwGxmkYDbQZk1I/w/nxbjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7202
X-OriginatorOrg: intel.com

Hi Rui Qi,

Thanks for looking at the code.

> From: Rui Qi <qirui.001@bytedance.com>
> [...]
> Subject: [PATCH] EDAC/skx_common: Fix allocation check when
> adxl_component_count is 0
>=20
> From: Rui Qi <qirui.001@bytedance.com>
>=20
> Use ZERO_OR_NULL_PTR instead of simple NULL check to properly handle the
> case where adxl_component_count is 0, which would result in kcalloc
> returning ZERO_SIZE_PTR rather than NULL.
>=20
> This ensures correct error handling when no ADXL components are present
> and prevents potential issues with zero-sized allocations.

If the ADXL component names are empty, skx_adxl_get() will immediately jump=
 to error handling.
So, the adxl_component_count value is guaranteed to be non-zero when passed=
 to kcalloc().=20

>=20
> Signed-off-by: Rui Qi <qirui.001@bytedance.com>
> [...]

