Return-Path: <linux-edac+bounces-3995-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1CBAC29F3
	for <lists+linux-edac@lfdr.de>; Fri, 23 May 2025 20:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC615167FEE
	for <lists+linux-edac@lfdr.de>; Fri, 23 May 2025 18:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CA329A321;
	Fri, 23 May 2025 18:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fuPk5pMZ"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14367290DB2;
	Fri, 23 May 2025 18:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748026250; cv=fail; b=nNH+CYiBBY+h3Bw4u5u6Bv1HJukL6N2zZZZv/M7SYYLnOvEutmosSONkzY4ogjpj2Du1mn/KxqqKN6LQouoOwPWMuDz0Y/FrXvh09lmBP/OmgCArSap0iq3fUIPG6xG1yzcSHX1ZGvCYT3wXo+64Z/ctsAKCXMQGFNFQzV7IvRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748026250; c=relaxed/simple;
	bh=i/rWBPphRKirJuyuezCfiVzRSikmYRh4NKqpl3x/NEs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rTFt1Kzq4VCrmcEJ9aj1WR/Tpeo70XY+fhEZBG0RkMNa4v/QzZ5TvMJa9Q/koITyPfYFY6WFS3hYlkTnABiVfH4AmoPSDJjuD0C8rIGf6IijwvTxDjIdupEga+bwQFAvl29d7Sw8q3NG5FCKh/NeFtk6gevX0XopHoLxmX51q68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fuPk5pMZ; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748026249; x=1779562249;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=i/rWBPphRKirJuyuezCfiVzRSikmYRh4NKqpl3x/NEs=;
  b=fuPk5pMZwRzrVK6NU2195CEJKsL/BWSbKdI6Wbg01ccrhtqgkrI2mVjI
   xhBWRlrchBmvJ1IFJIZqXj0/yts/iYmladOC5DX9TCdkEk8K9yLZ6q+lf
   BkGj8kBfc0iaoh0WWO2FNanXpbE2U3DXjFf/u5K6+Q45d/RbytOB3URM9
   Kd1lM8HOZNK9DLxh8RZx1Dsf2fXCSSwCmpjoFpbwaABJoXUX8fSFTg04G
   yPKy1HPftbYxNbR1TmGBYlxVEeL5tsc6ig5VdYb1J6UkiZMpfzvyWuDMc
   C3NuPXe7stN6UoU7KxfPgGoDX9TLe2CZ3HOt1uEmS5krww6ZJGnCR0/46
   w==;
