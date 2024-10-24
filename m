Return-Path: <linux-edac+bounces-2225-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0DB9AD9E9
	for <lists+linux-edac@lfdr.de>; Thu, 24 Oct 2024 04:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04F03B21ABE
	for <lists+linux-edac@lfdr.de>; Thu, 24 Oct 2024 02:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2088914659A;
	Thu, 24 Oct 2024 02:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XnZsWu6+"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C7E42070;
	Thu, 24 Oct 2024 02:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729736752; cv=fail; b=NsGe7N/pAog6sIWJAbLAoSmv7FGkSqaXL+iCfNZOLSwtyMz8C9WfhMVOXXfeeYxMrdPYLZsEhwM3AI5IwzSd6bvdO03or39vQ3cbdovL4YijL8ieb1185tzvGgFJ7kANrZsM7ylcNnnfOJBogZF/NOnfoD+IX2iQlcUH1Uejw7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729736752; c=relaxed/simple;
	bh=d2FPc3SZPuF16EdmFk5K4isnu7gr1v+bkHbSKUP1ZVM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Vkbyp7K7Rb0+zu1vkrURLOpS6nLr2y2tD7pMkKXp1R+fY7HrpQAhBV0MJ0hB6Fe5sAuWprb4soMqDR62BCKBgvDWcWASYI1npGrgFPMfnMewYYH+22Taff5nJGM62i+FBCLhahnEKjQ4sz2KtD9BvDrJk0HuLwrSdWPiccREYQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XnZsWu6+; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729736750; x=1761272750;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=d2FPc3SZPuF16EdmFk5K4isnu7gr1v+bkHbSKUP1ZVM=;
  b=XnZsWu6+DX7Mz+S+I91EjnzP1iRDNiAnR+7NEiqFKLQRqZayEJThu8it
   kxCXbulvgEEr/nNgcepixJQiSy0nzh4jH5Yq4HKku5Qu1poQ94BdEeYwj
   m9OqsHhmOSstEgwqzgKAp8/i3xaSfbDH3SkCe4dAr6dAm2AcVZBEhIb3N
   r25k1KciI1R3zRTXDuFkLi6gqkUxbWjm2+bMfu6Ai1laGyDlIwQNMqtjs
   sqo2FCJr8fh/nGhL5KAQKdzVyEaPiBOdvwaczwC+ufbcOtmJsXiPKUpCb
   93LK07vbFhCbQE2lNEtAIzFJmo2VSsJzHajv22cA2U/JfZEFtJcwCxB0i
   g==;
X-CSE-ConnectionGUID: qtyv9F5KTcK34cC3BZm/yg==
X-CSE-MsgGUID: DbtZ4HMGSruz4V+X3smWsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="29573659"
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="29573659"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 19:25:48 -0700
X-CSE-ConnectionGUID: yFADQP3OTHaslPNMztG7CA==
X-CSE-MsgGUID: sefW19wrQMOK3AvgZaM1ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="117917639"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2024 19:25:48 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 19:25:47 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 23 Oct 2024 19:25:47 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.47) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 19:25:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GrjeshKxYEgsq1FAaMmtklVQ0A4fqeOXIoZY92TfRrUkiBWfpRo3uoEXVsGmT94Vrb0jpnUyBDkRssbCNHFn/8A0lCLS77FChjKTasxm95UM6eM2meTJqm/6si8wh+oMwEDR5+j5tdCQVowv/enDRa0a3A8iLEcvs3ZRa4ozLAFr0w+DPkoGdHBNWuFfzi2270VJwwgV8dtYe7y/t7LgosJLN1msvL/vUmyu76n6ngvJOeIJYBtJjBKrAOMfM7FP2xIu6RSPsMaojO/nUu3ANg8SUVMyYpcywZiV1vFph4xuC8UeOtVROzImOn3nhvOyyVDRS+HXgvVabB2bTz7bZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DbKcolyppu98J5WbyqPlzJgWvRnWCDCXvLhuxOEeFkc=;
 b=Jv2aLrtOF/vJ5/Y5iy3jPt+Hp1ZaFTaKRgXQ8bct81kvKGxU5wuA1N8LmhInzC2q5B2H5ZbpLOGFHnz18HbfdonajU875AWo5UwaVLPRjboLeodGWZmtGKpimoq4k8UL6sGQdo1wyy7qOcnVlVB01f/fiJPHqIoUeAnj622tOoxleliE/MQiSc8YOloQkxs5KoQ7kNkWfcklRyyw1faVvw8QkyWLxsvzk7Yju1XOAtTF63igM01JHeUPoNkHG3k2PUyR8MMoae1SB2EZIizAo/jjtn59T4AMWocdBuKDo/6ETrpfwyupw44tigmnrrBKtPYIcVTF0qPd4E+8tAZb2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by MW5PR11MB5906.namprd11.prod.outlook.com (2603:10b6:303:1a0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Thu, 24 Oct
 2024 02:25:39 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%7]) with mapi id 15.20.8093.014; Thu, 24 Oct 2024
 02:25:39 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Avadhut Naik <avadhut.naik@amd.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bp@alien8.de" <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
	"mchehab@kernel.org" <mchehab@kernel.org>, "yazen.ghannam@amd.com"
	<yazen.ghannam@amd.com>, "john.allen@amd.com" <john.allen@amd.com>
