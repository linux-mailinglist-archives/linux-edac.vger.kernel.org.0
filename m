Return-Path: <linux-edac+bounces-5551-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF48CA855B
	for <lists+linux-edac@lfdr.de>; Fri, 05 Dec 2025 17:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E630341BF69
	for <lists+linux-edac@lfdr.de>; Fri,  5 Dec 2025 15:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F6F31D366;
	Fri,  5 Dec 2025 15:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YMzmDLmQ"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AEA3126C7;
	Fri,  5 Dec 2025 15:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764948984; cv=fail; b=rnlLmZPKBnGUE0l+kUHN8MgcqCrJuLLzGb9TAMv80IP/90GcLfrCCwG5/ayvX8CdiMBxq2IgMMVTU+Peo5hCzLm4MvhLin0U/Z9kvOJTQM971Fy/F4hF0rdg7IolV1LvNtVAvWf4KHb4zxvJpQuFam7Fzb1BDSYlZeQHat6DoH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764948984; c=relaxed/simple;
	bh=Qvrh6Fspjcu/GwYfqoCshs1hk5azkzjwemKg7fMINVw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pB/F4b65UZeV3VWCwUh0V+kTveSClDwKF/XUsA21p5c2FcLDFzVqgR6MgzFgtUtmxV7SOYeSRLbSuqac8N0Ohtuu/6EQ3AKxHXR7usnqeCNkzojN0uwoJrVqg3R+9uIxwteJajiqxOcWazzVQ/fVBHfQXb4GTIaSu9f0uLz9ZAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YMzmDLmQ; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764948980; x=1796484980;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Qvrh6Fspjcu/GwYfqoCshs1hk5azkzjwemKg7fMINVw=;
  b=YMzmDLmQ4VBTFRxlMrZIVHFDyDANV+CWvLF+YkXszjgeUzUgES4uBA2A
   qlzpBQoTk5Xva67J7o8ikdHdxP2y9gjtZa1U6MqQkAGvCdEPjxru7u0T/
   38vciXB0K4sD60S2P8kKO2NLfV4jdy37ihyKMzsuZRSCQN5UF9MlLC5jE
   Rt5ePIt5FnIiPZ+77py0tIu2/wO7gfh+lcz3iomjhzais85F3G7g9Pwmm
   r9OVZGrc+lF7fm6j+SAyYDwTi4PyztzaeWCAim35RajVazmNuvCZzkU0g
   xpSfImCwMmh66KlUmmdrnCrD1bClmfwU9iEIyCUOZrdmogKDeXQSfQR9L
   g==;
X-CSE-ConnectionGUID: RtaRA2KWTtSMLX74HjRWLw==
X-CSE-MsgGUID: 4oYiihRGTcSoU06Ik45+iQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11633"; a="77307129"
X-IronPort-AV: E=Sophos;i="6.20,252,1758610800"; 
   d="scan'208";a="77307129"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 07:36:11 -0800
X-CSE-ConnectionGUID: KZEKDbUDQja2bb5u9x6uiQ==
X-CSE-MsgGUID: Z666KebeSX66fD/l/VrHiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,252,1758610800"; 
   d="scan'208";a="200265592"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 07:36:10 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 5 Dec 2025 07:36:09 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 5 Dec 2025 07:36:09 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.5) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 5 Dec 2025 07:36:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xPedcceUO1CkPqwglEfZKmzs9zd+toanonAZTsshPKJvjExVauB0sND7paUItZlXGLS9b7xid6B6O31D915PacmED+Mteo5O9j6QGTOyH1o5RqUVID6oaIVrgzHLgFSRMENI7ifqyFcabfiXtCoZaNhsHC/bT57H40cKsQ/tya4my93Omb5oYb6JRynVFkwBMZE6Rm7Wa9dpKB8VYXsh8A3BhN6fimH6iR/6wL1lryL8SWlNj9cv+yTOzqBsog5Nqcfzk8Zo62r9ks6xmq50koo8R3WUGaaPM1td2458+ehS0ro/HhClltHTuznnl/g5v1oQcp7IQVMr69pEBzd36A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v/Ace+wigf1o7j3LYwKiPewF0HCCro1/vw2lEJFqSSY=;
 b=v2IN6vJs6KJtT/bNEF2Py4ou3kKhYxT26XECTjWV3ICtW1L109UogYHsPCLa4e9cJs2bqxmoujcwMhwYVWX7wNDJvegFeo5FINiInlHcQO4a5GSfE0WbmH59bhVSeCaPmY0NGkbxO7dyV8CLrPzeJfWKNDk1WavmqK3vvib8yWsKyIifZOwHYJXffGDVp01l4mU6rI9L+Hiu2+tjjsyxm7kxY4lwpe1hVzFy8sRl+v39jkZQxfcC74/JOBeI2ctVdBecn96E0Qg/SdUwJfWvwzPe9jFn6CWUVY5fXZXcE4ZcZi9b7vtXJid5hBEtWSs6WRInsAzHbn8djt8mp2Ow5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by SA1PR11MB8474.namprd11.prod.outlook.com (2603:10b6:806:3ac::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 15:36:04 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::5670:5b2e:6ecb:dcaf]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::5670:5b2e:6ecb:dcaf%4]) with mapi id 15.20.9388.011; Fri, 5 Dec 2025
 15:36:03 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, Mauro Carvalho Chehab
	<mchehab@kernel.org>
