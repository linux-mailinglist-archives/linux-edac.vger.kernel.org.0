Return-Path: <linux-edac+bounces-2548-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3B49C7FC3
	for <lists+linux-edac@lfdr.de>; Thu, 14 Nov 2024 02:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F013B25299
	for <lists+linux-edac@lfdr.de>; Thu, 14 Nov 2024 01:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E83F1CCEEC;
	Thu, 14 Nov 2024 01:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PYXG7T8G"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153121885B4;
	Thu, 14 Nov 2024 01:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731546697; cv=fail; b=ltjuFlZPn7Vp3Xr70PXH0Mc9TgA/oxM+MgzionkQlWzbdKQxGqKjL+B6TFEPGJsrAC4Lb5vI/+7OI3JkXt7jzonk3oiQQp7zXEu+1hs9mUcXOUUVNX/4WzmvhbIUhXZ/yQmO4FYDE+Ukzngvr3wQj7hJsUqJdJQJctDGlvHSw2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731546697; c=relaxed/simple;
	bh=0AbbSqP6EaxRJ/tiDVqTq1a+TvR9yUsSvwq+GOvQ8pw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tEUPBRBOgA2e+z5CFDpRTgPaOxrWEnQgWqXHG/zYdyV3kUZ9BjkvkEKIK2K1q76QSDQVR6LU7sS3Kj5k6GZCaYDhrcq2nGifoOWoQHNQ3W6Lmf936x+38tn1PbQPwNZuDWF7bea+oKrxhCbmmgqE/C3SrqvS5JtuYRVYZmGbIIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PYXG7T8G; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731546695; x=1763082695;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0AbbSqP6EaxRJ/tiDVqTq1a+TvR9yUsSvwq+GOvQ8pw=;
  b=PYXG7T8GKHnI23crb0UGSnXOGgAQyz9Kq417K6ulqBXzfjZ21gwvnUJo
   8PSEZlnlvu+DcHcyNo56RjBaNAQ04f7EWCOS+WQztZk9/YHUrr63AAXiB
   e2SYzmRfwaTJ0IqAaB4vTSBOHS6hPMmeJhhoZdJ8cG2wm6hqGuy4m9BF9
   9/s/xeFGLb+gOFucdC8KS0XtkuD2vS0FNYHuzotzc+m7HyNi6Y6CK/DQ8
   Jn8U3bLJ/7DRAA6NjI1OW0oj2lly6aJcIbKP3T844FCohuqiPwQ9FT0A1
   kai8V4xY0cn5mZm7qIKRLKTIky1N8UjSnGjXT3jGWFoJ5jxmrmEFpVRPR
   A==;
X-CSE-ConnectionGUID: z4bFxC/SRG64S4hagxXWcQ==
X-CSE-MsgGUID: dejxaM0rThyykZH0QZLKkg==
X-IronPort-AV: E=McAfee;i="6700,10204,11255"; a="34331554"
X-IronPort-AV: E=Sophos;i="6.12,152,1728975600"; 
   d="scan'208";a="34331554"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 17:11:35 -0800
X-CSE-ConnectionGUID: SUWXBNyuSe2Wsn1XqfQh0w==
X-CSE-MsgGUID: E6cCNiD2T1qO/n/rqQPaAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,152,1728975600"; 
   d="scan'208";a="92509353"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Nov 2024 17:11:34 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 13 Nov 2024 17:11:31 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 13 Nov 2024 17:11:31 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 13 Nov 2024 17:11:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xx1TStRChcCojFo5RDTL2gO7yBQks2qLkP0Anz1NWhoe0UKc1aEF6P3HApj40Trhm5rMrwa6kArodMnvW/FeELwYmSHP9eafJlBUT1BbDijaJmVwduXr4gP2sUaTNUMgmUVYylWDmu8M5Xg4wcdeCm7tK7p1+l5PoEoAmXZoYBZiUdNEzL6omMfJrPUE1j8hRpmMKm1l6Sr1SXcyjMSBaHjfwOM64OlcSxjUCq8NjzlGGB/W09dTtQZKQbPSkxB/zoYl2Ncz603VkZzEYu+bkI7c/tPfvW0N1qMnoVCUzbiSJn425YN7PTbvf/b/stNeP/zaxylbFhRb+0knr+M3dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2KKeb2Tj+hAAE9e8RZemMxcT6KhShOEyeRvt529nJhA=;
 b=Mb/ddp87+G/CNoD0MDhHf6mhDv6TQCLsG/55pBM0u2o+rOMTp3YkYnSK2BKJGIJHxFVnf5cp2CW0cFdLP8FxnZGU5jWheZfhBssLg1T+4EepFEqn9+nrG4NskXm5QWmuV3T1DCdWe73JAC4+yvWF/gaiBfeqnfpI3CIWDe+d2fRxWA3GNcaK2LsCBPp8dJJt9Xi1TrOFTF/kDbJeVQGr+96oOL6AZoVRkrR7T+na6hJdzOX6EDRFV0/aj8SLvM++SOHty1/+xEki1nW80ANGMIOlvDnWxsAP3b3pVo2IY1RwM4jeHDsIT4d3l1Cx/i3e8pWRiUZ+SXxNnVYrynIGGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by BN9PR11MB5244.namprd11.prod.outlook.com (2603:10b6:408:135::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 01:11:28 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%4]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 01:11:28 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>