Subject: RE: [PATCH v7 3/5] x86/mce, EDAC/mce_amd: Add support for new
 MCA_SYND{1,2} registers
Thread-Topic: [PATCH v7 3/5] x86/mce, EDAC/mce_amd: Add support for new
 MCA_SYND{1,2} registers
Thread-Index: AQHbJLqf3mM1KkHv7EmkNJeoP5qmYrKVLiZA
Date: Thu, 24 Oct 2024 02:25:39 +0000
Message-ID: <CY8PR11MB7134F53B2F25A5E0EB031C6E894E2@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20241022194158.110073-1-avadhut.naik@amd.com>
 <20241022194158.110073-4-avadhut.naik@amd.com>
In-Reply-To: <20241022194158.110073-4-avadhut.naik@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|MW5PR11MB5906:EE_
x-ms-office365-filtering-correlation-id: 96428938-8009-4fd5-7c7f-08dcf3d326cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?6SaeCPOsinkwj+rNMGZr5QD9jKAsSrwAnypFPZLRV+/Nbt+rxNBQb0bW4Tjn?=
 =?us-ascii?Q?zt7eAzo2pEPUMndFcvAEIeRk3gmtfYHRySV1sqmU7LgtH68hZ5MHd2IFz7zi?=
 =?us-ascii?Q?BmZV+jkqyK4BVwgWdgSW9pM1uWuHcQC2jbUALh3oiQ+UIEBOfI73oJF8pDdD?=
 =?us-ascii?Q?KdcGzbMvbMKXH0eiXxSfQK8J0UPtb5QKjqBDYt2q6ZR1vplnRn2CZR/IXG+W?=
 =?us-ascii?Q?qKCSlW/I3fEzIjp+pDuGTroD/M8M1Lx8Zec2cPaLFEq04nSGdTaSj8R1o/4h?=
 =?us-ascii?Q?orxebzk4C4KlclSAkh1lcgEDb/DL9OCCK64i3DjR4NhhvI5BnFgB/RhCM9dF?=
 =?us-ascii?Q?izCkBvmJQuKg5Z+bqSr5YcRTj4gWqM2rE6ANj1OXmfDerFQXHuAg8XkClUgk?=
 =?us-ascii?Q?8h9vtpZMOw+uptPM3/3C44dgCb9+ap7hA5MEVaQT9HyGjx0KK3HUxB0dt/n3?=
 =?us-ascii?Q?vAmOj5hDnDoH2YSEMAvMmJGINf1qt7p9jrV8MUe43RVoWxIOVqkol3mAhATN?=
 =?us-ascii?Q?TQdksJF3eRSg1Okv0letdtGZHp2Knxb0WhiocV0PBZ26nzrtvsv3atwKG1pQ?=
 =?us-ascii?Q?eDlD1m1PniF+V1dVrf95goVEhtrxUjcHrwh3FjEE6jI4CMJRrsxh1xHr60YU?=
 =?us-ascii?Q?Qj7xC+4JM7lMarNZWNYXlV6hcRr5XW24htHiuojb1j62y8r3flDrFlkqGl4t?=
 =?us-ascii?Q?JAuIW6nDAm8n8mJjN7MIoKtAkRLamPaSnfdDJ/gQlbSAuyIFnMjNmEULtA/v?=
 =?us-ascii?Q?hwi7dYcqA168QW4A6/BQViwjkqrdoTxHYUCxqy+JLIz6a/Yv1dsvH7YKW/YW?=
 =?us-ascii?Q?IpCLIg7aOlXdkIPkTaE7kzDeoRZqRNq+kbrhgwkDbVoxfEt0UD53scNyPwhs?=
 =?us-ascii?Q?wK0JhLoK+/QcMZDBTQkDBgA5/hyOzt4/oHppN7d91Eanur0L8w0meJY38/n5?=
 =?us-ascii?Q?F3T2JWWfRS9S2Gsevlwi82ZWoIQp5wJ9SmJ9C4ux3CN/xfYTY/jYf7pY5MGn?=
 =?us-ascii?Q?mAtLBR2qUYVwfiH7LosMTxy+VhlvWE4+aMFU3L4BoPaZ3z5ZeCTK4VAB1GYX?=
 =?us-ascii?Q?kdRKeQbtIyjymxKHUHRmXB9r9XkPdP6jXs0fd1HYGjH6lYZtSLr9yQfJf8mA?=
 =?us-ascii?Q?aWk8NcU8x2fsEy8T/WiWnV6oQ9KGjwPHClJSAFbod0NBeDL9J0FXjDk0T1WM?=
 =?us-ascii?Q?4f51fbOK3/IrJT+8GCOfsTfu7lnzg7rTXIXL2DwZi80VrQfmmAzCRftKyy1u?=
 =?us-ascii?Q?GTRM5XYk2QOJhNWUGPKDO5EQ60dYudXNyM76ZYDmd4C/Q2FvvCjZUA2qApCt?=
 =?us-ascii?Q?/dZKuOVk1yLmra/p+oxMCfutPRnp5WmwayrNDKtzkaPi1tMPOpDQys4Vj7w0?=
 =?us-ascii?Q?oHxZN6HTDL0ZSfKTHDVqQ2cpSHbu?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0Iie6adeCLGLr0Q7gquEcDIm74DN1vpJ9EWf9+Uat7XNHpxYUY8eShXUFQ6H?=
 =?us-ascii?Q?T6UG7FTOK+sMIWN7PhFIt6h+uLB4L+txf13lHe1gkjUqB8aiycX1KR6Q2PKQ?=
 =?us-ascii?Q?yTqO0a6g3E0JmLGyc8ci9xThVUiYRDgVBowkWCSZYelBxdJMu7akTQStqOgo?=
 =?us-ascii?Q?5TYhUtMa5QcnlGmxzyD0nuxgDVtjgo2Ow3aJQcJOAzfKsqwI/hCOlj2peprL?=
 =?us-ascii?Q?hdW2UmkTKvamuAejDG0dwyKyl85rRViKleVEnwetdmD+hBXWMXD8A7QHk7nW?=
 =?us-ascii?Q?uuCxnaD4EtaPganiQAZlv5Mbn12mqSqQZDNMW8cQr8rD+eEKLztCxwh45Gqb?=
 =?us-ascii?Q?isaN+g4rhv1RJhBarcUPb5E4sQkL6+zDJYTBs1V0teetjcPF/YiZB0FBIzAL?=
 =?us-ascii?Q?xqcvk5xOCig1TlPSV+HVJChwz16xwgf+kmt/hg5jESP+tx/JhjiSI7MpNyH+?=
 =?us-ascii?Q?z30Cswwq1GKtbcm3Z1prPA8ZDr5gBTEiuSDoQC0v9FR3uYHz2egdW3+tQfIE?=
 =?us-ascii?Q?Kd34eeD0lJ/heWlKlPYoLXX0uaainp/7iK64pkDYKHig3QEG81IiKhQ4dEVO?=
 =?us-ascii?Q?bOYzY9yNlpP+3nNcPnLk/YPlcTmv4h+bEebI+PbMKGIBXxGj7tZdG4ZDX8qc?=
 =?us-ascii?Q?FcRI3Pp8X6Bmh88VifKxE6JUAdeUVmPVu5C/9+osXgQpvt80GaOnwiuWydBE?=
 =?us-ascii?Q?gSiF3SdD5jV2/0qDOsv9aiFWxXvQC9D8yfUv+0ErPqUC3qnZjHoI/qGxgaKl?=
 =?us-ascii?Q?X2TM7stDxx2UzmG6BRlG+oRFGiAWuMoAYK8MtxhvHg0oiVulKGKDcJ6MaP6F?=
 =?us-ascii?Q?Niurn2yFZB1sQuRzCIwzJWo14FyDZ4MCycK5j/nAWmHFFN4Ux/iM1fX9Lh8j?=
 =?us-ascii?Q?xgFAtipaqPFQNmhGRQKvPGbQdeV4bFcDmAv7OtoL7GFpLz3mwlEqG+foSmW3?=
 =?us-ascii?Q?JQVbjrvIRCkhaSiXU6URfb0u/9ZKKrR3Uv+fKhSyAjFSyQ70m56dtu9zzLgl?=
 =?us-ascii?Q?1BGBZWzulmULuNsRlQOmn09yIBWixhDa/CGT06qFEUZipRl7Gdclm3Cqn9Bh?=
 =?us-ascii?Q?57MzuXCnQpbl3FkBjSfqh6Dr+JJXJnWbUuOlrnkCikwwvvuQ7Z2NpQrsGnsL?=
 =?us-ascii?Q?QlFKpUqzimOkkA/fkQZMQLoACFknpYVOwcmTzN9KxGg+u3PIX+59/jSRCZbT?=
 =?us-ascii?Q?IDAIIsv2UT8W4HeLiRjPvi0p2L+v6sm0U4jCRg2N44auQd7/IPnRAC+0LqEX?=
 =?us-ascii?Q?Gf8rqcNWkEPllPDPiPc6y+KiixkZRzB6Xy6RjUBCUV3/vsd9Zr7OxUnNIBGy?=
 =?us-ascii?Q?UpK5sZzpUvOMVs7p3Ct43Bv+zwtD7hjG9QFTiAPoYMuvCanSIwE3v6b5grU6?=
 =?us-ascii?Q?njRvxjicX7vfgaJsyB50200eBQrfw2PQGCuDAngO20+X2QYo/UHZ8UY81Osj?=
 =?us-ascii?Q?0/vP8zesQG9sZq8IrQkDGL2EaDyRFS+a1rWFf9Cmfn7/B6c2g0evgUPhUaux?=
 =?us-ascii?Q?Ds7vD+ynecMmwc5WolsYNwmextdDNETINNh0FjzTdiCnX/i/MwNprRkopj3u?=
 =?us-ascii?Q?ZQkn8iyhjAVyL1uKhuTTgsXO92llrbump/nP0f5H?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 96428938-8009-4fd5-7c7f-08dcf3d326cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2024 02:25:39.4332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qpyNuoAlcwurswCbKU9H5MYau3get17swXtEydWui4D5AyC5ADp+y/hRTpYwpfN+awEH3LS7rE3ZyBw3HF4osg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5906
