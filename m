Return-Path: <linux-edac+bounces-5459-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1DDC69D7A
	for <lists+linux-edac@lfdr.de>; Tue, 18 Nov 2025 15:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 1FBD72C8E5
	for <lists+linux-edac@lfdr.de>; Tue, 18 Nov 2025 14:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC9C29B783;
	Tue, 18 Nov 2025 14:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jfoJ9vFI"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6A4381AF
	for <linux-edac@vger.kernel.org>; Tue, 18 Nov 2025 14:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763474529; cv=fail; b=RThBl0eu6iTUYEMb7rvFTDzL3ALZ32WJEhoIAkkFqhGvbjBfLiz2ZesApuU/bW5AWWKu9Cu0ZTG9ipm9KuaB4iW4QA7jqtuvIl+MuLzb0y5GwMvm1WYhCAoedjgyTi/Rm2jDn/LZpjo+v8vb7KsHRxXFKjF62Fxqi7c5uQAtomo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763474529; c=relaxed/simple;
	bh=6xjtjKoU96MehpHK6c5q9wl2vIzE6YyrRBgQtWsldWY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Dp/+z1y1zEZfVmgybGt8lZCEM4/7M+gOqdCgrceqcHGHe8qAkhoW6Z0QcPdzrnG8F6sq/nortHZXVzVicW6jcV/i2W4e1f1fMWbvVtwfnNgrlVHmx/nu6lG/3YorUOa15C0qJEpWBTm5Yi+K72WGcdZW6//h71nufsUpazfWtfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jfoJ9vFI; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763474528; x=1795010528;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6xjtjKoU96MehpHK6c5q9wl2vIzE6YyrRBgQtWsldWY=;
  b=jfoJ9vFI3GG7NPHwky8WbUsuxalMjMAkLKit1jmijOTZVT7ANhmFlYY+
   6XAWFPLZxc106N44S0j3Rtf38ufxQLpQQAgNb7bs6cFGyw9dYkFkkoxXk
   lFpdyCquYaQGLRhP15WA6eY+SwTuDOPBKuiDyN6Dk6xtFdwYch7R4zboI
   iRPolwAR2ehAsvqpwOgJlYYSSpx6hRftvgBrDTnx/EQk8TyE9VmnwomGi
   ZkXLmLKrk8lItodx2RS7sY1VA3RBtIbNwGraDSLGNqKal18SgnJn8pZXx
   +pt6PJAlTzR/p8Eq+kFQIhj6ua6tU9p0nSAKeR0BYpd11kpfhk3ecOJH3
   A==;
X-CSE-ConnectionGUID: GzNZYZq4SNmUhxpcjsVLCw==
X-CSE-MsgGUID: 0v23cxscQUasEqK/+QH17w==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="83122290"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="83122290"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 06:02:07 -0800
X-CSE-ConnectionGUID: W0REBJ1USbe+N3RjKUYQ0Q==
X-CSE-MsgGUID: DbO6cXPVRqqiLylzBLa3LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="190572402"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 06:02:06 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 06:02:06 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 18 Nov 2025 06:02:06 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.31)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 06:02:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OOOcKG2yNHV8KuZK8dXXjBJvWKBolHqC+5kkY1zHdH6xeoBeMSxq1SSw/2si6Ji5g2AZQdJgA/4sTicsYCtHbvclCRuoA+6seZ05V1L0pgFWwazMarR0J8FOUIL2yEl69WKfW/8sXR2eBXTwOfjYl+kholVmhUqY5GGXK8OJqQSXorkRVJgp4vQfZ8LXvkT+7uAVva+2iYkjL5a+j8BjPH3PG7wW7XhJcble1D2pwmMR/4NhtqFwlge+EVglHwY9yw+jgUmda7WbEQ1Y9hAcLuKLLjfDvjNdf4fPNtehCTnzJRFsFz5oUIGysdaY3LviEhmudJaSgt4jEye3mNVTVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fxYk4W05QiJlmLytssAGgbMWnIx8RWH9sfIaOEAQHMM=;
 b=S5OYFJyCtVrKbL3NBM8I5EllX7CKJ77eQbG29n1KJT9cdEnkga2MkjfkKAfhM+Yk/uPz3g+K0z6J2Ldc+SpcB9RYOkn4FS7wj2VTeHr4Qf3O31/Oqj3l4N8lmAyC/C016pIzxwGh3DVD2l7YIhSP5JoUUC15QSydFXdcPIEMx+jeKzP8QlCpRMhuvPfoIYPcR1SdgMMAJr10cddYVRF+jZZ2IvYKJU8Vsf7MqfJllvgHqT8VDH4acwqXHFnNhfYSJMmcglQND10+ENLig1HBv8tC8HDi/seli+MVEW1bRWssyGQnl7OFGjXbpOcCoK2dQRit2jzF8sAOCux1xdK/IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by SA1PR11MB6942.namprd11.prod.outlook.com (2603:10b6:806:2bf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.23; Tue, 18 Nov
 2025 14:02:01 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::5670:5b2e:6ecb:dcaf]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::5670:5b2e:6ecb:dcaf%4]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 14:02:01 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
