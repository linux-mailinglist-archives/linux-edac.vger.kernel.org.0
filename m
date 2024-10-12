Return-Path: <linux-edac+bounces-2014-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F31B299B076
	for <lists+linux-edac@lfdr.de>; Sat, 12 Oct 2024 05:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 219721C20FC7
	for <lists+linux-edac@lfdr.de>; Sat, 12 Oct 2024 03:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8703B84DFE;
	Sat, 12 Oct 2024 03:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ixqd+2L4"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917A841C6E;
	Sat, 12 Oct 2024 03:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728704116; cv=fail; b=CF8WPqg7GJhGfYvqvYgQuv1zfa1C9V4a/n8qQMD38sJUT3Q7zC1zJ7atPgsMmMyScyrKXOa3E6jJ11kl6c17so2867CQHEpmMGDLlXH2Mf2ktznuM0nrwk0FEq/NX2gGiHRaZYfdbciy14hksi8MKI/D80+Cf3pH7QNuCHnpTFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728704116; c=relaxed/simple;
	bh=t2bFvmkFgu8CCSu28OPlLPE4UrqYG2XRM8XMoIvQRrw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aP/eKiOLVbl0rIUTfGslpbCmxR011WUywi6xGrLkruJEKi0zCt9zxfFjTkdJxOKmf6JBZOGYo2wY7getQn2Zdkq5OgQqEVLBpl9sIO41bd2MFo4+8R7X2FbNNQO7BdrpO13c4imBKz51rSXEuddfOaAPvJA47R1CdgNBeoFJow0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ixqd+2L4; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728704115; x=1760240115;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=t2bFvmkFgu8CCSu28OPlLPE4UrqYG2XRM8XMoIvQRrw=;
  b=Ixqd+2L4YQbGZTelbbUZXQJseEjymBm6nk06vhGuQylKk0me3XOK7lg1
   1DEh99qT7bV9pik4PaR+bzpBa+onDHkgI6ig4/CIVJLo4yp0erjbT9FJx
   YURCGApBoGNYNiK0EI1PPjpYeMREpylMEkx8qAozaolJpGHtSxgUGrdSF
   aR4d68oEK9yadiemdfgLQDSlYTG+ObZbmf1caXmlaHXqUewGq5Crd2YSR
   v1I6mGKMJBbz4n9VKQQ/pRpsFO0Ai9hQFlI8QFsfI2snUgOT/FzgLgn0H
   zfrEMoDQT1C2LEQfdHs7iKHH7OlTBSZ+/WK/zfwjVqO8K1kNtiLnq12uZ
   Q==;
X-CSE-ConnectionGUID: wVdZp4MbRRCskL9wM8dqpA==
X-CSE-MsgGUID: zutHxbpIRryoGZAwDTv7KQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="38688595"
X-IronPort-AV: E=Sophos;i="6.11,197,1725346800"; 
   d="scan'208";a="38688595"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 20:35:14 -0700
X-CSE-ConnectionGUID: Pdoh/qv8QKGg4bXiFWjLXg==
X-CSE-MsgGUID: zu57+AaLR8+l6YsqMJ0LLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,197,1725346800"; 
   d="scan'208";a="77085254"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Oct 2024 20:35:13 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 11 Oct 2024 20:35:03 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 11 Oct 2024 20:35:02 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 11 Oct 2024 20:35:02 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 11 Oct 2024 20:35:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tZrk44XGiAEAyLC62L8Nx+kAJDKy9j+geQVpcBvWkEJ53i7/M198RJ4T7+1onQTBwVEhlcu74huo4zNwpG+Cv+JK9cqg+CuQ7lg6SY3spqNkmSXnImoaz6fK3juR578LJ86fNO7cK42PN/iGm0HteVBM7Iyc4UdYLndeFc/WhGYH5v1P50qxdTFEzZlww19LmHR7Z5zL/QHeckFQ+H3+g7QQg6+Ha8FtBiMrgiX0ul8hbjND5zLhmooGo7aFFBn2G8M/2xhgz56SeT/aJrSY/p19+8WENCXx/xVwhIWV3gp/1bD8yJsmzCSYtdy6uJTIItSn02QkX+WPyfU54aSuWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zeGWlkogGQE5LB5bnxItDCO7CIpDL6MKhbazlqWfWK0=;
 b=PrNENj8GGrmxqAKYO7v15G7ZofGTvDuFsBceLazwZY9DalblXUS+DuF5upAcy9PildAFX72M8x67CFf9FgHL2PEV25RFQobxW35wFe1lrZeceeVvXUBg7VURmrSIWOQalopptE+KCoE+kGaAaW6LasWnK46twiLMRktUnA4n+fQ1xC/TVaVq1qhApqmpTcU/S506wCuiDhRxL6jRAlikMo/VtWnZX+SvuUiSn0D/C/mAYrpfl4qkdBgR4fq0Ewv1J1xSwa6HFeBM+KP9MZj8mA0oEViFjHfiD187cuRpfXftpEX9M/4/ncWqcmh5+L2YC4AQ5uG2RrhZOXlgvtC09Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by SJ0PR11MB5790.namprd11.prod.outlook.com (2603:10b6:a03:422::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.20; Sat, 12 Oct
 2024 03:34:59 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%7]) with mapi id 15.20.8048.017; Sat, 12 Oct 2024
 03:34:59 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "Luck,
 Tony" <tony.luck@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>
