Return-Path: <linux-edac+bounces-2674-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 564069E7B68
	for <lists+linux-edac@lfdr.de>; Fri,  6 Dec 2024 23:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E77F81885D9E
	for <lists+linux-edac@lfdr.de>; Fri,  6 Dec 2024 22:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D941D1BFE06;
	Fri,  6 Dec 2024 22:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eGEoafRQ"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E2922C6C0;
	Fri,  6 Dec 2024 22:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733522988; cv=fail; b=scvL7HpqHzcnnVupzBTsudog6IweFRVkY73wjKPOgkcNKpSNdwSXEIJAC1DejfgDjZ8/s1vSOsRpbnYlmFHmyIaFlIi+Cc6KMXm1xikGZvkweHC+DY8SUlZ94WE449XhbyZY2eGk2ifuHhs8DWXzKvUe7mKiPX9UkZwdUVt8tlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733522988; c=relaxed/simple;
	bh=jhrTktiKZlv/oMLe+0ucNQzHWM7i1LI/E0a6mDgEAC0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o9ZLjVfb9+e/RjFw6Zesn99IDNEvCWl2CEADz3plt1v/z0mgUEsXQWC5jiyroqNinXZb5Ka0isaTl/OYtgHJ+okKjPpsk0Vyebv3ZN7sUfWCm5gbPrOJNBKzqToD+moSLXA0HNUb8VLN0HMyPtBddcgZPF5c+qYpY6pFBvmlBi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eGEoafRQ; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733522987; x=1765058987;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jhrTktiKZlv/oMLe+0ucNQzHWM7i1LI/E0a6mDgEAC0=;
  b=eGEoafRQAVJg6n47FMFIi4W0xMhoFuIBR/wPllcrxtxZ0HGSy/JNHtb2
   5o/iOp2SB3uux2P2pbtaRdMyg39hJLwbGn5KIKgc+gdmFQ3juc3umgWqy
   TttesQE2q6Fwf2VMXJgw3Tw/RNwcSkhJBhwwpIiGb5VGmYSJ92mpwAj7J
   Vq7ZkNLnAu2OGh4dascPTjVrq7MkskjewmTojw1CBl9iSJ2CiSSUPwdDA
   6ykPZd+NQ5Up83QdHDSzt36wXX0uPRqg7E0rIz2NAhVAxfc0SyaeoFSrL
   9pekyjtoZM4pe6QbTmWZ7P+k3qui6K/LAKfZblgiNvM1eAZJYuwWk/lPD
   w==;
X-CSE-ConnectionGUID: jee+n2VoQU+Yh/NDfvlc/Q==
X-CSE-MsgGUID: ATtDwIlkQImXxt6FgzLtSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="51307490"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="51307490"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 14:09:46 -0800
X-CSE-ConnectionGUID: B2LWrpdUTN6GgqeXGXib5A==
X-CSE-MsgGUID: A8SkebCsQ+mDW15UDMGm8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="94611966"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Dec 2024 14:09:45 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 6 Dec 2024 14:09:44 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 6 Dec 2024 14:09:44 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 6 Dec 2024 14:09:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E8ZHPfJsUbVxth/eBModOeNnZiHhahUEVkGYr9vvqG/YvzbwJHf9JXDI99fD3LGFfsFoSjE9ZYZM3PYVfXRlwCWyFxTEE8oLUI8cB4Wu7I1uYRqLsp4wdANLzzd3EiBJkaNc3pM5kWsAKcPoAoPuaWFoiumzvbGSeo+COG5RGGC9AHOY9Zdt4oovE5ek1w9CtuSGNyPOwXZQpYEu/dPf3GPQWx5HFhLiVqHZV5Pgne/NI2ITyho+afJeUeGxRy828tgdM35cwoR9ZVtWADdpG5QslaZhSAIJ88lVyxRPUd1jG9MlOrTZzmTtS8Zl/5j/4bGVZMgbzav/BUCdSuSCbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jhrTktiKZlv/oMLe+0ucNQzHWM7i1LI/E0a6mDgEAC0=;
 b=irVSWtChafDcPwyhFInny9p3UFj+VK4XTdvY89nCEdIan5MxwjkljYSgBVF4HcVMAXH7K2PxdVGOv+g5ubW45LoqrMhl9I+j9R4UPNSMpw2begHIX47uXPzv5DnU84ZiMueC3OmIKOtoXQ7sC8HOfpKgZH7OITHzTOS2zjwTrlvat3Se/SUr0KHG/bbaAriw5rM0M8hNJsxJmsBdOueUvNuaWp0TduTfma9eYa0Mqu4bOOi8uJxDLJqUi7CAkSSg51JOVygEWH6HYaa+88E4iK33046jXXfcXhbytEYke60ZVSbFpOdB55FEXgRogdaoHKYT/6sRTxetij3kWlT1bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SN7PR11MB8065.namprd11.prod.outlook.com (2603:10b6:806:2de::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Fri, 6 Dec
 2024 22:09:24 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.8207.017; Fri, 6 Dec 2024
 22:09:23 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Meyer, Kyle" <kyle.meyer@hpe.com>, "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
	Bjorn Helgaas <helgaas@kernel.org>
CC: "bp@alien8.de" <bp@alien8.de>, "james.morse@arm.com"
	<james.morse@arm.com>, "mchehab@kernel.org" <mchehab@kernel.org>,
	"rric@kernel.org" <rric@kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] EDAC/{i10nm,skx,skx_common}: Support multiple clumps