CC: "bp@alien8.de" <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "Mehta, Sohil" <sohil.mehta@intel.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "x86@kernel.org"
	<x86@kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 5/8] x86/mce: Convert family/model mixed checks to
 VFM-based checks
Thread-Topic: [PATCH v4 5/8] x86/mce: Convert family/model mixed checks to
 VFM-based checks
Thread-Index: AQHbNAOwVGx4kOICWUGqtHMaNGxb2LKzxq4AgAFYcCCAACiiAIAAq9tA
Date: Thu, 14 Nov 2024 01:11:28 +0000
Message-ID: <CY8PR11MB7134110DAF88820CF31BBF00895B2@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20241025024602.24318-1-qiuxu.zhuo@intel.com>
 <20241111060428.44258-1-qiuxu.zhuo@intel.com>
 <20241111060428.44258-6-qiuxu.zhuo@intel.com>
 <20241112152716.GB3017802@yaz-khff2.amd.com>
 <CY8PR11MB71344CF097758F67C9336B85895A2@CY8PR11MB7134.namprd11.prod.outlook.com>
 <20241113142530.GA3181969@yaz-khff2.amd.com>
In-Reply-To: <20241113142530.GA3181969@yaz-khff2.amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|BN9PR11MB5244:EE_
x-ms-office365-filtering-correlation-id: d849e459-4f62-45a5-dd29-08dd0449444c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?pn/mEtH18/fOISooOboQxMOrLhipzRjGe6GxcH9GLGRpvseD7sZicQw8Jg3J?=
 =?us-ascii?Q?MoR+AWZDS/EHALzRar+uV7mwYORWbCPqc8mpqessAXLJIrO7kkjxsHIriakx?=
 =?us-ascii?Q?X5l4ayxZgTSjd1cO1cq8PPhas0s/GTRH44zxBIzVwSC0iTP85bqdHXWipTkM?=
 =?us-ascii?Q?NYjRTY241AuyMdgeEV0AOq5sBPEQkjHAk4kPjC3dAicbn/Tu6uNLl6uHUTZq?=
 =?us-ascii?Q?QX2BVTUqsLDrxVmb0PbCZnmQjEiUNf4OnYfEKSVI5kNRSPx4KGEIOGVNKNPC?=
 =?us-ascii?Q?+QrfuTVJwyfNHwRU2t7z3NC/Y21zlbUXKXzhzMb4VNKMnXiNut/eMVa4mR1E?=
 =?us-ascii?Q?ol8BnmPeu1Ngkb2sJA9BXvxXThnDYn8Qrspzqf16tj3cnWOsbkWrrEb2Uh+E?=
 =?us-ascii?Q?LLOCcvZBY6jHUkXG7krGlEGPFYndLyf7pvsSJSv673ADVrEyKEFbBdMGS03N?=
 =?us-ascii?Q?f70QF5gE1yYhuNaRofyYCcCTqW76WMhRCBGObHImTkJM0DEYeZHfwwCz2I1K?=
 =?us-ascii?Q?mcBFJrsigtOgobJfLu5cInpTxeLQFFl2VlIROfSRQKkvPVejvfhsNIovwHQz?=
 =?us-ascii?Q?zP6CN3JJ/pFKOIpNFw3yqeUF+f7ETkttMUQ3MUTFyTa9smIXchXt5e+cHtzB?=
 =?us-ascii?Q?+q6B31jZp1flkBRNydhMAQ5mnD3gHMxibZ3NnlSB3MaJAruQodJfW8JC+rzv?=
 =?us-ascii?Q?AO1cgqWFJAS+mrACiR8WB2w4mmzu3oz9xRLK2Fd4NWYQUgYn9AtjBlF7Hfcv?=
 =?us-ascii?Q?6x2H1RzYL0ptzNIWhtb0QEw3wWE2HLfxFRzUlWXYDL+gAjTtx4yqYgo/jgnA?=
 =?us-ascii?Q?s7zMjaR0m28tNGey9RBPI+otj0LKQsPgC0K2+6nAsmY1L6lfPOe8EExqgtMG?=
 =?us-ascii?Q?U3D1AVr18S9xsC7PhDydb3zqZ/W0G1YAHkhj0LqgdHfhHfh0e0ULoG5+I6KF?=
 =?us-ascii?Q?/LmkqATrl/deP2u7AgCZkWQ64qcq8io7XAjSmRRq1KmxboBGy0+EXiVFWXC0?=
 =?us-ascii?Q?Jf4h31syc+s6ab3LZWqcsdKiTMKkfwE3dVnSj+A2WwSw/FPF8bWZdl2Ghrrd?=
 =?us-ascii?Q?2xqXysAiQp1+b74+2UgXXU/OsAYEG3woq1DVw14zCQTaFHKM91PRwGveRZVo?=
 =?us-ascii?Q?z9kQ5ASKbQNyHA9HK7Jj8ZiX9e/NCX3oslLJpHvBeq0lUlVG+zqHSksr2q63?=
 =?us-ascii?Q?xnka94AZRlecTI9vhgiddcQLIJlo65Q1DM3Ngrkj3dMWqeetNbGbQ8eW0b0S?=
 =?us-ascii?Q?EGJX/V3IHLsTxfj9UIQRGrJQe7zvpeyqgnG7+9BzDNqHzi9v86Va2fKNAsOC?=
 =?us-ascii?Q?qYnmzFShsXJ6wlwD1tu3vw0oGVbpnyFHPqiPItwdDwKHH+brIyD7KQwIx0+w?=
 =?us-ascii?Q?BonRgsY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?E1/0uGxPE6Ix9Sbvu/AjxN/I4dCSn3dUF0XI0tkWmtLYDIhsYbIQSmmVDOR5?=
 =?us-ascii?Q?yjwG1ZzUYPDxgDl/VFOEKVHkPizFiM42Ofz/da7kHPjFjMtdc0U2I967+XO5?=
 =?us-ascii?Q?aHwXQwBTOwIeoP/e7jZG4uRR1ELw8UioSoD0FsCPoHA6C60+qCxhd6vAOVAh?=
 =?us-ascii?Q?P1BeRzLe4agSWhAAknNs4ruNFjOpV1NrpcA1KTiXZ83Ek8QzKDahMMHw+CSZ?=
 =?us-ascii?Q?pdoFJlGMovdak3K0j7ebeurVDEKNWnE6cZcP2FaHHqJXoiWrtsSiV5y5TDhw?=
 =?us-ascii?Q?8whunQYHwrbt7gzjeu8leeIzri+Wz90QAUK9W2fqH3J41exEzmSkfq4kGnST?=
 =?us-ascii?Q?0mbKLDNJgt/5SU6oktD6iofeI+d+iOW3k6nrkv7hmKhmmplOXxFjnIEfm99L?=
 =?us-ascii?Q?A+jQbJH7laAE7WvFNKZoz6ClUp7OY9rackk+AyBy+rsMz0o6Z15IY3AnPp5J?=
 =?us-ascii?Q?7va1J+JzBfnNkkDPkq9xmR0jz4OTIawsab8SVaJ/M4SrPeWkrDeY0/+dGpLL?=
 =?us-ascii?Q?EV3KG4jhOiNCEgO269Xlets358EXIcMGowRcky7gLM6m/aeS0u9pCjx2fNZ7?=
 =?us-ascii?Q?ik1f6eiTVIuplBbFt0YQSMwXSvNwqMNUR53T/Nuz16OU88BnVMdBmRunU46T?=
 =?us-ascii?Q?jYRt9tOwcgRVtrzVf5vEDLXFiLA/gKMGyVA9KV5/RvBInMUnCN4eHjGgTW0e?=
 =?us-ascii?Q?RVJRUpNEViCovac3YbmB5l+T9lcBZ1LRkAtW2fqk2dQY0Dw9a9El3n9thbqR?=
 =?us-ascii?Q?hV8dpyoCxMZy3OAIKHUuSIzjo5Qs1U7djPF9XN0GNihtllD6HG+9yaTuYBzO?=
 =?us-ascii?Q?OLukeqlhoLP+4HntUuEYdjLVF6uzwwLRcTDpcRjZk3HDZwuExu/nAuwcQSiP?=
 =?us-ascii?Q?9HbbuTCoc0nLV6Q9zidmgLUZCfEHtiP5/RGyyXuI+Xry94iDf92fc89V3GXK?=
 =?us-ascii?Q?/RKsPOHZXFEse9BmrCmjSIc/ha2pagjUBywucxRstnqY1++7W/Yl6S99DlWu?=
 =?us-ascii?Q?Yp5P6d9YLLStQOeNOa1Any4xtOtMK/fRlTPRKW/9WqWFL/2rWkXP2N9x4IZv?=
 =?us-ascii?Q?ydvZ6LwcixEyPn0aG4clmM77NEFUqqCC1ej6XCdR1QCjRaWn6dMVAGEcqYh+?=
 =?us-ascii?Q?ee+/GXqafvxsiOjpiozFI5vlidcl+hMJUaPs03bnCVIJ0X9pPZyonZiG4uDG?=
 =?us-ascii?Q?kyYoHFHdz6OfrMvP2PXgcta4/5Syapc8XxDVcVw0A7ipLyBYZWrmiKP4//MR?=
 =?us-ascii?Q?DqoMBcmQXTkXCqepGi0VejA6W69POJvShjhNf6BWWfItRyqyh9GYs2+L/0L8?=
 =?us-ascii?Q?3paQGOIyMOmsHcHZdRhPZNCuIuOSzK5I0VEAaHGPZBJF/RucxAKDzxAfs70G?=
 =?us-ascii?Q?Sga5sVe/SKsZG67nM2dR7llPwx3mRjJ/tEZf9XIZMqscDwmIoHu6QHbLsG9+?=
 =?us-ascii?Q?ji9ogt0GD7m83NhAVzcFa4pyQhdZV+qn9Xi6QujFBPV13p5BPh9xei97iQZ2?=
 =?us-ascii?Q?S8thWpSCTnbg8sRDXgq69Nmlmf+wcijrDWCHw5EQerTEwICKB0Xr8ShIr7oF?=
 =?us-ascii?Q?ncKHx5O131h0m7Ds8hpx5GR+msLtv3rUyIFn28OJ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d849e459-4f62-45a5-dd29-08dd0449444c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 01:11:28.1310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QHdUJYCuGIWWq9eRrtMK/S8LAU3hcIg9vLUnp2RxPNx3tkp6gh+3hnJJYtuPONko8fT8rT2jAy/Bc0utZAS1+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5244
X-OriginatorOrg: intel.com

Hi Yazen,

> From: Yazen Ghannam <yazen.ghannam@amd.com>
> [...]
> > > > +	if (c->x86_vfm < INTEL_NEHALEM_EP &&
> > > this_cpu_read(mce_num_banks) >
> > > > +0)
> > >
> > > The "> 0" is not needed, since mce_num_banks is unsigned int.
> >
> > I don't get your point here.
> > But it needs to check for the case where mce_num_banks =3D=3D 0.
> >
>=20
> The check is "mce_num_banks > 0", and mce_num_banks is an unsigned int.
> Therefore, the check is reduced to "mce_num_banks !=3D 0". In this case, =
you
> can just do "if (mce_num_banks)" to the same effect.

I got you. OK, if nobody else objects, I'll update it in the next version.
[ Hope others won't blame this as over-optimization. ]

-Qiuxu

