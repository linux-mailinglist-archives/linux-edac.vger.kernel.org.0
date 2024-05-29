Return-Path: <linux-edac+bounces-1153-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DC18D3E4E
	for <lists+linux-edac@lfdr.de>; Wed, 29 May 2024 20:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8D72B22324
	for <lists+linux-edac@lfdr.de>; Wed, 29 May 2024 18:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC1C15D5A9;
	Wed, 29 May 2024 18:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ch+dPhXv"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534EE15D5A1;
	Wed, 29 May 2024 18:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717007244; cv=fail; b=XLQXiR1sTIEPIyNzmkJoKJM9PP0R7FrqjEoVwiurrJvufgIyAO9j12S7B7p4aWQ78nA4cts+lwDobtk2EmRxgBj/uZlOYs3+qY2ssKq58ZGtHIczCABsi1Pelf9ZN8/bxmzAsV1N4fsCZqkAd1SCnJpoB8xKhwOiIKE0dYdHpd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717007244; c=relaxed/simple;
	bh=0xR3D8aBiAWxBB2kZrWLrcoVOkdtFJLLXZf02ECH14k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EsILnAVXuagcVFA+W11KPLN7dBsZxyDnhgc9u9OockR08DYa1JYBzBVRhkPDjXLK6ORCuFUFKaurvueAT/m4X0l4Phn7UltUySuN8ol7d7k/OPLGr3cIlBTDfH+bwo/AuEDW5KsEAcouC9t7ogqtFqTTc72croo4yTl5nNdKI6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ch+dPhXv; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717007242; x=1748543242;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0xR3D8aBiAWxBB2kZrWLrcoVOkdtFJLLXZf02ECH14k=;
  b=Ch+dPhXvhQDHcLxSvU8VqqucnFKec5vZjfALar6bddNAGJThc0AU7ucd
   msPhvv855RI1WUWaMJKRURPFIXnjtfHMUTzwngtWNdZ8QWe0bBjWdHKId
   gvbBn/xQw2yqWqnBcjr74M6YYkTPPIJoYcAY/nRNd2aO/VezlyN175ss0
   tQz1l8XQ0uRmX4Vxky9r86HFsUVgqYrUkwRfhw2dQEOZ45QVnkAl1u1lj
   oqASIB1AtRcuqWDdRpJrfTUlBCCCaFFCiuzYcFs3COuOi/cpd1nt432pu
   P+20z+Yve8cmKl1iWnRcrcaQab4P1jRsrdQZyCTO+j21h+AnjARJbzfRN
   w==;
X-CSE-ConnectionGUID: 41wWr0pKQmGK92uZPThwUQ==
X-CSE-MsgGUID: BZUtln6FQ6W6nfaiI9Qhzg==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="17220377"
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="17220377"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 11:27:22 -0700
X-CSE-ConnectionGUID: Or65nFyeQdq12p7bZ7kHBA==
X-CSE-MsgGUID: 2fBQ8q0CTwuqbdZMottK6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="36075685"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 May 2024 11:27:21 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 11:27:21 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 11:27:20 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 29 May 2024 11:27:20 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 11:27:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KoEF566MQjPv3FqKUyjhLgbbbNnNXbSvEknQRWUYK9MP5eC7b7rja12vEl0SR6sJzPpML9oikLnEHIG3L/Tsb1n7YGuIMfy5F4PqNSubZ7CFuFQ20SsyYCgDh80OXA7Q0cCTA5EmW3mdPTHIfIp7q6PFruTP7+0cHU+bCntilWfAODM/IAM6N9E2qouLwIiLsCBuihSCjkn0E0QROzK5jItvisK7F3fSlQBfpwEwwLI3n7iuSQoekAMbXGFKtqMdarwsy5Gn7CG9bJzQyhqYxgHQDqwrXQVEysKPdF1pNXkDTp11QysJLyqWcvGd4wta5yqwLJIqP5xixdcBJIZorQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0xR3D8aBiAWxBB2kZrWLrcoVOkdtFJLLXZf02ECH14k=;
 b=JPNiozz6toakXWsJflRGhJueLoKT7mhhBRchBxcTtcUOzGkj5N1YAVhSSgaFWHD82IAmiX3nwlowYIjvyqmyq7jRik+2377JXRFoTiEbF7tIolhwkETJjUGyrrYsYXW+tlhZiUujeJmHcvNyXpadoO8oE8fka6OZEeBQIzmNTDB6WqsKMkLbytAvtHKNQAfvQjh5+fJtK1lpHN9qEXNjoMXjMQT0OMvHhhsbBVbLO4T79wdJhiQOMd1UXuaAnXjqRphJCu08P8xJleegCJwfNr4QAQpCStVQreeKkbJrprk0f2y2LwAfv2fHReZoAnIYBFF/EgKy4u8eafcBwV9YWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CY5PR11MB6439.namprd11.prod.outlook.com (2603:10b6:930:34::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Wed, 29 May
 2024 18:27:18 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%5]) with mapi id 15.20.7633.018; Wed, 29 May 2024
 18:27:18 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>, "Borislav
 Petkov" <bp@alien8.de>, "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
