Return-Path: <linux-edac+bounces-3645-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BD6A9717E
	for <lists+linux-edac@lfdr.de>; Tue, 22 Apr 2025 17:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 914543B275C
	for <lists+linux-edac@lfdr.de>; Tue, 22 Apr 2025 15:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8C128F931;
	Tue, 22 Apr 2025 15:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AGwCyuuX"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2240717F4F6;
	Tue, 22 Apr 2025 15:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745336762; cv=fail; b=XhmnlwIepn27GhBRnuPG2bvyjkNxwXNFK+lFk4jhMdAH0UMAb1+OaGt8tFPu3lgsmHjj/SBJohbA3BUTX5tKQ0jjyXaoUspP7nOg90FPKIEWV+Dd2MRFhmJg3lYtH2Jxb5y4pkQeOfIJkg5+R9Y5hFpXKpXhdLnFmnVzSeZ8gqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745336762; c=relaxed/simple;
	bh=fPj+MBV0cCQ2wKf11xwl6650Rx++RZeY1SBYby5oMuo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g4bHuEP9WPxlMYVV1r02qliDa5Fgdp48MP1OQke4fvUaIWKHxzSmCupNtkmnw9WMedXpG7Q0dfXdi87A495nyPHxeJJ3tGYRCSStIG1Jy88HSgsrSJZ54HqvVMSLVZqVFslLa3lDIyGTN+dUDkMONR1SDeqCUOWU0g8tHrmZub4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AGwCyuuX; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745336760; x=1776872760;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fPj+MBV0cCQ2wKf11xwl6650Rx++RZeY1SBYby5oMuo=;
  b=AGwCyuuXYkt+0RL6TOYCgMmUb1Hu03rVvbmLUa5bfv1sXPLy1NhPhdIm
   FIoV8CC+qBXCYnpk0XFM9vivxskEzB8BeaHmMjsmJNEM8DrdkrraorbsW
   c6Na60IxxtTh9yVeGHSoaWw/Dq+OcpR4DtOKL+muGTAaeGLYJoLGdu7Bx
   l44EiGjFv7j6ykRhWwK+E4byKOu8mlf4VUNODXaqfjo3CfEkuArYNJ5En
   6zf0m/S+cy1NMwPaIlHW8FKhTI/8ivQrfoO0H7oY9cuUCKrNzlusJPcfC
   CGEkZRDyzupMdbhrW1DcPsEXmmkNWb7nTuMBGzZdLxKaHQHcS2XH9ckzv
   w==;
X-CSE-ConnectionGUID: E6FJecrUS8iByOhSOgTGRg==
X-CSE-MsgGUID: 81N6HUBgSwCs31IqMcLPdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="47083058"
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; 
   d="scan'208";a="47083058"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 08:45:59 -0700
