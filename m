Return-Path: <linux-edac+bounces-4152-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3050ADCF34
	for <lists+linux-edac@lfdr.de>; Tue, 17 Jun 2025 16:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A6FA7AAED6
	for <lists+linux-edac@lfdr.de>; Tue, 17 Jun 2025 14:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFBA2E54B9;
	Tue, 17 Jun 2025 14:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kUhCCj/S"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2182ECD3C;
	Tue, 17 Jun 2025 14:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750169478; cv=fail; b=mbBca7OUOzLbqbTg/kj5/H+7DHO+CAORxBqrYc3ZEpdf/jtH4aiybvMySohn7Mg7+CxaCV6bHUqRomtdXYqKjUobWQdpEm9MAnEzCrq+sJSKoSzuI2RpfWfa18c+5GQrSLJJMKGmI9VuRti/81EBOtVa8qZ1b+muUhtFe7f8HOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750169478; c=relaxed/simple;
	bh=Ey++JrB8lvGPr4EnANGrDcZobPYezWXGRDdWyTZLqXI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AfwnGES4XG8mfAGaOK/AockHrkxDezlL9eR6y62BacLe39Z3SM/5JLVSnxtr8uIFLy7pVYD1HmnkacEH4ogUqZ1ctNu22xO6kCmIZ/wfOImzJNE0wDCvXpGpYt5AHLUh8DVDpUIfnj8sWzoveCcuetztWwgOBoyNPIZcalovpwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kUhCCj/S; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750169477; x=1781705477;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ey++JrB8lvGPr4EnANGrDcZobPYezWXGRDdWyTZLqXI=;
  b=kUhCCj/SWcLjGeF56p1DSOeNeKvaUIlMu7mc9/uEPj7M0COqk9N8mYY3
   TiFWSpt0romKivGttZKX89nLFYv2awy4iQ/ikQRqWpRBWXb3o7Yx+xJKq
   0DUKUdefXDGONAAOt7wGrm3fOmLKup6Y+Qo64Witea210AqTnFXcxzamV
   481EX5IM+bS5VqH1ZwxZt/MHdf11FvbNh8MC+kx11tDs48T4RdmZ4YjuQ
   yOsTzBiFvSyuzjqxGL5HRPBuXRulmJFSz914sbwstU1oFmG3vDhxH+9UF
   kZOeNeUXZ9xlZJCCegazI+FL3Lu4zkDnH+xC95ozTkgbvzOqem0sq9N++
   A==;
X-CSE-ConnectionGUID: 8qoQzWouRECN4HtYelDw7A==
X-CSE-MsgGUID: 5lx3+XwRSb2Q3LlegryJqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="52329722"
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; 
   d="scan'208";a="52329722"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 07:11:16 -0700
X-CSE-ConnectionGUID: fXRQEEegRNm8mYEYUoAccw==
X-CSE-MsgGUID: demrbaxwSC+QDyK/tFRr3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; 
   d="scan'208";a="149336805"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 07:11:16 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 07:11:15 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 17 Jun 2025 07:11:15 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.65)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 07:11:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iJnIHVhWIAlhflOA7VbfVJJSeeKI2445dcSAIqSZWmHtuRlbjNFcHKeUjn7uQuGehaEN3YemzJPjZp3T3WLPaHe+ZqokgNg9KElNY7q6Wt43Pt08fiGmvxX+qMWgJoLmtpIVSmC7IOHrcptJd6vt3FlA5utETLKPOjbxg4gE0HU+B/Zj3XNho/jcst7GsGevnZnUH8dgF9SCe8qECraO36ZnIFLqlobLP/bh+SHEPvaL1YAZAjB1MqQFR04HRSHR3TSEf6s9KeARSSY9YzgsmOvZikeJfIxnxDXTW0fj2C5COpGSB+LJ10qkydPB6wdSmvWSTPyebI2OZ2stvE/c1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ey++JrB8lvGPr4EnANGrDcZobPYezWXGRDdWyTZLqXI=;
 b=AaSrVhyKD0CJ3glXc6lg+nMFaugW7eMUkP3/lcoU3OCiU8Bb60dZ6X7k6farHED6H9wyb3D4mqbT/MZdtOnhqk/uVb8uEAB5NvTJq1Ep3srFL15G2WdxOZ2+NtYslUzZWMqG0vOVGyXimj4ITyfzKTXjI+d+bJ0+N1hMNiTQcBSyrQlgFh1I6TNxVlZ8g6UQsP9omwd74MJLtsWX82cUvw4htZmkQ90PSmRpsd0uwqT0fVO8LQM6p8zEA0AiUOhWqcWGyzNn4cMWJkhs1NSHhR1bfZhT4SCc3DYrdlNdv/U1Usjb0xmjudwESqwdDts5hrl1iMFtbeLF9FmDdV73FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by SA1PR11MB8491.namprd11.prod.outlook.com (2603:10b6:806:3ac::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Tue, 17 Jun
 2025 14:10:59 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%7]) with mapi id 15.20.8835.018; Tue, 17 Jun 2025
 14:10:59 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: "Luck, Tony" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, "Jason
 Baron" <jbaron@akamai.com>