CC: "bp@alien8.de" <bp@alien8.de>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "shubhrajyoti.datta@amd.com"
	<shubhrajyoti.datta@amd.com>
Subject: RE: [PATCH v3] edac: versalnet: Use kasprintf() to simplify string
 allocation and fix error paths.
Thread-Topic: [PATCH v3] edac: versalnet: Use kasprintf() to simplify string
 allocation and fix error paths.
Thread-Index: AQHcV7HOJQxNosotRUyBhMKDLn9FL7T4dX0g
Date: Tue, 18 Nov 2025 14:02:01 +0000
Message-ID: <CY8PR11MB7134D2BE6FD3B07447A8425B89D6A@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <SA1PR11MB71307704AC76D92F04FC634489C9A@SA1PR11MB7130.namprd11.prod.outlook.com>
 <20251117110219.35852-2-ayaanmirzabaig85@gmail.com>
In-Reply-To: <20251117110219.35852-2-ayaanmirzabaig85@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|SA1PR11MB6942:EE_
x-ms-office365-filtering-correlation-id: 8ba78da3-eb85-4f04-355d-08de26ab0bd6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?Dm0Efo/AuF6e+A+E7l/GYF9flZR5mO2Uz/+CTorzP1QSPyUPMEvtyrnGeZ2M?=
 =?us-ascii?Q?aStjybCjYgcPEfTlSG5exlwzXMPilvhOU9Cb4k1n/fSn0zw6C7zDGGCtkGs4?=
 =?us-ascii?Q?Xl9xtmnFwjJ9iclMVSaDlERWE6roMnk6ueH3Q7Xr7Cx6SBHoZ/fpn/MzuPNE?=
 =?us-ascii?Q?InVdhJ0CSQwXetfTENVkYHAZSMmuzCr8v5yn3Q84KkVXJx2A3bF479R49der?=
 =?us-ascii?Q?JyDsdVsXXCTCV9B3aAE2WdWLhN92vg1E4bpEUOTOOWV5OsV95lCBc2H91N+Y?=
 =?us-ascii?Q?fQAa+fNbmz+6+oUPKXTUiD6kaH9HxxVZ/bVaGXB74waYCURwMGszGhhX+KjH?=
 =?us-ascii?Q?7tbIkjSNBqcc6xb7CkKLuHY5LeByGJmfkReRB6W++WfsRjYeYsDhLr7ZTT58?=
 =?us-ascii?Q?6EpkmUx14tgWgvC9ilYQerS+de7x1oGas4w3xv13AorPCoUCUsTyigD6UrDV?=
 =?us-ascii?Q?s73X6oivBlxIbEJDgCgqe4JaeZXe4XUXAXr093xH2aZNHnTQlA7Qfy5e7Fhl?=
 =?us-ascii?Q?AKxCDzac3EuAjqnEZflelHCvpa2emhUw3DGiuxkcUBQTXlWW3sEr3EJYCLqE?=
 =?us-ascii?Q?fn1P73dAfl5RhIVwntnxMk0KmVtcUx0WrU4Ds6mekl7/tEzwXkPmwOYuTRHi?=
 =?us-ascii?Q?3FLk3pdK1v0DscHWGi8HeB+7GooEqf/mOQvLgMYYzWsMk+9GbkCHFHbycd9x?=
 =?us-ascii?Q?P2cBOoW7ytMK2CHD7F9bz/CPgkoALsTtTM+ApohVHUAawNecZa+p/odF0soW?=
 =?us-ascii?Q?Kvsu6kYVHdq+q66o2faZdtR+zRDFo1PwJ9W4XN0tko7Af0HMyhAFhWJCvfr3?=
 =?us-ascii?Q?d6/+BhOIBKYFkt8O/T2kk4oi6QDaMFDcdWRJrc7iRsHcs7bggq7AwmIru+dY?=
 =?us-ascii?Q?RAuKQtK//DW8VcEA/JuvQEmjRJ31YZOqoWEOS2FxdTlgScDDRLoJm9PochsK?=
 =?us-ascii?Q?S7Mm0CddSN8FeLU6KTD8c2ABSyubDzRokFg0ka+q869HvPbPtK0upzpkIgsT?=
 =?us-ascii?Q?eAEKAO/mja5jKj8ZJeftFwUyXT/vjCA4o1NaGJ8ViARFI/9aBpDmh3V0/4It?=
 =?us-ascii?Q?+InQ9AQ7P5j/0MN7kFZ+BbRZDor7o7aJz+3p7q/Es+wwcQ6bJIemE1Uoy0bt?=
 =?us-ascii?Q?eSudlFlVbF/PsHGyZERpWb4UhF9fr+BxseWGcW5nwh1PO10YGjsnWK9clmJR?=
 =?us-ascii?Q?dhkNZ06vmxJjAGUWNI5fW8DZ/T4wtUF8B0pejLe/nuzHnmlZTXvilDmuT1WN?=
 =?us-ascii?Q?VPLMKWHpnnhymEcF/MsnOwjUmLR0GPYC8aZdL1ISOoy2hsfzwl9yWWZyFU+E?=
 =?us-ascii?Q?y4CNncNorK2HYlatNCjbm2Lli+LgUyN4T+l7B6cNbu6rGtKKynp/Id6+mCI5?=
 =?us-ascii?Q?IXoVQYwdYIrEmyrQnpE4wCgbpLSYuEhH+j7qzGt8ubejZYOP7gwBogp2xybJ?=
 =?us-ascii?Q?VeqTYYUGU+18ZA7gpKGsaPS/6xfSfHh+IMSU/TclXZ39dKHuGgutk1rUeS+L?=
 =?us-ascii?Q?A4IfFgxh679rE9ITQeRSupxn5I725NSxzPlx?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kxgIYir7sJ42KyAZVxrvV6p9201jbpVZgqjhdwvH/+xnLmpqlvr0czA6tjvc?=
 =?us-ascii?Q?RkWtAtpn97FxbY3y3Uw+MRWgEaNKBuLMgmnVwG/3NUMVYTWNdyOxsvBiES0U?=
 =?us-ascii?Q?WeAozfxOJMEsHPpX/vrv69AbahU+fIQBv0K3HbyeS/PQY/SaqnT54r+spI2r?=
 =?us-ascii?Q?sxV6gO4+aVS7vVXdTKMsPvRUEdX0F3l6qp4AMqgVMc5eW0IQLbrf0ST7DKvZ?=
 =?us-ascii?Q?8OTjhO+bC4z4LzCtdIMVojei1u5HQZqKLSZbQZ2KvP5FwyEkVVBIK9ipc3MM?=
 =?us-ascii?Q?Om/hGppj89oTbo6Lh24o7tczhaO9HuWbDLHO0wqjfgq35N5A2T2HM92ki5Pe?=
 =?us-ascii?Q?iewVpKcbGemPjlg5kv2+CGEiK/uzcsqhvU9nxKC8VSh1bG+bOMOpfxg9PYFZ?=
 =?us-ascii?Q?WKyaFWa//KGEhqucfiqA7jBrA1cBpTMqaGpFMMGlzOR0rOCKLTxe5MqCqM6+?=
 =?us-ascii?Q?M33HCOaPOCfeJwzfMqQknl7tZrTniD1LVy68cTaiUndZT7560JunY+uqpvXn?=
 =?us-ascii?Q?4Gxt6NZ4jLhRtlCgYqMdR5uJr6lk464vBS8nIXl6pzuQquw8Yt8tFswqtJPa?=
 =?us-ascii?Q?mX10VyKJ9jd5Ym10cFl2OdLEomiHA8Qvw4da3rEm9LJLSipSrziukGrZl8Ay?=
 =?us-ascii?Q?DtkYlVfAQqahBaWwTpsbZrJlkEdVPFsSYrPRUSYyA3E/u4/M9LjskfEgDuDF?=
 =?us-ascii?Q?1CPo08OAdR+OIVCskKmLA6DNb+NsYuLaA+FEbQjui22awt/r1UefUU9nwUBE?=
 =?us-ascii?Q?B6hH4qbRTzRWn2D2bXqah0E3VtazdAlmQ5gUMdaHuI3Q743Aeb1GJ/genlUw?=
 =?us-ascii?Q?QQNiUQmjnL3i6aq9Ihy4E7+TV8Go9Al5MFZoSZIQ1zOtixFPE8SdEgiPsIJy?=
 =?us-ascii?Q?UCFdh6TuoVx+DvhR3I16+h0coUTieeWB5Mx3zokAVASqPBmyyXD/J1CPSyvg?=
 =?us-ascii?Q?YR7tlhTTdk7T/UTQRxPElMV7j8wRJuXBpfq1TI8SNEUuepqTXKkBgJPVVbB+?=
 =?us-ascii?Q?r3xqeDlGbcogYS5A635ZUxkFDQQ9bixT08cp62UPkPNnP4hBLYIs1V4dLD4o?=
 =?us-ascii?Q?z6udEXhqKfElXzfgoiR4gyLr9hku3LMGB7T63AdGdBuxB+JHpCYiwsu8PcL8?=
 =?us-ascii?Q?bP6xlE+BR37I4N91Hn/BW6cL8pfyPtKk6sXMzPj3DP74NzNwdX+l/ufLFI37?=
 =?us-ascii?Q?C67I81xuIsNjKGysCrqyjBWIHhOHqwPgY6lYxJSO5+enETzytYefGf8pLq15?=
 =?us-ascii?Q?GgS9nGDLZdrTCc9guWWz03NMEna6PuJSJUgArgVL+CgyHzEcsV7j0f7mfqro?=
 =?us-ascii?Q?04jAMxJPGLhZJigc+auXqbIpA9hEfiJ/XcDOPpJG+P6+8DurXkBcKAjfuk11?=
 =?us-ascii?Q?3C2Beppot0xVQh3bfTy6gRkBMy/E8u5gnGsyC+P5FPhX0HuFI0R2wC14AWNq?=
 =?us-ascii?Q?88olNWhUhOGisD34XGQqFM3lk5kDRCEJS4nPE58tEHuBw4jOdlWpnQxY9ABm?=
 =?us-ascii?Q?jsDHmbv8m2jUaUo4oQ/qDtK314LDekK4M90kZ3juFz2ZLPu4dTmXCfLLcOZ+?=
 =?us-ascii?Q?ZGAiJU6YiSgoBjKFmv7iewTFhTJSpvTcM/XxWzFg?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ba78da3-eb85-4f04-355d-08de26ab0bd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 14:02:01.2584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tQKZ95SpHZhQP/Ao5DJJhHzHtA/G8OzPGZpUHAXn0/YS50WZnToXZ0Fa5fVaAcMZTbJ+kT0n9aZeTH7+yBdFAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6942