CC: "CobeChen@zhaoxin.com" <CobeChen@zhaoxin.com>, "TimGuo@zhaoxin.com"
	<TimGuo@zhaoxin.com>, "LeoLiu-oc@zhaoxin.com" <LeoLiu-oc@zhaoxin.com>, "Lyle
 Li" <LyleLi@zhaoxin.com>
Subject: RE: [PATCH v4 1/4] x86/mce: Add centaur vendor to support Zhaoxin MCA
Thread-Topic: [PATCH v4 1/4] x86/mce: Add centaur vendor to support Zhaoxin
 MCA
Thread-Index: AQHbDYuCurNqdXE7GkiZbMANK/U7GbKCkA/w
Date: Sat, 12 Oct 2024 03:34:59 +0000
Message-ID: <CY8PR11MB7134BD7E18538A0CDD79AECD897A2@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20240918055436.15551-1-TonyWWang-oc@zhaoxin.com>
 <20240923073311.4290-1-TonyWWang-oc@zhaoxin.com>
 <20240923073311.4290-2-TonyWWang-oc@zhaoxin.com>
In-Reply-To: <20240923073311.4290-2-TonyWWang-oc@zhaoxin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|SJ0PR11MB5790:EE_
x-ms-office365-filtering-correlation-id: 27fc98e0-199e-4843-ff81-08dcea6ed953
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018|921020;
x-microsoft-antispam-message-info: =?us-ascii?Q?R1/EpuYKrIFrwUA+5KmwBuMZKfN85Iyc0C9Li4bP8f+xdK1AlYZVrRldEdme?=
 =?us-ascii?Q?ThOuKDWfX034QcI48XK3KpNBDeOtfDGhIM00iQ07EUUuKR1y9Ibwdke2bYlM?=
 =?us-ascii?Q?ejfB2VcbckzkeIQHgYDW5tApwGBBHqvZFm4BJ2U+f36QW82E1yiwy4vGZCYq?=
 =?us-ascii?Q?Yafe1iYcmQMWmA/K8sHTiM9fYu0/qYkuX+6PDG5XkWMgqbLKcRbMEfhYFVj5?=
 =?us-ascii?Q?/NdfAsLE85NHZeCOCKVWVyhJB1/sLU4jRL50HMtx1RPVVAMvFwmC5A8oXQvo?=
 =?us-ascii?Q?UnfXYpWs3c+3xzhqik4si39cUdzRMFGEQDmq3LV7DFrdU+jP6L3vwG1LDBLH?=
 =?us-ascii?Q?9HX/ngcZSUfXK786tabX5fX0XOlDggL8Z/tDBVF44MkQp9qFrjgo6xvM/h6O?=
 =?us-ascii?Q?l31r4nlRaQggRKgC6q3it7gci9b6dvuqVJyr2wgoC1u/wj8EqXdSKVoDyl+k?=
 =?us-ascii?Q?cORYmne6Fz8wFBcrnQiUiDbfvncN7sHQLDhsNqKKfaffOe5F4RYBXsBpf2kp?=
 =?us-ascii?Q?xd2FUhj8o+WfUJPae5D5L03Bx3t3gxDw47RC3EUyuIFofDXwhwiPvRqNCvFV?=
 =?us-ascii?Q?FgmnDbrT6OWAfGY08MSbUAj/OBzww6Jlg2rjPStKGJznA6BP6wVIa4pyNVHQ?=
 =?us-ascii?Q?bU8YgoBfbdmSXtJuHmJpwZxkN/cu2snFAYVnEQ/S26MOL1+jWsvUc//ZiJTT?=
 =?us-ascii?Q?tyZBY8PitLHBX3qdtsboCQwLB14+Z7UrOqI6lnl6G6rReVy7tHGt8h2Iwl1o?=
 =?us-ascii?Q?iDsMHYm5YzqenjOSBu9j5guyG2hgQs0Ks4b93NeiQXlqu3Cj+TBMi3VgjkUB?=
 =?us-ascii?Q?buEyE1+bHVOx1GZ2WghWlt0MP7DqUaQS2TAReFR7X1KfRYuh/Rb3iJwH0jWG?=
 =?us-ascii?Q?rKQWZpap761Df6RbZN1+iLnhmotCtZD0fgQWol5cGsu9WVhNGE8atZeRdjIv?=
 =?us-ascii?Q?iOiYPMxFlHXGf6sPSdAIiuWT1nW24hQkyFBPsS7AR9Z9znC0578snRlvctT8?=
 =?us-ascii?Q?2zikL7efPiBXsp2k6PlAuJMUvcPIcv+u0rkSdTug3rkULCtK4LFq91OUPDI0?=
 =?us-ascii?Q?WS9Sl87E+R0V8wNtFXAdqizbtDyASabdxH3IfKi2dd59hMd3V9zlMQhbhEqN?=
 =?us-ascii?Q?ExmYwM3XQ0RxmCYePSOCsmBMU76Gm8CgyhH3Ak94enS/JP/KYQHnwTUoCzsW?=
 =?us-ascii?Q?c/4eADk8U+I4jr/55w12ZUCiEZyhUyOGh5msOFoHnlR8NvT/ZRRFPFb8cKsC?=
 =?us-ascii?Q?Vo6YzaFArJGUVPPSGZBJLJRWu9AQqp6UuM7r+ZZQ2/Ik7Rh5c93lvr9/Llux?=
 =?us-ascii?Q?0r3KXjUwLwqEdEOWGi+ztaQZmBr0s82p0FcQxNAYBfIDKQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J175YygSFQifjZjW7bXkwVL2AAHQRs1mA0C8jjCE21O10S+gp0/C3A/9KSRz?=
 =?us-ascii?Q?EOwU+Biof2w8Ow5UkWYzRwc4wITpgvEVmhObezPnPchyR6Qczv+FB6Y9ERvW?=
 =?us-ascii?Q?bTkXP06aaGH65RsDxltVpjgApRzVUgOLPcypzXVcpbjCCOKJhPkFdx3kzttc?=
 =?us-ascii?Q?WGmNUi4dN5ijX68ev6yHS9YHyoyRuidCd6ir9KxWHG3hYqKlF0ne9bHgxjyh?=
 =?us-ascii?Q?WTMvmc+DyCOqMJz97ibSzUC7reJZHPOwZsGBE/TzftHKLrdmxbqJm8JC2sU0?=
 =?us-ascii?Q?z/9y1XWoZrUm5jQjWcJ9XBYL3K43WBu+33zAxNr8rbGvcvBS0NiBkZ5AOO6Q?=
 =?us-ascii?Q?5kKX3JXQk8SlVkxBx6lXxHQe7y1mVP3VCAYChaisaS42OHRVREyrrLoDzonx?=
 =?us-ascii?Q?IzUzUipCL89nKY8h8iZ13hSJW4spwk3ib3OGxK+1+xmuCLI+WimLqN0Tjj3u?=
 =?us-ascii?Q?E1a6WbdGAF7DPQLDObcnZf70Gb3U27H9KnZU33AEE0v1ToG2eIjohA52PXbr?=
 =?us-ascii?Q?jWrb++nfHqxykJj07zCPxWvGYJAjz7Pmtnf0eF+8vA+vAw0myiBruJ186PPk?=
 =?us-ascii?Q?YmQmXeZp3Rb3Y3PgzIImKQzr52e7i8YOyDZFDFVnATAIVLSCoEvQynZPIJbY?=
 =?us-ascii?Q?U85WYQ32PqiGxbHbcfyT0PIRxGS9MD7Rymhk2/OmNviKKgk27KL4bW36GhyM?=
 =?us-ascii?Q?1j0IBD8QXeql84UJgndD9+23kHlT9gLsjRE88CWhHI1wPa5qSrF0SO15OmCU?=
 =?us-ascii?Q?stZbXZbDvLNTJjp+jEr1AGwyMLp1QAtYkkrTV1WwqQDSoVRTK3phTejIw08S?=
 =?us-ascii?Q?WeHbQPLtVDpgisESDvSIDtZeX8WHyT5/DjDvVTBIFYpEP5g6bDpfuI12ZZpT?=
 =?us-ascii?Q?RVyFNI/wznoRisyujjmVg3Kn2g1+S3Cgrag29AZS6OpfcOKApjmzB3Y+QivR?=
 =?us-ascii?Q?0Ul1Iu7AoxZ6caGzfLicS9oiTcOuQXOd3feaq2h9iN58rl6784OlqR5sSn9+?=
 =?us-ascii?Q?Mw31MBMwYZn7UmcjUoiQ2Wo8xy4q6P6Y/g6W0y8L1lY9vFz8X2mjedDP+/j3?=
 =?us-ascii?Q?U/olZ6lneILa+ik18cWGY/1X05Aa6McRPGwMmWZq6pQGj4av9ljdo6aySf71?=
 =?us-ascii?Q?QrLLed5SJ6L9JeGVhYIqXPF5jrVay40AKFFJnyydTN8wr3e//OctXR3de/w0?=
 =?us-ascii?Q?LK++2af3A4Qn3iatpnSW5i34XwOk2ZDRERzuTazVQkMK0nJzb7d8MG2P2Nl8?=
 =?us-ascii?Q?ZB2W3vhfa6yIARmSvQ0OEKW5C9tTcHl6pfujpV1GEJDc88wXRAxsuGQWgFTf?=
 =?us-ascii?Q?woNbQoUAqfn6zQpQbnTNyWWoXNzu35dMUeSyC5DnhL5oCcZ+C8EGv0nmbocq?=
 =?us-ascii?Q?LWqFbxzkXpG6x0bhIQeVodzjcyswMq4Jlwj+F8N0Sqww31QBNJDAhGCy5BVj?=
 =?us-ascii?Q?BLLVEzQATGtJ3oIrxU8UiqpgyFwxf0kO/Qu3sn+t02s97XYVre1lNU23xVr/?=
 =?us-ascii?Q?mEz3Ig6eUDb6tOjMdCODQsNGg72uGC22JepyYJ4Csv7SNob5hUBsWldDWNjq?=
 =?us-ascii?Q?CuxpFmolVpPmFHCu//hTgxdVTKeAcd9RvM9wqA5B?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 27fc98e0-199e-4843-ff81-08dcea6ed953
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2024 03:34:59.2748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SDZQwFJ9NFhGsp+ev6x6u8K2g0d58Dai+sg4z4VWJOYp2qF5Bs/+3+XxnNfsZ0ieMRSKnvd5aNnQ+a2vevL2QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5790
X-OriginatorOrg: intel.com

> From: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
> [...]
> Subject: [PATCH v4 1/4] x86/mce: Add centaur vendor to support Zhaoxin MC=
A

s/centaur/Centaur/

>=20
> From: Lyle Li <LyleLi@zhaoxin.com>
>=20
> Zhaoxin consists of two vendors, X86_VENDOR_ZHAOXIN and
> X86_VENDOR_CENTAUR, so add the centaur vendor to support Zhaoxin MCA in
> mce/core.c and mce/intel.c.

s/centaur/Centaur

Simplify the commit message as follows:

   Zhaoxin consists of two vendors, X86_VENDOR_ZHAOXIN and X86_VENDOR_CENTA=
UR. Add the missing Centaur vendor to support Zhaoxin MCA.

Other than that:

   Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

> Signed-off-by: Lyle Li <LyleLi@zhaoxin.com>
> Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
> ---
> [...]