CC: James Morse <james.morse@arm.com>, Mauro Carvalho Chehab
	<mchehab@kernel.org>, Robert Richter <rric@kernel.org>, "Lai, Yi1"
	<yi1.lai@intel.com>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] ie31200/EDAC: Add Intel Bartlett Lake-S SoCs support
Thread-Topic: [PATCH 1/1] ie31200/EDAC: Add Intel Bartlett Lake-S SoCs support
Thread-Index: AQHbuwMURdkl4/rK3EGOxc9BtmhWgbQGPSSAgAFv4lA=
Date: Tue, 17 Jun 2025 14:10:59 +0000
Message-ID: <CY8PR11MB7134D19D81AA17E9B5FE3B068973A@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20250502013900.343430-1-qiuxu.zhuo@intel.com>
 <SJ1PR11MB6083BFB95E228F6CF3BFE666FC70A@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB6083BFB95E228F6CF3BFE666FC70A@SJ1PR11MB6083.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|SA1PR11MB8491:EE_
x-ms-office365-filtering-correlation-id: 6a897a84-d067-4e8c-7c23-08ddada8c919
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?VKOisSdgEtnARsZBg2i6k8usSTv7G1pNxVBiaY3O9swabA+pC0dAwiP8G8Nl?=
 =?us-ascii?Q?nfkrb1jn6IEn+UKJ/C4iVXQDhdNnWYLub5r0t4cc2F/9Nk3j9TliJvzdNneV?=
 =?us-ascii?Q?VP0ihgEW8zKc98i3AZ4NKDPpzB9fSUaJX7De2CReAzCkllrALf+g9BHtbjGj?=
 =?us-ascii?Q?8vIiK23YR9ojwljtF51iGf21aqlnU8vAZzrBZMRmAjQSSs5Y28qu8vYZinWd?=
 =?us-ascii?Q?Dlnz1VS1/ZjObSz6EpNJ/q1WKHKApHt670JDjK8sghvNEfI/mncf+t8WkAL/?=
 =?us-ascii?Q?qJDrjWGtFA7bDt1yt4igVp3M/Ykv/Oz+cDfQNIE+/tGdT/UH2ZOKwZvM5KMk?=
 =?us-ascii?Q?z4ZDfsrYJT6dYJjxuM8OCc7rMh0YvnU5VPxlEoRjL/sz3IRHSCW0Lc2cr8jN?=
 =?us-ascii?Q?9LSiTfmyp8tWLuFm04D8TCRIOoIiuhf5VgYc013KSCnMibsms8k03D0ZI0Hn?=
 =?us-ascii?Q?OpTrn2ueAdcXUw6beVBbBRtw3+wHuovch9zoAAFQUVAnLqZHIX73UqBZs5AM?=
 =?us-ascii?Q?deFu3deAp1G6Mi/3Im1rFfmP/A29wOhc0f7wvQ+7wmoV3aOxpz1E8rR2+hMM?=
 =?us-ascii?Q?Zy/72XYP/P7tIgwISF712/0Q8hPdZxpvRCa+YjW+yLysmr48Tk8ImtaVSSrw?=
 =?us-ascii?Q?5sC+V8e4t44/lbJmWLUpxQjmPjT8YMrgzLo/39OLKr+MpHGeYecOdOLDS/Ms?=
 =?us-ascii?Q?KjfiQ9XMSy4WMw9DLgtVuA/zR+eNyPs+gWSpjgNcElCsh02zz5pGM/k19yoE?=
 =?us-ascii?Q?BgMy1iTShjFZnuYMDqa4+cDrhLarVb5SCak7/JX+CAOFkk58hejCLTOUxz4o?=
 =?us-ascii?Q?gvJk4nMkMak1tRQFgFF4D40VCUi3oEnxGGMyrI+h9qGY6dqnY7oCiAVDMZwa?=
 =?us-ascii?Q?GrLdlDv0NNL2w4gdLXoxsrGUd+CV2hJPl9P6REdudaVy0noqPbAzid73c7ck?=
 =?us-ascii?Q?eF0vxLjeLSuK3U+K9Q0+lBBbAxDPY+Nzz6eFqDIpfq9uvzKwtd8+YDw5cMy7?=
 =?us-ascii?Q?ayQ6RP+f9Sy++LvSd/Zts2rwYuhMMbR+Y6UrzY6NUmJy8F2zGpWuIBrBMus+?=
 =?us-ascii?Q?qtg60I9RrIK9IIBkncPTYUqb01YQjzfADzYuOoY+CGy/Xb05TStFDy1M5/os?=
 =?us-ascii?Q?lgLlMVfQqKeRY4bjTJuOO7qZKsqbmvfqDUlY+xv1VSC40mxZkJSVAVN3gUgF?=
 =?us-ascii?Q?bivTWAG2b7jK5RrLXJ7RlL5nx10I3nYbqjQMWqp2D1nB6sn1/aLEgurI2Nwk?=
 =?us-ascii?Q?rfh7y6kBVktGHgEuX7NYVPuIx+BfeWygh+PSM8k+nIh9HPmKt2BaqqsKZL1V?=
 =?us-ascii?Q?A4IKuJqkO7sarszTCfykWCQEXGFo5g1i3Qwxi4mnOUBIvfSsL5yfQxKDoKxW?=
 =?us-ascii?Q?QgvqmgHroWfrOWN7m/lwbK3jP4XED2+cKi0zT4xMxvRxs+bf/ZwijiUcbGGS?=
 =?us-ascii?Q?g7Oo6tB6AuEDlm+L7Q9mX+flEmLYtPVQDakbWroVxoVy9cWpx9BwLQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ao3denUo8YikzUKn2zQLiNK2v1aijWZGlUxA6LgXeIxZH8fq98S6vCYM5TEo?=
 =?us-ascii?Q?5BmEV2F8lblmhoTHuN4XFwLTDJ+BL7Hqx6YRGmLJL1CcZThVGOT8AYY+R55S?=
 =?us-ascii?Q?j8CwmycdpwLpVfL/o2oVeiLFfRC4rs0PsOO5eUsYflNy+HiZksZThCnpxifC?=
 =?us-ascii?Q?oAn5ABmVo0HYFURrsq4eeZGAzD9LPOnXuRrLnAr/aM0pfNUWvz/Hbw2ki932?=
 =?us-ascii?Q?sGcuIn2NURi0OSkhqg6muGn389i+qEgxOkMSqriXbRAEnq9oM5rZsoDWHwjZ?=
 =?us-ascii?Q?Yb8hjfsPRzH+qZ4OrSvccdyiRZF4R0lxguuvhip4RcPvxJROOVHEGs7Omhag?=
 =?us-ascii?Q?ftIdhKULr1gKuXMY8HsDCtAeev/9QnkHe5Xiqd9NLMjDAaH0h1TU7HuxzRwe?=
 =?us-ascii?Q?Knd50EYWPXZ2pZEEmKrnGjBMnBuJ7J/Wy6pj8vL/TM4v5Xh7HqdVLcoZKaeE?=
 =?us-ascii?Q?kreEYNiFlMLru3VBSVqMbtuBns4FhRWrGYerw8eznygfx9oJBt8cfkc4z7+6?=
 =?us-ascii?Q?92i0ktRFW14fsHP2D0/wlFfHNK3LcnVhTr2hDELrElJE+lHcFcDcR3IA2Wgf?=
 =?us-ascii?Q?TVYziYS4UKZ4A3lBdZFbpHN0mbNwhpjBvdDh+ZGtZT0DRZ1D70wpIsrq2NDK?=
 =?us-ascii?Q?fi3L+ADyHHlZAKWM4/LUVK7rRefXU7wO5jIfpDu4POgAh8xPUfT4Cz59gevV?=
 =?us-ascii?Q?WSLzz8qyI74PQYUb/8VQarEkcc0WPKkN5BuXmdheeKUTn9BoWphVYP8JF6z5?=
 =?us-ascii?Q?mW1QXrqMV/UOjQBgYySunpHx7zflaBVp3stbbq8BoZFCEFfiV6TJdxHHsiwh?=
 =?us-ascii?Q?eTKSGW/B8r/gRgbRbdEPL/mq/Y8TnvWUEnJjkOPFfcyJJGz7SeTgeQMINwrp?=
 =?us-ascii?Q?neq8VjTpLYAMZEL+xBYI23L39rJxELXHNSt7O6B7K7Dn2npPnh18pq1EQuGa?=
 =?us-ascii?Q?BrU+7p+7Uu2cUiH8z/uUcbgqSnlgy/HImWTEk5i3hf2RjoFEBURS8QA1pbH0?=
 =?us-ascii?Q?Cmqy/Kzpw+1H6oAqhVkNwqfauUpBCyNFHSS0YyhWhtl3OI/bfGp9bYBieB+L?=
 =?us-ascii?Q?2wpHGKWlzHaFRdPs6Yc7M4y685Xerp/rb3zXECrwb/ph6F7DQGZPzvm70/iK?=
 =?us-ascii?Q?lI+YanTFexwvWGm6xnpBo72WJVrhSfstAPTGlSNrR3RKufzWXRLG+NuXnC14?=
 =?us-ascii?Q?TR9+Jb3/IB2YlHkxoCr/5o2P8Gufnuo/vnSLx2OzoMhVk1f0CE3QAYmiOF6k?=
 =?us-ascii?Q?v2fEW7vXMfit6fZ9W90AINT6rCt/XSXwQvQPYKDzpF/dqoRliZA85+NZ3vAp?=
 =?us-ascii?Q?Hg8eealtvly1gXxv4r5lnSWbz2x2jyJ38zOOSghQ74rxB+S4j27yYpt9Fer0?=
 =?us-ascii?Q?IxCyWjhm2e8eVwGrjbQhCXT1r5aJUuknDFSHOrzxFNzs3WtOMP478BkmX0jD?=
 =?us-ascii?Q?+7eMfxFV01xAscU0SwKLrR7fAczy+P7IccYgFPeOPVCk922E2wzp8+4LhWMv?=
 =?us-ascii?Q?vIUT7UqQE96Lk0QhXiyo0AEZd8IoYnG8BhQs7oPC4NYSmInaXwy16f/+hAcc?=
 =?us-ascii?Q?s5ck9U9sEXUPAfZE41DbT+58e70V6MdrjDu1XF6i?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a897a84-d067-4e8c-7c23-08ddada8c919
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2025 14:10:59.5898
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vSZBarjlQ7QRwlOyXsxVHPmuCG5r6AbjcDwlXWWqSPzdt6unNqoewjnj7yTNcaPyU79fzB1BTcNCLUEjW1La6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8491
X-OriginatorOrg: intel.com

> From: Luck, Tony <tony.luck@intel.com>
> [...]
> > Bartlett Lake-S is a derivative of Raptor Lake-S and is optimized for
> > IoT/Edge applications. It shares the same memory controller registers
> > as Raptor Lake-S. Add compute die IDs of Bartlett Lake-S and reuse the
> > configuration data of Raptor Lake-S for Bartlett Lake-S EDAC support.
>=20
> Qiuxu,
>=20
> Merged to eadac-drivers branch of RAS tree.

Thanks Tony.