X-OriginatorOrg: intel.com

> From: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
> Sent: Monday, November 17, 2025 7:02 PM
> To: Zhuo, Qiuxu <qiuxu.zhuo@intel.com>
> Cc: ayaanmirzabaig85@gmail.com; bp@alien8.de; linux-
> edac@vger.kernel.org; shubhrajyoti.datta@amd.com
> Subject: [PATCH v3] edac: versalnet: Use kasprintf() to simplify string
> allocation and fix error paths.
>=20
> Replace the kmalloc() + sprintf() pattern with a single call to kasprintf=
(). This is
> cleaner, simpler, and avoids potential buffer overflows from the fixed-si=
ze 32-
> byte allocation.
> Handle possible NULL return from kasprintf() on allocation failure and en=
sure
> proper cleanup on error paths.
>=20
> Also free dev->init_name in the device release function to avoid leak on
> normal removal.
>=20
> Signed-off-by: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
>=20
> v2:
>  - Add NULL check for kasprintf() as requested by reviewer.
>=20
> v3:
>  - Free dev->init_name in versal_edac_release() to fix the existing leak.
> ---
>  drivers/edac/versalnet_edac.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/edac/versalnet_edac.c b/drivers/edac/versalnet_edac.=
c
> index 1ded4c3f0213..360d4f83ed89 100644
> --- a/drivers/edac/versalnet_edac.c
> +++ b/drivers/edac/versalnet_edac.c
> @@ -15,6 +15,7 @@
>  #include <ras/ras_event.h>
>=20
>  #include "edac_module.h"
> +#include "../../include/linux/device.h"
>=20
>  /* Granularity of reported error in bytes */
>  #define MC5_ERR_GRAIN			1
> @@ -755,6 +756,7 @@ static struct rpmsg_driver amd_rpmsg_driver =3D {
>=20
>  static void versal_edac_release(struct device *dev)  {
> +	kfree(dev->init_name);
>  	kfree(dev);
>  }
>=20
> @@ -812,12 +814,19 @@ static int init_versalnet(struct mc_priv *priv, str=
uct
> platform_device *pdev)
>=20
>  		dev =3D kzalloc(sizeof(*dev), GFP_KERNEL);
>  		dev->release =3D versal_edac_release;
> -		name =3D kmalloc(32, GFP_KERNEL);
> -		sprintf(name, "versal-net-ddrmc5-edac-%d", i);
> +		name =3D kasprintf(GFP_KERNEL, "versal-net-ddrmc5-edac-%d",
> i);
> +		if (!name) {
> +			kfree(dev);
> +			return -ENOMEM;

On this failure, I think it should "goto err_alloc;" to free the allocated =
mci instances=20
instead of directly returning -ENOMEM.=20

> +		}
> +
>  		dev->init_name =3D name;
>  		rc =3D device_register(dev);
> -		if (rc)
> +		if (rc) {
> +			kfree(dev->init_name);
> +			kfree(dev);
>  			goto err_alloc;
> +		}
>=20
>  		mci->pdev =3D dev;
>=20
> --
> 2.51.0