X-CSE-ConnectionGUID: trv2zCUhSKesTjp83W07uQ==
X-CSE-MsgGUID: Hj1xDjWrSDi1XozCksZ+IQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="67504334"
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="67504334"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 11:50:48 -0700
X-CSE-ConnectionGUID: 5j5skGmHS7yZAr2ipI7xTg==
X-CSE-MsgGUID: HrHDpTm+Tkycn9z6udqV4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="178377439"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 11:50:47 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 23 May 2025 11:50:47 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 23 May 2025 11:50:47 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.61)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Fri, 23 May 2025 11:50:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WTGcWnZmSN/2GVh2UCkrEJjFgq2hvaJUnfS66e8EN7+xOWQFBRqWbURvpvus6kwgTyFMg2or+NSOpI3wpx4+kZC30VUPyKpH2Tl7uaOEzR5rZF7r5bAxj26641Npp5NxH4PrFeYd5TMGCiNV4OcZ9/uuGlDur30pwULEWMCDuF049/6OzTOMNyZZEE7LWThzznNoG6XUR5hip6BbJnHThEEmvJTckoZTRm680isYvo+njlkOsRAtqHKX3OYRU7uR9bGFgbg98/7K+yQvllgPXjQEUQj7qWu3SAwZXTrV1MyDaKe0rKAe0etYpyYdN6eHyCR3bRtkipeARK9iACaw2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KgN3eWYt1AWEiPlzkn/RrX+MfSUWiYs1W8cqPuVifbQ=;
 b=kEq6YLjJtqNNcZdqg2NQVzgX1gDFlN26OYvERKMlcCyLFGbIWlf0W3r+zPc0HBnNNVJ9oIKkoMOIZSj5pLfyBjkaF1vwbsIxlVCxLJWfcqdf26IfsevCaYDuyAqIxy0VvvOXDIdWnLIBfuGVt9iuZQhi8svjAVt81IGSjBVvsnlPUyQOXE+g7JY7os6Hc2G8J3ZWjzjQU1KwjaDLMVy834FGKR0Qt+Wymwi4Zw+k73nRUGHj+QP2b0MPRtHigei6uqjeB6Uwqp3CebZyByZf+Er0jhWcsk22KWRYzcY8CpGFOoyJfw7X4EJUvcnhzj/i2Bd+UGu/IZKa45nbhBmvlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB7009.namprd11.prod.outlook.com (2603:10b6:930:57::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Fri, 23 May
 2025 18:50:30 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8769.019; Fri, 23 May 2025
 18:50:30 +0000
Date: Fri, 23 May 2025 11:50:26 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: <shiju.jose@huawei.com>, <linux-cxl@vger.kernel.org>,
	<dan.j.williams@intel.com>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <dave@stgolabs.net>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>
CC: <linux-edac@vger.kernel.org>, <linux-doc@vger.kernel.org>, <bp@alien8.de>,
	<tony.luck@intel.com>, <lenb@kernel.org>, <Yazen.Ghannam@amd.com>,
	<mchehab@kernel.org>, <nifan.cxl@gmail.com>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<roberto.sassu@huawei.com>, <kangkang.shen@futurewei.com>,
	<wanghuiqiang@huawei.com>, <shiju.jose@huawei.com>
Subject: Re: [PATCH v6 7/8] cxl/edac: Add CXL memory device memory sparing
 control feature
Message-ID: <6830c372245e4_3e7010012@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250521124749.817-1-shiju.jose@huawei.com>
 <20250521124749.817-8-shiju.jose@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250521124749.817-8-shiju.jose@huawei.com>
X-ClientProxiedBy: BYAPR11CA0072.namprd11.prod.outlook.com
 (2603:10b6:a03:80::49) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB7009:EE_
X-MS-Office365-Filtering-Correlation-Id: 1949f3d0-9a8b-4517-3d6a-08dd9a2ab0e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MrFYpVL/6cmwDWmmIa7Pke+OhMPx96cyQfiHQ2VhDLltfBD/9ngAC4REtxrS?=
 =?us-ascii?Q?yHP7XXY4mv5GN5A4lg/GrvDajNywKD8SpD/vT+oigTlJk4rggi1/aKH5BDwC?=
 =?us-ascii?Q?PCqZEvGfcAsG3jNx/RBxJBJyMKKTS+trIYb5/9M6fvr4bmjrnJampTFf/xJ6?=
 =?us-ascii?Q?NMIhZirMgQ633rltsf/X0yRrnXD+n+/8dJ9PvwIEooeWMFVKyamgUwiw1YZk?=
 =?us-ascii?Q?D0HNPiDpYj+Uvfir7BQ6HOHp3mtgZD7+MRYrJ9ra/D3jy6t7vtgRD7BPFh+q?=
 =?us-ascii?Q?J86ReWGx0NJZigZfAzQvjofVVrWulXVK5p2G4KbOBgnWxRtVIHZEb0ZpXRHV?=
 =?us-ascii?Q?QVskPR0IN3i6GXFx3lfAGGpPQbfkJaJ1amlSveSK2/cdr8IeJM1t/4kK+n/l?=
 =?us-ascii?Q?OC+U/4kHn7GPuvQSpW7EecU8wKOAoiUP5f8b0ywRAO2ATDj/9UpVI+F/PoaL?=
 =?us-ascii?Q?A7FZGoJIYGSKEcoIRMjFPTy+qbYryAlf347Ax5Unk3p/wDZUlZT+nufcLAA4?=
 =?us-ascii?Q?a3CF5xMzijWSmlbsNakpp1tPcDbD05QBoREAkyXPgL9gHrLUt7G4PIABpKZq?=
 =?us-ascii?Q?qvyqLTDse4yp+7EqpBczO/Rdbgs+1ey/4XcKPV0kxKgAbusl2Wf5qMM/CVia?=
 =?us-ascii?Q?XQWv9qDjnkZHxVJyMO7tPuqfFBQnkkQep8xWqhmZoz1JtXBz/Lk0s3O+EYUq?=
 =?us-ascii?Q?VEeoL/pzQqf9k0M0lMtuSg2Z9xhXLnGhid/bvaF1oKbfO/rbkBaNalpS8HWT?=
 =?us-ascii?Q?im4Cn+xl1OXp8rk4X1j+Yyt4JCM9QR9SGyjQKvH9GGdj4kAxaPSQxthMu4+r?=
 =?us-ascii?Q?fUl85HoKLd4LfUSvCSEeWMH3zwkH/+6ZXMTFfJQCwmu0nPzKRFSHdYTDmVei?=
 =?us-ascii?Q?Cp9dq1zFe4eU/jMaF9Pe+bHvZWrgZWEGsNWnqkT+uz9n0MF23x3YL3OL8x4t?=
 =?us-ascii?Q?P0vSZINFPapw3wylsUZvydLduxK2PRL5ZTfqWu1mbumV9I60Q5Gc6c6HVnWp?=
 =?us-ascii?Q?z5saMDYR32CmWNJm6+B5BoyTV8eDhZ2zt9W1er/iyqZJTexEMV/N6/eaKEmQ?=
 =?us-ascii?Q?jn4X+W91/VLHy3xZ4o5To/D+sjBQEGx9jsImSMS7B9cyNXLwHckYy7WXv0ZH?=
 =?us-ascii?Q?VAr5LXKKP7yapXWUFYWBAXcv1Fzp5QbrfdL0FJ46j1Zzlv5s/uy8rgUXXV1p?=
 =?us-ascii?Q?X/8FwIcp861OQb4fMgQmxnsIUHbG745vqh0zbA7exuwh3o8dqk5lw1ppESmA?=
 =?us-ascii?Q?UusgnAdjiba1ElGyku+7TiPCqNIU8HJ/znTP2iPYnI1p1P68iuVBXjCnFfqq?=
 =?us-ascii?Q?XCkx2ciaUAGzRLDjzIRsOx4AV2baEdyUbOC3K97ynQsUAVcXgqpaBomND/Fz?=
 =?us-ascii?Q?DA45aiI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SAKqNolOC4o3TDki/SHJIEQdrbMiSGhbmMxxJ3PzP1i/rws9OfSXITctJBbZ?=
 =?us-ascii?Q?/nHTomtWTYfX2JG5jfUNYIgn8Vqhzd050RC/UWgMqs9zs96rZqKWvsG6Dl77?=
 =?us-ascii?Q?+wQ/qYPtTbriiqUvQ7BXrbdH1TpnRX6cB/6bMTXU0lKo5cSnDapw6rQ98phe?=
 =?us-ascii?Q?k2OkpK0a3XWkSmj9z4GD5MEyS6jy2TEbTNf8YGpSBmHUQWqnMgn7dI3vTVEO?=
 =?us-ascii?Q?81pNY5i1u0wIGV2Fojj4Ya5+oM2j1Dcr/dZYbnnQeQOdkNobq4YQnSZCU4xp?=
 =?us-ascii?Q?136rhiVW7X/LoXb2zxeKVzu1mvZyyNmaSQ+cf/bDk3IOKu3E04VMg2sUqtZo?=
 =?us-ascii?Q?jovjHDBzpm29VdVGbuUP3giPGe18HKUfHDwb78JQySyvfy1PUtLc+jTxfSF9?=
 =?us-ascii?Q?BTmjHpr1IHt/UA0yTUXptr625hxMllWvOGmAfdCbl78gCfh0or2XENgPgJp1?=
 =?us-ascii?Q?emvsz/NPBDw/Kx845eXevk7Gj+/msuN5JmikVCX7GNtb2mQYvhz30amn9uCr?=
 =?us-ascii?Q?TuMelXf0UVi0zGe2uNShYfuDv9Ftwqv+xAOvC7zwsshoChRdOUM938x3dLka?=
 =?us-ascii?Q?V8co7gLq5XPT4BtPqEUaib8I0VnyDvCJFPE3W4JKvo9bZRSgVvmAvKjmNxoI?=
 =?us-ascii?Q?5y+7owEe/U4qOEWKrNjDlVKAKp5/bBvCC5Z2aT9ox+BvjoTD1GG29IELNSBn?=
 =?us-ascii?Q?lwJiVlHPylbr751pUfwVGYyZ//kyQPysqdCW1I8Y5cnbgoFB777cd3BEVUCH?=
 =?us-ascii?Q?Hq6soe6hw1W9udU1lVDbiijLpDw944vlIVBb6YsrLGsxDs/j0VaWb1zvUsAu?=
 =?us-ascii?Q?DxruWlG3qr47j5BCP0oKtyQxNG9+YDQXR2E4v9g6RH2RptSCdou4My3/TtOk?=
 =?us-ascii?Q?7/WrVlTxsBNalYtNnK4c8urJ7+XmBlI64ZuNxLWDo2c9WxHHpFF0J0sN/OFt?=
 =?us-ascii?Q?SrD88289d4a7vT5dIBdR9YPWXUsvTw8ENBnxbRec6PMXdkFH44aUolDTrqpK?=
 =?us-ascii?Q?ACWAk8XIaSn/eqz/8OWnx9rUvY9rDVZuPoM+lS3fqn4S4ljj+dP1ec+Ot/mb?=
 =?us-ascii?Q?cbOZOUlavg9BSxDi0eRxgu1dXWHgICHBqRllvM+U/APEwagLXDCat9nfUjtP?=
 =?us-ascii?Q?OTdd2pUxrpDMeenQ4PBMl7xJnAFMn+RLuh9yQjzjxGKuoon4fulHAlbtLQhc?=
 =?us-ascii?Q?M03vPcsPcMxJK/axbKU4QSNlInlJ/vwsUxDbl8x9C4OiyzwssTeCw5kOYTW0?=
 =?us-ascii?Q?RSlHPl06MDjoEkwvkw4WNEt6MBBfxyuCDX7roiXIct3s94MyKhq+2wkftzPo?=
 =?us-ascii?Q?IPSD39KJ8uCutOgOfhcErFX3CGrOfpbTdhKRtkfYJz8LboatMYMARHFPk4GU?=
 =?us-ascii?Q?6xA/ArcDTB6Qf6DtWhHKnQJbodIaGzg+ampGKRl9LVg5EGl3wIlNIg9Xk7MA?=
 =?us-ascii?Q?IYpZMJ6gWBkKeBhzmOFDHbJYwSJPrLwM24QghoRlaMj6+dZGkitM4thWPqqy?=
 =?us-ascii?Q?ZIQeZpHpVh+CgPGRxXSFE8QXq8jgP3jsU/6C68y11PIwJcRP4XGUz9cecS25?=
 =?us-ascii?Q?xBZOrixyHJNaBmoGz+hnqmEOL3QzIXKK2ocVdSIPgAEvmEdPhV6moSmPCY+b?=
 =?us-ascii?Q?Rg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1949f3d0-9a8b-4517-3d6a-08dd9a2ab0e4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 18:50:30.5277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aMaBlVmN0prNs25ICUn0B3SGgn783FWRy/ZUvwWxU9fko8easkzSlbVj8DxrWpvhhlmWyn+ls7vnpO4QS00DUZMP0bN7y2RB4XiNg7Zd1Jk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7009
X-OriginatorOrg: intel.com

shiju.jose@ wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Memory sparing is defined as a repair function that replaces a portion of
> memory with a portion of functional memory at that same DPA. The subclasses
> for this operation vary in terms of the scope of the sparing being
> performed. The cacheline sparing subclass refers to a sparing action that
> can replace a full cacheline. Row sparing is provided as an alternative to
> PPR sparing functions and its scope is that of a single DDR row.
> As per CXL r3.2 Table 8-125 foot note 1. Memory sparing is preferred over
> PPR when possible.
> Bank sparing allows an entire bank to be replaced. Rank sparing is defined
> as an operation in which an entire DDR rank is replaced.
> 
> Memory sparing maintenance operations may be supported by CXL devices
> that implement CXL.mem protocol. A sparing maintenance operation requests
> the CXL device to perform a repair operation on its media.
> For example, a CXL device with DRAM components that support memory sparing
> features may implement sparing maintenance operations.
> 
> The host may issue a query command by setting query resources flag in the
> input payload (CXL spec 3.2 Table 8-120) to determine availability of
> sparing resources for a given address. In response to a query request,
> the device shall report the resource availability by producing the memory
> sparing event record (CXL spec 3.2 Table 8-60) in which the Channel, Rank,
> Nibble Mask, Bank Group, Bank, Row, Column, Sub-Channel fields are a copy
> of the values specified in the request.
> 
> During the execution of a sparing maintenance operation, a CXL memory
> device:
> - may not retain data
> - may not be able to process CXL.mem requests correctly.
> These CXL memory device capabilities are specified by restriction flags
> in the memory sparing feature readable attributes.
> 
> When a CXL device identifies error on a memory component, the device
> may inform the host about the need for a memory sparing maintenance
> operation by using DRAM event record, where the 'maintenance needed' flag
> may set. The event record contains some of the DPA, Channel, Rank,
> Nibble Mask, Bank Group, Bank, Row, Column, Sub-Channel fields that
> should be repaired. The userspace tool requests for maintenance operation
> if the 'maintenance needed' flag set in the CXL DRAM error record.
> 
> CXL spec 3.2 section 8.2.10.7.1.4 describes the device's memory sparing
> maintenance operation feature.
> 
> CXL spec 3.2 section 8.2.10.7.2.3 describes the memory sparing feature
> discovery and configuration.
> 
> Add support for controlling CXL memory device memory sparing feature.
> Register with EDAC driver, which gets the memory repair attr descriptors
> from the EDAC memory repair driver and exposes sysfs repair control
> attributes for memory sparing to the userspace. For example CXL memory
> sparing control for the CXL mem0 device is exposed in
> /sys/bus/edac/devices/cxl_mem0/mem_repairX/
> 
> Use case
> ========
> 1. CXL device identifies a failure in a memory component, report to
>    userspace in a CXL DRAM trace event with DPA and other attributes of
>    memory to repair such as channel, rank, nibble mask, bank Group,
>    bank, row, column, sub-channel.
> 
> 2. Rasdaemon process the trace event and may issue query request in sysfs
> check resources available for memory sparing if either of the following
> conditions met.
>  - 'maintenance needed' flag set in the event record.
>  - 'threshold event' flag set for CVME threshold feature.
>  - When the number of corrected error reported on a CXL.mem media to the
>    userspace exceeds the threshold value for corrected error count defined
>    by the userspace policy.
> 
> 3. Rasdaemon process the memory sparing trace event and issue repair
>    request for memory sparing.
> 
> Kernel CXL driver shall report memory sparing event record to the userspace
> with the resource availability in order rasdaemon to process the event
> record and issue a repair request in sysfs for the memory sparing operation
> in the CXL device.
> 
> Note: Based on the feedbacks from the community 'query' sysfs attribute is
> removed and reporting memory sparing error record to the userspace are not
> supported. Instead userspace issues sparing operation and kernel does the
> same to the CXL memory device, when 'maintenance needed' flag set in the
> DRAM event record.
> 
> Add checks to ensure the memory to be repaired is offline and if online,
> then originates from a CXL DRAM error record reported in the current boot
> before requesting a memory sparing operation on the device.
> 
> Note: Tested memory sparing feature control with QEMU patch
>       "hw/cxl: Add emulation for memory sparing control feature"
>       https://lore.kernel.org/linux-cxl/20250509172229.726-1-shiju.jose@huawei.com/T/#m5f38512a95670d75739f9dad3ee91b95c7f5c8d6
> 
> [dj: Move cxl_is_memdev_memory_online() before its caller. (Alison)]
> [dj: Check return from cxl_feature_info() with IS_ERR]

I would love for more of this changelog to make it into the
documentation, but that can be a follow-up. For example the policy
described by:

"Add checks to ensure the memory to be repaired is offline and if online,
 then originates from a CXL DRAM error record reported in the current boot
 before requesting a memory sparing operation on the device."

...is important information for the interface, but that can arrive in a
follow-on change.

It should probably also clarify the data consistency and access latency
impacts of the repair. Like it is a hardware bug if data changes over
the repair event, and to consult product documnetation about the latency
of repair.


> +static int cxl_mem_sparing_get_repair_type(struct device *dev, void *drv_data,
> +					   const char **repair_type)

A lot of my unease with this patch arises from the abandonment of
type-safety in all these callbacks... but that ship has sailed
at this point so that unease will need to be addressed as a follow-on,
if ever.

I also think the edac_dev_register() scheme and its usage of drvdata
outside of a driver context looks odd, i.e. the normal expectations about the
device_lock() relative to sysfs attribute visibility can not be applied.
However, nothing looks obviously broken, so:

Acked-by: Dan Williams <dan.j.williams@intel.com>