CC: Borislav Petkov <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>,
	Aristeu Rozanski <arozansk@redhat.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] EDAC: fix a limit calculation in calculate_dimm_size()
Thread-Topic: [PATCH] EDAC: fix a limit calculation in calculate_dimm_size()
Thread-Index: AQHcZdfRXG663KnRxEu4656mexaIlbUTJg9w
Date: Fri, 5 Dec 2025 15:36:03 +0000
Message-ID: <CY8PR11MB713404B614F5D046E94DE2A289A7A@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <aTK9mKTphPwuR7qb@stanley.mountain>
In-Reply-To: <aTK9mKTphPwuR7qb@stanley.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|SA1PR11MB8474:EE_
x-ms-office365-filtering-correlation-id: 9d9d825b-e8e1-4255-88c4-08de3413ffe0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?s/HQ52w1A4kN+3c5arAhh3tSWZ0G6ZFsiMX7LU2CGWOxW/UkqDL0lp/ajzQO?=
 =?us-ascii?Q?Ts0cTXT2Wo8/C/y0YQBCGV+rstuyNn8Qjr/4lHzjly5dacUvYlDLbtUJTVyG?=
 =?us-ascii?Q?3KGNtRUzDIlU59oF7ImPEXDQ3kfRrMlEu4eMlhjhvbF7L65ggw0TOWwBL+q8?=
 =?us-ascii?Q?FBVPc4cOts4uI1z9oE6qzlHLK+DspE2CfyIshGCz+MYscGxsU1XLkAyVj7Aq?=
 =?us-ascii?Q?JwY09TOHc4eHgJ9ea/+2QfNCxJNjEIq3JB4OUIdGpb4jKbrNYZZTqabMiRys?=
 =?us-ascii?Q?0tiftXVk5g2fYzXhvB5RV6DcK5BpuuoiPiyc+XT8zUE2prVFaGtb9FtvaMDB?=
 =?us-ascii?Q?KHtbH4AcXLVph1RxJ+XCB2FIimzPoRLjSSLhOx4cKIOJE79LiEP3T3K/N/Wv?=
 =?us-ascii?Q?WvzMnoftfnn9sOFJv7FNJYdjveqX9NbaPb6erM5Al+EKbOwH7b2MrB/ecITf?=
 =?us-ascii?Q?MQaeghOFHXh7bDHyohmxOr3N0syriozTAewn6M7gY4wsI7xXj8a2IX9agGwf?=
 =?us-ascii?Q?yiNC+V1B3tpoIUlNjluRfAWN8Bzy6eFLlet2ff8OSspMkGPDaKT5kDvrbZwI?=
 =?us-ascii?Q?8HateFbT6vAqOQpt37as9vzBqtkbgwF/4lVqCH2VHikGsaCglztC7vde36xW?=
 =?us-ascii?Q?y0oiQcr8/6nkC9tIgUw/PkuyK7Kn+0DvXQwx68EpyAbQ0JVBz5gB9h2ZtX0i?=
 =?us-ascii?Q?pyoryNuy9RXuuIOhGqb0X3UiDK93C4SUOZrBplqbqZCu7Lm3qkbG94+dDjsS?=
 =?us-ascii?Q?Tsmr9WGetR6nDacqd0q3/XmVG4Zlc/uyEp4Am2CDc4qTyPfxdNOn8+efpfyb?=
 =?us-ascii?Q?h9m80RAszePgVEIeagHRfcq4SSguVJPPnSBh781IMefyDIKYRhN2/65msB2E?=
 =?us-ascii?Q?6HvCXAOiHXWzBr0PafqjcUwyWbNMSYCb1S+WcYmTaMKTsh3I0KvXSH8clnnL?=
 =?us-ascii?Q?Mn9mIrmYhBBLhxdztXIrvvgOilYRKnb9OUniMNwqIFT4D55c6PL+Vdll1fop?=
 =?us-ascii?Q?7jJjJt8ImNAFfSkAc8sGotcdixIKi03SlWoKHExMkuBg/QH/TOA8RNPFJkyS?=
 =?us-ascii?Q?my0jBJjbxV+raWKHFNOdMAoq+2ny1ZHvYDed9ogbmOnMdi0VuH6POY2fcykk?=
 =?us-ascii?Q?l5c7F/vUd8hEM5T24721GLe7y0zk+7clvqszS4UkAPrP5XbfLBGgn+WITbtL?=
 =?us-ascii?Q?5xEYt3yDlMkCLJaD2txDGwz/kYRqV37A9GyDpCJ/wt6sQoUq8g1FtrceJK18?=
 =?us-ascii?Q?EsLCD5c4YJwYaD/Hm/vwJDr+vIzE6M+PjT/NJOPOFPb+87QZHFjXaw+nmqdT?=
 =?us-ascii?Q?LkHVOlQVaoPJuiWXDdjradhCamAypxd3CY1VL9ZszKRKdVHfN33F0GnCqxel?=
 =?us-ascii?Q?Fetvhsomh3NYGLiaudat3VJ1PlwqrnpomjAi74w7nkES/qIFp2CEdT2WOF8j?=
 =?us-ascii?Q?aXkNpXYUvllgJqGE+yUOBQj5raH3FRE33K0yQ6sGS9BzCznyu5zPGA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JrvzXcwjoqqBu9/NohM1diNxGnRWAkw9pb3FEYbIH77RykQusc2k98i20gWR?=
 =?us-ascii?Q?+i78HwcdPBqo/TidUBgHNN+pXg41EhXgA6USfoqCa+SF8b7w2iyWKLyrYnoR?=
 =?us-ascii?Q?nfs2ULtF8icPZY4tUrIG2UybkAihkKN3vPhFMj38kgk/Lbde8xBPYTV3+emO?=
 =?us-ascii?Q?EUxz442IC1KdRVqwR/EHM7ckcZkRK/FT+FmyaDm4qFhsgrcFwqTgRd/7H/43?=
 =?us-ascii?Q?yNSGwxpBxBIwBjLXGxIr9ep1f0cyDbVLYcGPNEIk2FLZM/B6VTGK6CgdmIu2?=
 =?us-ascii?Q?uYaMxFgZ4fOjKCgKEQfXSiWTfVUxHv8pcaZp041L3KmPHWXuGXtQqz7gqIOO?=
 =?us-ascii?Q?uD/+NGH1Xy5ZZDADVqVNos9VBlCNkKLMYaWoO6a9pit+EZV3b72sVc5CIHVD?=
 =?us-ascii?Q?6aLIHb0UPzCrzj7Koi+jgIHrH4EHQouty4oRXh4WTkXH+GGXzxmXHFuzq89i?=
 =?us-ascii?Q?KCHHJNwV0jGvcoOVacrP4bZ1AWd5IC4cF4xhGHzGaI14mmvkxkyIOEAkzBY4?=
 =?us-ascii?Q?b6C/phMQIjZzdyLlPMkzNXa8BYTge3LtoSSRekqZ++JcwXJBdiZoB2z1RC6S?=
 =?us-ascii?Q?PqJ/RFSqXeWdetTGABKtonNkG7CK3cUeRLIyKQBsStykGdn9ZP4WSUM5n/0X?=
 =?us-ascii?Q?53mSx2isBt84aEkbuouoGZRFb9YlFWpwyQEf+0n7pm873BlkVhAsE/41231p?=
 =?us-ascii?Q?ZbTU1bvfj2FYyjGpI1ECIeDRs82YCn/MOTBv2A7Pm9/+vbBGfuFQXHTH+8oe?=
 =?us-ascii?Q?K5SmYZpT59lBg/t5FbUBBOJ/fRNBMEp12h9hKjiItIXViPUvYv7wWqC4vJ4R?=
 =?us-ascii?Q?6RiYkv2QXNWcg86wtWL3HcUAQANx8b4NK0os+wcGHABB17fdAveWdTZsqPkH?=
 =?us-ascii?Q?ru7wS2NPNqVSumM5YKNddpsFQBW+PKZk74vt12+l5d6uGP9W1+3Z8XEztCEG?=
 =?us-ascii?Q?gZX4b+2UL8bbkj0PGRRZUP2JZfxSh0erJgwTVyiLNe2lOagS7kMlCu4LCqgT?=
 =?us-ascii?Q?yrnRCEuxGVH6GBlE139BRaF7cP2O0F3xeO020agR0GMOstSjffWZiJ0lTY39?=
 =?us-ascii?Q?Z/47qiNL/RzfqhygkbHAUMWfqxSQQmS/DPursCXBQdLoqetXays6+MWYwUqM?=
 =?us-ascii?Q?j1MWZ0q9Ct+FVIg4aMlfGqHLTLkNpvSnuzkROwJ/IoTmvfOn8cjbfvqCFces?=
 =?us-ascii?Q?0ysrJLApiHI17rHW/cRQbkvuyyFf6gGKTgpz06nZ/9dSPfAjQpCq7mkI7feu?=
 =?us-ascii?Q?pHyEMIwczWmuNK4tFtD+ms3CxQ0mqrQQDpfmmVzFrtUJYV4M3w96sGkb8B7I?=
 =?us-ascii?Q?xrEntJOS8ymxDr81qMQ0qMEa7Sklm6refn0BqA7ZJo5hU7KyZqqp8IEzbt9v?=
 =?us-ascii?Q?WDSS8oe8EilyVYA/0Nr8CW1rK4G+qJtRVW59GxXHsUxSY+iJYrq7Wdi8JaMR?=
 =?us-ascii?Q?KeIFgDKjB04kcT4U07P0+Ahh3y0JpJF7zwg8aFztM00NRdUZDxN/+x41RnMf?=
 =?us-ascii?Q?FHPQjdxYOHY+0OPYUNEX1sKo69QHIRkbewnEmDVFISBOkIB/Ek9oib3V3LfM?=
 =?us-ascii?Q?zYY5bjKrVyAUItbOWTjpsOTlKbW09iUzMRaLBZUZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d9d825b-e8e1-4255-88c4-08de3413ffe0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2025 15:36:03.4827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e/XAMJI6wzLnsdu2rERRH8NxMWVR0WumhUOb/QP9QteCPlZIPMv8y1f0XBvYasthI1sOxEBBNRUAd1cBojJi3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8474