X-OriginatorOrg: intel.com

> From: Avadhut Naik <avadhut.naik@amd.com>
> [...]
> Subject: [PATCH v7 3/5] x86/mce, EDAC/mce_amd: Add support for new
> MCA_SYND{1,2} registers
>=20
> Starting with Zen4, AMD's Scalable MCA systems incorporate two new
> registers: MCA_SYND1 and MCA_SYND2.
>=20
> These registers will include supplemental error information in addition t=
o the
> existing MCA_SYND register. The data within these registers is considered=
 valid
> if MCA_STATUS[SyndV] is set.
>=20
> Userspace error decoding tools like the rasdaemon gather related hardware
> error information through the tracepoints. As such, these two registers s=
hould
> be exported through the mce_record tracepoint so that tools like rasdaemo=
n
> can parse them and output the supplemental error information like FRU Tex=
t
> contained in them.
>=20
> [Yazen: Drop Yazen's Co-developed-by tag and moved SoB tag.]
>=20
> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> ---
> Changes in v2:
> [1] https://lore.kernel.org/linux-edac/20240521125434.1555845-1-
> yazen.ghannam@amd.com/
> [2] https://lore.kernel.org/linux-edac/20240523155641.2805411-1-
> yazen.ghannam@amd.com/
>=20
> 1. Drop dependencies on sets [1] and [2] above and rebase on top of
> tip/master.
>=20
> Changes in v3:
> 1. Move wrapper changes required in mce_read_aux() and
> mce_no_way_out() from this patch to the first patch.
> 2. Add comments to explain the new wrapper's purpose.
> 3. Modify commit message per feedback received.
> 4. Fix SoB chain to properly reflect the patch path.
>=20
> Changes in v4:
> 1. Rebase on top of tip/master to avoid merge conflicts.
>=20
> Changes in v5:
> 1. Remove "len" field since the length of a dynamic array can be fetched =
from
> its metadata.
> 2. Substitute __print_array() with __print_dynamic_array().
>=20
> Changes in v6:
> 1. Rebase on top of tip/master.
> 2. Use the newly introduced to_mce_hw_err macro in amd_decode_mce().
>=20
> Changes in v7:
> 1. Rebase on top of tip/master.
> 2. Change second parameter of __print_dynamic_array from 8 to sizeof(u8)
> to ensure that the dynamic array is parsed using a u8 pointer instead of
> u64 pointer.

As my comments resolved in v6 and v7,

    Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

- Qiuxu