Thread-Topic: [PATCH] EDAC/{i10nm,skx,skx_common}: Support multiple clumps
Thread-Index: AQHbRzdYr6wewCl8WUSfAZZpbFHGCbLYE+DsgABRaYaAAAfzAIAAEs4AgAE5QuCAAA54YA==
Date: Fri, 6 Dec 2024 22:09:23 +0000
Message-ID: <SJ1PR11MB60832217752DE71A4ED1054CFC312@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20241205165954.7957-1-kyle.meyer@hpe.com>
 <Z1H7U9-O2LdAoa5r@agluck-desk3> <Z1IHkBlm_0p-0-c3@hpe.com>
 <Z1Iuk-_VdmZibOes@agluck-desk3> <Z1I-A0Rhc8AHhvtw@agluck-desk3>
 <Z1JL7fevweCQtTnT@hpe.com>
 <CY8PR11MB7134E24098C6E16E43C57EAA89312@CY8PR11MB7134.namprd11.prod.outlook.com>
 <Z1Jieg7ACUMZLsF-@hpe.com>
 <SJ1PR11MB60835F7CA3BB0430A4B116C0FC312@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB60835F7CA3BB0430A4B116C0FC312@SJ1PR11MB6083.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SN7PR11MB8065:EE_
x-ms-office365-filtering-correlation-id: 320b0b85-369b-45af-3f99-08dd1642a438
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?uNZOe8uUd2DAd5my7C7HcgIbDwR23Q7X2tl+wsFGDfYBXyZcSz0If1Jm6peL?=
 =?us-ascii?Q?bdZAJ6dOj1k9bO0zcuGI97BITEfVU0EcjDuP0aRlgsxtbWg/3oRcftdyDzlO?=
 =?us-ascii?Q?9D9l1GVPZMDlsXGXHhJALFR1uxCL4LSfWEVqfqEY75WVNI5E8U7tzD2dlnQ2?=
 =?us-ascii?Q?7S/3Vy+gSeAvyMivWTbPymeNH4napbe52uxEnA/dHZePLgxOY7qII62jQmT/?=
 =?us-ascii?Q?73yTS5gCCWdOItLEcOSVB+HEE1HX5+s3q1w7jaVcw+bSTTtT/f18o/qztk1F?=
 =?us-ascii?Q?A1jsh9EUXP1ixt/bwZDQvyUKpPAAOd9F77ixRODVrw8K/hjRlkkx6VU8y553?=
 =?us-ascii?Q?6qah3ZtUwh92qpaOeyZ1AUv4xfCp1U8RxcG6Vj48SMH9eH5PLNjePeVhaPK9?=
 =?us-ascii?Q?YWZSXq9bfFZqPHPtYNLP/BEegj6/CDEA7p7r0CptAgxDCZ8mgAKSUpHfG0eb?=
 =?us-ascii?Q?V7MqXJgEcnrk58DPNtTgdqX+BM0SWP8cQBAxqsHuUzZQtyMGQY15Bzu50geV?=
 =?us-ascii?Q?z2R31GDP0EG1JkHUa1rCVc7fP7Tl0GLGHI3LKeq79/JrIzWP5c/1naX4BEAi?=
 =?us-ascii?Q?VukTMWtGXGoVF+FjBvbI0DTVgysoNLL+wUPQsPDpKAJtt/i2LV65+zRSxNiB?=
 =?us-ascii?Q?nTYSWpf2mgOKHEI8Ga4wG6crYjkrPtriX3go+goBl6bLfyCk//y+kgAtXUxz?=
 =?us-ascii?Q?jobX9z80r92BApjnOkMQYcXGD1bFuXyT8tdnuFkr7w6pQ8vk9Vs3fKDQ5bQI?=
 =?us-ascii?Q?vfg4xEqM9Lzikf0aqXkDiXXHOE9EfuYcwaNla8e+ze+JjBdHQQORIYE+GWR9?=
 =?us-ascii?Q?yFAONYb9mLCcxdBYSRZiQv+BlK7SA16ooO2tY8T5KtFovuwRSUmMgg0ec0kQ?=
 =?us-ascii?Q?Ov6jENGbTSfBU/AbCZqaul9Rl9fohZTjD+CKqei0qp5SczxOUOB1NnYSiJF9?=
 =?us-ascii?Q?xJQlU+z8rYj3pTlg2VguCCr9SyluEZO0MdIok+ax9qbnb9AdwZa/Sp7zMNoQ?=
 =?us-ascii?Q?imEiMKVUO0z4i+WVM6mJiMQSv2VJDQS5N96wMdRzudmFT4v6O0uslHMqt37I?=
 =?us-ascii?Q?u8G0Dg6xmjyLPnxZuCXcbb2l/sT7Q5o4meDjPww5kQcX3yFEuHDMpHhzugNZ?=
 =?us-ascii?Q?w/nSugEH1+4CIRgFwZt7V3XqVDBqJisi71Mq19yZsagz0YVlqK6CydqQRHLn?=
 =?us-ascii?Q?C/kqhu853DCAEMGa7KyQ5h0Cs/noIr1QcDxGasOvHVctRVmVt8UWH8WsSxbt?=
 =?us-ascii?Q?651FRZdHfddg4gyoGwXKGBvfBvXT0nOyDfioiFq+3hG5LXUOJ2gs1he0lcnd?=
 =?us-ascii?Q?oE0uwuQf52gffbiOK8RrnE20kV3mRCffY4pF5zNaRnkqdXQJZnBl//CpfYre?=
 =?us-ascii?Q?oCBN86ZdqRkY0qBNYADeN65iSoq9damVbpkwfZ/s6h66q8DxmQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SnNI+pUfaM/FUBzihcXU/v6LR42t4cwP6sP2G79NoBvyFN6I7Au+sarUoYwJ?=
 =?us-ascii?Q?X0BDpkmTh9IAtUqM47tAqjiRvEgt2dWsoKuq1N+S5lx9lYnUo2c7XwGeRyKW?=
 =?us-ascii?Q?j6MPWjnO8/qdhFMbypkdY5b1wU7iriOiuF4tJ+4eqdgpohCCtR+Pw4qZ3uGJ?=
 =?us-ascii?Q?2I5lWTi7nS2OnS+nAMvEC8MaBw7izl+lDsHqoUdxHMJfBp3pnlFJTQ8+In/2?=
 =?us-ascii?Q?8N4s6KcQfClZkqpcHHzHhpRKWHyBvJUuyjfocKUYOLHfXViV6sqURztdnuiA?=
 =?us-ascii?Q?hXtRz/TICp7kYacCt2udZIMISC2RzjSqHuQoh2K3V2bVsKqiOrJEIK2V9g7K?=
 =?us-ascii?Q?5yr6/xV33S1mC/Dd5k8SvWQRsCCthHZcNKct8dlkVtkqusmjILz3eZpuy2Ja?=
 =?us-ascii?Q?0BfoArT7hj+1DK+u0aEkdPRVy/2GLGt/c6radyBj6YjXzHFaX4WRnaUqrcnC?=
 =?us-ascii?Q?ucslXRKdq/MNVnpdPMiNzRKBY86JwHtH2TJkI7+0kwxPS5WwW2eekbLr+UQL?=
 =?us-ascii?Q?l1OurHKBxw2HaeZJMRR3pORPmH1dk9rDqyLLTZtAlznRyWYWXNy/XS/A34m2?=
 =?us-ascii?Q?/HVQFDebaUZ6FYaMomiYv2/X0yDHrelcLFxoo0SRrrNPJgtiCMqRCr8CxnUl?=
 =?us-ascii?Q?7HSwamFdq8G7KeSqLBTp/HNuOX6iK0QmX5tmQUE+Uzh/1tg5jOdbBIVhVyum?=
 =?us-ascii?Q?vxXD9potIcXPg8hpBahBgETnSptgFNy+cqBmV53/mIkLtib7YwZdRk/f8T0m?=
 =?us-ascii?Q?va76S0b4VXvc2SRUmU+BwsDh3zjbVa3WAsQiW3wrugfKNfFqmUJEI9dhlOXv?=
 =?us-ascii?Q?xWOoOGsFoi0sUF0vk5j+hPlPnxIV5Az8ClSMsukWEWRxUezj3aYG9HPJGg+c?=
 =?us-ascii?Q?BwYsyJJ7o4kFpojhxvMUTvqm4uJ12f3f0XGY5PhVUDaDAvGRUmel6oNYWL7Z?=
 =?us-ascii?Q?Ykyc8hzmQQenwb4ypP4ZzuyLKopm/KT+3fb4kBi5MVWLpwPpqQcI8LeAHRTB?=
 =?us-ascii?Q?9uoFRlYweX6vJbHapmfVDtms2HmqYCMj7oUV71Rl5spgwrTg3Jg5qtvHo0ep?=
 =?us-ascii?Q?mMWHja4jupAj46FI38Ym8tWdy7I31j2Bqf50qjq/s+RFaHPeEU6d/6LZvJFH?=
 =?us-ascii?Q?RNrXiJWbuTjzhEWkGOCEvTFLUK0FBN4oIfpC5BL17WUAkbl0/GdeGEqWUgkY?=
 =?us-ascii?Q?Xd84hOVthFyOwhBSgavqa8HqMsFoGU7ndFv5mTlRilKF0mFUtmp2XTQCOC1Z?=
 =?us-ascii?Q?MROVKytN0xQRFesDupaWcxf+LjxTxixRl8RGjbScVCm7ETfx6xZNGWjPHmZf?=
 =?us-ascii?Q?9w8q6di9XkGmpKnmrf43IahK9mWvLTJQ56zwqNi7MuKWLKUfjxBYoDaj5iQZ?=
 =?us-ascii?Q?ZopIcJHa8Dzj4jd+zng6j/pAndWEZzNS5Q5c5ZQQv7MJ/S5oHGssVcTG+VOY?=
 =?us-ascii?Q?IKiABMw21eQRx8jbaz6WIPAdPzfOpRtE5PF20/2FKFpuMe2zmqbwUp1Y1lIt?=
 =?us-ascii?Q?AtcTHuP/fVBNwVbByuTaeIM8KBE4TEpF1hyauJsSAncEnUxgbQSIwftjwK1c?=
 =?us-ascii?Q?sdAlYZL++PBBb3ErOlQ5LajBMkzqvCm7bWeF3jtf?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 320b0b85-369b-45af-3f99-08dd1642a438
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2024 22:09:23.5004
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2ZdTn4NgpHOCgO/pps7REa16zAN3rHmm/6KkBTt0In1Xnhbs5sbIqRCwPKkaIhWIYN32cgUiPcDecVwSTsPwVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8065
X-OriginatorOrg: intel.com

[+Bjorn]

What we need here is a function that maps from a PCIe device to a CPU socke=
t.

Has this problem been encountered before? Is there an existing solution?

-Tony