X-OriginatorOrg: intel.com

Hi Dan,

> From: Dan Carpenter <dan.carpenter@linaro.org>
> Sent: Friday, December 5, 2025 7:10 PM
> To: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>; Luck, Tony <tony.luck@intel.com>;
> Aristeu Rozanski <arozansk@redhat.com>; linux-edac@vger.kernel.org; linux=
-
> kernel@vger.kernel.org; kernel-janitors@vger.kernel.org
> Subject: [PATCH] EDAC: fix a limit calculation in calculate_dimm_size()

Please use the subject style as in most other EDAC files:

  EDAC/i5400: Fix a limit calculation in calculate_dimm_size()

>=20
> The snprintf() can't really overflow because we're writing a max of 42 by=
tes to
> a PAGE_SIZE buffer.  But my static checker complains because the limit
> calculation doesn't take the first 11 bytes into consideration.
> Fix this for the sake of correctness even though it doesn't affect runtim=
e.
>=20
> Fixes: 68d086f89b80 ("i5400_edac: improve debug messages to better
> represent the filled memory")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/edac/i5400_edac.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/edac/i5400_edac.c b/drivers/edac/i5400_edac.c index
> b5cf25905b05..81c93ba957a0 100644
> --- a/drivers/edac/i5400_edac.c
> +++ b/drivers/edac/i5400_edac.c
> @@ -1033,6 +1033,7 @@ static void calculate_dimm_size(struct i5400_pvt
> *pvt)
>=20
>  	n =3D snprintf(p, space, "           ");
>  	p +=3D n;
> +	space -=3D n;
>  	for (branch =3D 0; branch < MAX_BRANCHES; branch++) {
>  		n =3D snprintf(p, space, "       branch %d       | ", branch);
>  		p +=3D n;
> --
> 2.51.0
>=20

At line 1029 in the original i5400_edac.c file, there is an incorrect extra=
 "space -=3D n;" code line.
Please also remove it.

   https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/t=
ree/drivers/edac/i5400_edac.c#n1029

If with the above extra fix, your subject may need to update as follows:

  EDAC/i5400: Fix limit calculations in calculate_dimm_size()

Other than that,

   Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