X-CSE-ConnectionGUID: +LdEMaf7Rzms7DtvSLJIqQ==
X-CSE-MsgGUID: A+r7TXMZQqSzKrZcV0nTBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; 
   d="scan'208";a="137136970"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 08:45:59 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 22 Apr 2025 08:45:58 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 22 Apr 2025 08:45:58 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 22 Apr 2025 08:45:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SNq2PZkzsCjzwicvALYSWLDyNyv7r28YANRdJFxLqV1U1iY7HH4XEKWvAY96p0VhCbmrjGV885XIkS7SmBaH1O7SILIB8cA/DVU0b6FUUhYbMGJRU9XURlEQTLeTLqWbujEZ5pf+WiTtFj5uX9hoNPXFkks73XwlEMdhA0bPvAWeF0c0kRZp4ygnHASY25UwFWW7J3tgu5lOG9T3oB7m61uFtw/KcT1AU1TRjexWAMZ9l6y0jmcTJMOMvpzzXSpbNYWko0BgbGjFvf0lcjaQkkIefYrSbirl1bKVqMLZwBdmqEJJNQ1mhZ4NB+gOsDkT8vzGrx8L8PciAI3SulWCwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fPj+MBV0cCQ2wKf11xwl6650Rx++RZeY1SBYby5oMuo=;
 b=ZDt/IsdO/f+ut1mbtZIzKmEEH3cmOP1YFpKj9GKD1gXyW++bUBBC2WCb3uasyUTaJU0176h7PcdEGcbC/aO1vhBfm1uZQ90wIDdztC3ayxeMgLdTxOJ95zlVjs19G68ITF0aAOMGbVVaBF0kioOXnAopKYtUqgl5ALQxQCxq6YDQ+MDskC9xPtPJ6t8vqtgRjjtVjDAWgxAjdaLQCEsicjBX0BUrhK9k5VwbMfdNuTuJtfxBy37C+qGm3+FPvPwLOyeQUwZTX7fsQxlCkHygNUWDbEDRpTkzJMwr3WUY8jMBEjnBJvVZiVlFMaSn6d5HKeUWzCNF1j8bR01R2L32gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS7PR11MB6077.namprd11.prod.outlook.com (2603:10b6:8:87::16) by
 PH0PR11MB7166.namprd11.prod.outlook.com (2603:10b6:510:1e9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Tue, 22 Apr
 2025 15:45:41 +0000
Received: from DS7PR11MB6077.namprd11.prod.outlook.com
 ([fe80::509c:f906:cc6:2bec]) by DS7PR11MB6077.namprd11.prod.outlook.com
 ([fe80::509c:f906:cc6:2bec%6]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 15:45:41 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, Borislav Petkov <bp@alien8.de>,
	Jason Baron <jbaron@akamai.com>
CC: James Jernigan <jameswestonjernigan@gmail.com>, James Morse
	<james.morse@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, "Robert
 Richter" <rric@kernel.org>, "Lai, Yi1" <yi1.lai@intel.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] EDAC/ie31200: Add two Intel SoCs for EDAC support
Thread-Topic: [PATCH 1/1] EDAC/ie31200: Add two Intel SoCs for EDAC support
Thread-Index: AQHbs4zvXFyj3bexyU6tSsPV63GxjbOv09Cw
Date: Tue, 22 Apr 2025 15:45:41 +0000
Message-ID: <DS7PR11MB6077C91977BE3E577B856136FCBB2@DS7PR11MB6077.namprd11.prod.outlook.com>
References: <20250422134450.1880648-1-qiuxu.zhuo@intel.com>
In-Reply-To: <20250422134450.1880648-1-qiuxu.zhuo@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR11MB6077:EE_|PH0PR11MB7166:EE_
x-ms-office365-filtering-correlation-id: cb8db819-dcc7-4997-b84a-08dd81b4bc5f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?SDoq1K4nqQCXP3aIF7XQddTbp7ea17gJP7/Gt/SKMmVRmDmGkndDLsBYF9uT?=
 =?us-ascii?Q?C2FanubXNs54I4gJYX0UkQtPYubUqjtMUg4L/U99MYwHMxbiBV3NflUeVppm?=
 =?us-ascii?Q?khX3V3gjcOz44Rycs/Xtx77KEXWuGcUs3lDfxbA/eCwK4j884QNC8NfqXoiZ?=
 =?us-ascii?Q?aTYifEEyxI9DnagkxLl4XYCWuitKb9pUp7CWQZsO2FqDsUscC9XOgxNgMAU6?=
 =?us-ascii?Q?NY7xylZztDimwevkeVpxFokr7Us2rwRVSeSTbCoLhVMVCrPcSGduVbNrQmmY?=
 =?us-ascii?Q?JOtTDYcLGGfxryskH2UZIcYd1Vr4Nffe2NTC8wKH62jDHjZGg40YsZmsxjjb?=
 =?us-ascii?Q?IUCEJP7EkQK5PkkgXfvof2Tr/VStE1XgJ7CZhM+VLWLShHgdvlPGM33zlNsw?=
 =?us-ascii?Q?ddom9a+bH3uwb4DwcyV1E6XAYN8TT7hwg1NimLKEpoF/5YNMk7w+hUJ40T8g?=
 =?us-ascii?Q?gMBVesi2xrgMcMvDJ0odQEjp1aajCxUmYmSOYsqZM+swETah5TJ0oBi1Rwy3?=
 =?us-ascii?Q?mlZsJtdKvOXxcZGbakO5/P/Y8LmFFFrxaZEE/X/W4OjWWi3PW5uuY1n/bpVQ?=
 =?us-ascii?Q?l+7FqsrtcAEmYwXsRXfprJuFpel2dAS4oFevRSO0frM7eDjmjr3ZFb2RUuDd?=
 =?us-ascii?Q?lSZlCAFWEYlwnB5xwKPVWDW3Ylh7LLquZSMDedVy16OUqwfQFRK2tmoXMKgg?=
 =?us-ascii?Q?EO+wtricJm33+8mDHjRNzU7Np8+PdyKE9AZefe32fTMP/1KWgpEcDQzSMEQ2?=
 =?us-ascii?Q?b69uOxNk+Qh8CDeV6xg9Ocj63NWzsitjF/J344sVjaHuoCLUXjpESmJCo/mx?=
 =?us-ascii?Q?iLPp5oChO+IBzKe3a8ArRMRxqvDjV3bvlP4deG1YT8RR9HCOYpeDrQX5TFeO?=
 =?us-ascii?Q?YHGOanLRp/pgwxos7tArX2ICulBSJQrCkKpFCALqulPimTNxL5jSNlyF5HOy?=
 =?us-ascii?Q?7a5+W21IxIMmrWGymP/Y+Ev+1Cw6m4tknlgLPQ6b2VtzhkYY4O6VFWUl3Vw1?=
 =?us-ascii?Q?KTnJNoH7ozPYWyvBTHq94WunfwVZvG184bmpiDhR+C4nmc0YyjSVjbDg1fvW?=
 =?us-ascii?Q?RYZXHxUcggMlyEABbVb9BEoxXs3hygcc+MrAS/rxtc/nfR8R5afoB2Z5HLau?=
 =?us-ascii?Q?VZxePv/AGQ18u0E85iru17CIp/uW8ymxn1yQ74awcLmKUmXYhdfTQVYjE86D?=
 =?us-ascii?Q?g1l82AruUAhW837LmIGzbZSpo9klh2xhV5gYQ88lLawEsNeQOBE/iD9DTn8W?=
 =?us-ascii?Q?Xoc6GbHsbbcOeG5gpNTbum24XQitPqWRFgjh+9vg2lHfkG9ltcbdv19oSVdo?=
 =?us-ascii?Q?wVNhhIauceND7WlemZbrESNDniGLkpceWGUpCkuGsDvzQ/fJJ4YyQC5s0VzT?=
 =?us-ascii?Q?tRxqHA3Vu6qQNbJmjslGNIH9zpTcK/frx8gfvg7obN+tS5rWbU65fYb0RFEr?=
 =?us-ascii?Q?GEJWnC2hN2rKeiqlx/PzfY6iR5QgRYszE9Dv4B3oWYxO2615QdFzCHCM7FLE?=
 =?us-ascii?Q?H6jqPQ80RhZ8JO4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6077.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J10qSCQ7+nXf558n0VJ6qkiI749Xw59cr5dU5uHnHC9aktGIqu9r/axxyMtB?=
 =?us-ascii?Q?6GhBU7MRu88s8MvKFGgPEiQ/zHbduW5GwIJQKwf/72Nr9fqikMYKO+EzIQB7?=
 =?us-ascii?Q?scQpz+uy/g65Raxx/FjHRUxPsC2TMFtXwGWtg9QJsNcu19p4x9TGXBCDpZW3?=
 =?us-ascii?Q?Nd3rKij4Xhz583z73Bmt1QUuYwo/20ytn15b79Ivbyo1gaYKWSq3omT9SxlG?=
 =?us-ascii?Q?io/DX02oKTQy6kdB+rWd0rnV7WfLQXLCYk8TAy9g0Vpc0ZNnFp7yZxsQbPSw?=
 =?us-ascii?Q?NefzVRA0IlR60tEBjMtN0Mx93cwYgNnsIvheK/I7CqgmIWARllbSFAufzi7B?=
 =?us-ascii?Q?TEorjZBUVkVI/D8dsVlShcqA1sMgwY/i7J1Dz1GJBeMlci0+Dbe7Vy+DzcOH?=
 =?us-ascii?Q?nwZa+UdvBhJoAHEA4V6z5qlPgEEfjMZIA27BYyXgqiWLIOWnsk6qTyPoZ2TF?=
 =?us-ascii?Q?iDogEy5/MSd8UWp0c+8CwXPzIKDHkb2Um8UxSU+283+gLB8xj34ubdpFgSwl?=
 =?us-ascii?Q?hjyN4xIg2QmNjeobfAIRCuNiD2KzE5dDE4eH84SrKvPLwzpb2LKztIoS06AD?=
 =?us-ascii?Q?yYTgMmnLcTUkp2q3BXLSvnPjJYVQ0n5Vs06lscVVkQUj6/ijIkzkJwfqkLRd?=
 =?us-ascii?Q?vq7hfdIOba0lmJX+yrIC5V3SavbklpXl0/c7maJ1sp7XtUQHDonGMtVgKgt1?=
 =?us-ascii?Q?QFomX6E/lUOcnquK16Se/0DCiH2Q2qu8KuSJxokH0klYEGLy32NjLeip438U?=
 =?us-ascii?Q?DeC20VKnBrT7uxM25IPGMoRsIRUElVDbaxHscE5spnzYlLLmEXag8EAO3Iiz?=
 =?us-ascii?Q?pm5RgFo4K8Hrq9Ms86Hqeb2uiUXh5+nHHjfrEF6aDt/hLdi6OQ81kDonDzXV?=
 =?us-ascii?Q?oMZnlv94u1eJhGWG/LAenit8ZaLVJMkF9mqrz8cli+YmO16OzrEc1dV7yYGC?=
 =?us-ascii?Q?2o3DmtsZ9S8/3FVq0qU44rsgY3OoecVVZPX7PM5U4EJIFXCGIxoVpDsACv1x?=
 =?us-ascii?Q?uVSZt2bbwFTgKVdlWFFPmdC0eU+hiqdQPAi8uT72vH9PT3kEaEYwIKGmnRI7?=
 =?us-ascii?Q?nJio7UPFAyfbv+tlT58CRjFmH2I5oxYbz0ONiVK+fDx6YeUXHBVNI2k+9G+s?=
 =?us-ascii?Q?mQ4vVFkDU+kKhxDZrm58W/XI8uIs3nbxu8ab4j579IlsOmapgQ21Qxt0VE16?=
 =?us-ascii?Q?MdPtfM12Npbtbr7TaOevxOccPdk3Mk+F1VQW+jc9BrOJv4VkAR88CbKh036l?=
 =?us-ascii?Q?1z1AKalsEMREzAEZcjq2v2qz+ACpX95K0f4Al6aZvNytKL64zwRi79TTTSlR?=
 =?us-ascii?Q?TKT9mdVoiO0EIaihSVmDzSszGtCGgVXjZ3J3WEqTLKD4Thm5bxvEtPFEt3zT?=
 =?us-ascii?Q?YxGd1JP5N9O0q4IqN11AvQ71Lnet7vEVgt58fpR+DBIjJdzSsvsXGxidOM+v?=
 =?us-ascii?Q?qcbGEjLpBvQeLHwJIaFyQ4vN8EoaZoTiXjiAGwN0hoTVzFac/I4T/IaWyRX2?=
 =?us-ascii?Q?WfscPFPv5OjuUAYA9L4pjBitndSc9PlbwXJvwIpbGWFoQmf+sfv2SP4UxJJv?=
 =?us-ascii?Q?e++CiXJ79orlrC3uEODeHj7f2PPnh6/Ms4uMnMRk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6077.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb8db819-dcc7-4997-b84a-08dd81b4bc5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2025 15:45:41.0513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pzjRagKRy1iDi5y16cXyVhAUUz5PZHPJi4CGyKU9WyvB4aOC96BDDFvCSBTjPy/hbDJ29qbhv+OmqHu53sUJkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7166
X-OriginatorOrg: intel.com

> Add two compute die IDs for Raptor Lake-S and Alder Lake-S for EDAC
> support. Note that because Alder Lake-S shares the same memory controller
> registers as Raptor Lake-S, it can reuse the configuration data of Raptor
> Lake-S for EDAC support.

Applied to ras tree edac-drivers branch for next merge window.

Thanks

-Tony