CC: James Morse <james.morse@arm.com>, Mauro Carvalho Chehab
	<mchehab@kernel.org>, Robert Richter <rric@kernel.org>, Marvin Lin
	<milkfafa@gmail.com>, Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, "Sai
 Krishna Potthuri" <sai.krishna.potthuri@amd.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] EDAC, i10nm: make skx_common.o a separate module
Thread-Topic: [PATCH] EDAC, i10nm: make skx_common.o a separate module
Thread-Index: AQHasa3a1dpIalxTtEymaZnJ+xR+PrGuXnyggAAGvwCAACInwA==
Date: Wed, 29 May 2024 18:27:18 +0000
Message-ID: <SJ1PR11MB60838EEB95C84734E7F3C5EEFCF22@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240529095132.1929397-1-arnd@kernel.org>
 <SJ1PR11MB60838B76940188104D57E53FFCF22@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <e526fbec-5fc6-4778-b46d-608744a4d7f6@app.fastmail.com>
In-Reply-To: <e526fbec-5fc6-4778-b46d-608744a4d7f6@app.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CY5PR11MB6439:EE_
x-ms-office365-filtering-correlation-id: 08d160fc-806b-4c40-49e8-08dc800cf8cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?jnrSiSMlW7m9HQAxXXOxm+PFW4htPJTDuBwQiiYqDEL0qo5wxBd54F4aDut0?=
 =?us-ascii?Q?eC3//ntbpqzynEXe6ZoE2yqIVqE7q9fYHOtRiQ034kM2vygsxr5MZH39APs/?=
 =?us-ascii?Q?7D76nJ8PnUw6qu9HQlpJdmqFakrnkZHSVfUwyGBYkBSDateMq9donQs2I+BN?=
 =?us-ascii?Q?zfsIUPvoXmLqpppo+Yp5HB+beC0YyH0C9ydreks8yELrz9lF7xhITSTNziat?=
 =?us-ascii?Q?HQ/UUeGMZ294N2V60v16qF4wWqv65W/MUPQi1XUehntfhHgBA6VXeNvYja2h?=
 =?us-ascii?Q?54mKTai4yluPFj44oX5FVGi9HQ5wY7AkyIt92EEo7LiRdB+g+SQ0gPJGDKeN?=
 =?us-ascii?Q?RfiOAtPK9R1B7CpfobPqd9Vhr/RRF/h6ppq0xlkDZvGr5qklD2O/D4J4r/yf?=
 =?us-ascii?Q?pjZPNYovyj3iW+DG2690N1QFZcLZqnisLmf4bQcOxewQ6eP6gpQ1XFBkwGFW?=
 =?us-ascii?Q?CdEL9O8AT9QvfTtIrLifR5c83b4gNSwKoTZCbk8QIAG2Wd7moxHVg3uOxbl5?=
 =?us-ascii?Q?tziafnW0A3T1FNBnQUm/6bYJKt5hyrIeoaimW35S47CphxSIvE4Tr9sOSU2S?=
 =?us-ascii?Q?jChYFK4BBgUqETBwdIJnSaO3noPn0xkqs4nj1k8w/8uTfU0oh/l73QaqioHM?=
 =?us-ascii?Q?lAeX1ngAilj68ZrGhttyLQ2jnfNT2lrCtPPD/hoSpLYdBl/BEo+NJc60EXQ+?=
 =?us-ascii?Q?6sFes4QPNWHxuREm0CokoJE7CWV7cohJaoDN0UK3WnEMwduu9VLVolii8aWc?=
 =?us-ascii?Q?x2HhwEI6pORUO/Omzei+OPylii9Jz9at2kvvGtQ5YgIn0Ygz30CgQO1Z4xnK?=
 =?us-ascii?Q?4PWo87QT3Kv3+Y1fg3nyTwHZm4hAkXFR0XBWTMsyFr7lokxm5iwL7HDO3UBP?=
 =?us-ascii?Q?/Itqv0km8wREcGWC3lzErwZJlSqaMgIjDPAhdTG8afPPAMoZg8U0j+Czo1oG?=
 =?us-ascii?Q?ciJ2P+YwWFV4qFqI/OusjXkCyGzskT8eWBzYt1F+y9tisM5KbBexdW4CtOto?=
 =?us-ascii?Q?9blMqEJxohJZOz1rRWCql8Df11fmCtIabUqo0uikDOfAKBUQ9T095zRlBYvi?=
 =?us-ascii?Q?RfzwFTUQog93UEleg3buMCEP/j+ipBbt9QLnQdIsLPXJRFQiQ2nnj/M7012T?=
 =?us-ascii?Q?KcHY9xaojHa7ZWZq9JR6GPbKDQezxQDciiLeiwIa2qGC7U04LQUxI3eXqJhe?=
 =?us-ascii?Q?6XHwEIUPgFLlFTzjihw8yT/LJBcFgQ34uAhjHjoqFvFKb8HuhuBrGvS99n/W?=
 =?us-ascii?Q?E4ardFfXqEKB6ctz1Dh9um6jDEH/d89qD00wcm569hzKuQvMwA8keXEDtOIg?=
 =?us-ascii?Q?Bc2LOo6DemR+v3+P/ERqaRNxMrrsM6RLgxTeiBhiFn4FCA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?85ErwuFV+9vhHddIYIfiVrBuB/5aCoCOjs++f1XVA1d+Ck8sP1vXNNaa+xMn?=
 =?us-ascii?Q?Z4HFg0mydFduZ9+9XfadcJgU1Zjy3R5FfFy5nJvqXUzMGx0vB/EXllrnCwF7?=
 =?us-ascii?Q?qgtEgVrLtYb5SkYxDZF96wsd+Qdan9oNNh2iYuE7C0HoK0hWA6Ry6Rv6Fr4t?=
 =?us-ascii?Q?NEsxuGhunOf6ih01md/WMovU+t8sFOfyEnDhn8A1eMHTPs/2VsIpD+KqDimx?=
 =?us-ascii?Q?Hp9utvz7RMdZEZyLA/6LSVk0a7xzGepqXY5tX9t8iemJeCAOZrwxW8BmDeLa?=
 =?us-ascii?Q?eOEfec4MdDasiezMypFp6mM+7ixDy2lUEqaD3+B1oaTKg/cORxLaQr6mYuP0?=
 =?us-ascii?Q?cHthBiBwv1FGSXGkinH8VjXwAlNeNqIcCucwXXD7BvprP5axvJoKYQcbcUg6?=
 =?us-ascii?Q?91p+ulnlUgDWKiTs1VRKPv5K4IjwfXfJDJta/ev+nHpBKfBfxaUccvL+xm0+?=
 =?us-ascii?Q?xwOvlajD8gza4+8kRtDgFxecrRasy201/Gq4smrBxCIj790gZpBCWzC61rrk?=
 =?us-ascii?Q?2k05qvdu2Anwd6EbZp7a2WkT0N4J9frvsW9o9Th3de9iip95lrSXco85MNW4?=
 =?us-ascii?Q?j14gNYKOitU+mSzq17yAr9LFVz1v8Tacg7D0KIz7qN5GXILrd0mrr76kKgea?=
 =?us-ascii?Q?nqSpPU+OuCYaWTmCB79lcmvR2kO2u4q7psF7vFGLqEdyfapvHpxw6QfBGRTr?=
 =?us-ascii?Q?yfkjlrWH0XX4zGBjhhpa6boQzB3hITcALpCwarW40yMX7lu2iBJl+YsukWlG?=
 =?us-ascii?Q?q38UobZExbgTNetrvhNayzXBn1CIod3cIhQPEt284tCPstklh0VPxK/d6xL8?=
 =?us-ascii?Q?ElMLobDs8r0jo8K1P0+0V+Q/BX8OuBh1cuT8/Sc0zNnZztqQ1qQjo0zS8JIE?=
 =?us-ascii?Q?ozjU8RxGMdfkHHY3hTDmZESqr2OFmKU1CG+A+6+mocfH6/+QSahi0zBdp4X1?=
 =?us-ascii?Q?ND95AyRLnroJ61i5/9Qqxbp1q1wKdXFer1M80g7W9nl5IgSvzUc2KTrxYvnQ?=
 =?us-ascii?Q?9Bwb2pKPcn/e3Eiiv3qIYSzHTsVIxYVp1IyrBWruB8YXbZQoYeSCOIuWZdkf?=
 =?us-ascii?Q?xiwsQCO5XbUpSSqKWXyHokvYtbnOKSHdu6Pc+YicCf8kpm94ZX9EAHzUm8Cj?=
 =?us-ascii?Q?3B7ieSxGmeIS6Mcei3sGHKerhklixl+4U9V3G5D0COacl3WisJ3bFNrHJzJ+?=
 =?us-ascii?Q?YU65IosLL5i7CVru81zzoqI9ZtOiDjunw97O+QoTZ188A5TcpTUtvXR7CzhH?=
 =?us-ascii?Q?DvPn7VQrevI9HB0URnXi4z/f0eDYi+AVv1MJOaR/DQR9gb9q6vpWSktRnf9f?=
 =?us-ascii?Q?N4DcW/uCJ2Iy6UfSuU48tl2IcUV4+G2hVV9aFOIVRD2Zw7jYJNI5VNf7jIXf?=
 =?us-ascii?Q?9HXeKjFfS9i+p0VbjgW0D8+vIUA8NOw8RIc4iKT1Fw1nShTO/FmbT9D7ZTVD?=
 =?us-ascii?Q?7zdnxBy+b1Ple94s0UVqevUql7XhrOpZKZSCUnr5DZbjDvoK3nDDTN8V34i6?=
 =?us-ascii?Q?kcENafFnlu3AZ2qWadX57sbXHicFh4x8FpC6rDAK69FaVD6pndie2Ezea6FW?=
 =?us-ascii?Q?x78M2SSy6zKlIDNRRPkGH3M16rdnSN7Q4wpC6l+a?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08d160fc-806b-4c40-49e8-08dc800cf8cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2024 18:27:18.1664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4AO1egknS4gS8OuHzukCUXtRgT183YlljVRadiPaAKy/HrD+7JdlGArdLDqXm2ufIUSplVXMR1q1QRz/Suw+Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6439
X-OriginatorOrg: intel.com

> One of the problems here is that each compilation unit implicitly
> knows the name of the module it gets linked into, via the
> KBUILD_MODNAME macro. If it gets linked twice, the macro is
> wrong for at least one of the two, and this can lead to
> incorrect printk formats and other macro expansions using
> that as an identifier.

Hardly any edac drivers use KBUILD_MODNAME. These two don't.

> A particularly bad case happens when one of the two is
> built-in while the other one is a loadable module. In
> this case, the module infrastructure assumes it's always
> built-in, which can mess up e.g. __exit annotations and
> THIS_MODULE references.

But that does seem like a real problem.

I took your patch for a spin on a system that uses the i10nm_edac
module. Works ok both when built as a module (the skx_edac_common
module was autoloaded) and as a built-in.

If Boris has no other thoughts about this I will apply your patch.

-Tony

