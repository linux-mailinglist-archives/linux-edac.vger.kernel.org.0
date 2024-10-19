Return-Path: <linux-edac+bounces-2157-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 982DC9A4C02
	for <lists+linux-edac@lfdr.de>; Sat, 19 Oct 2024 10:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54058284775
	for <lists+linux-edac@lfdr.de>; Sat, 19 Oct 2024 08:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11F21DE4CF;
	Sat, 19 Oct 2024 08:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N1BnzFW6"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CE01DD53D;
	Sat, 19 Oct 2024 08:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729326618; cv=fail; b=RSt7GrkR2C6dSrHJoeNViZn/gxV/K0xopGKW5miyWVWG/W6B4XYcMJKkKfsPdgztjhGj2Z5KFNrgwHNjkhkUZIVp6aCZk75lCmWORohyXE8DmtLcEvVPr0wOQ1bBmqycXK8i/MCw69F+QLGBdBkLRrm1hdvOPbEOrgieOJernBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729326618; c=relaxed/simple;
	bh=kC860UNQILlYXJoY3aGl2lsAygAwRF1pXywCViXLZYw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TnNfWYmwWrRSKGXoVjAKekdM+14o0dRVlsrORwGhIHcVnquUTFZM4fSt/1e1M36GZ93jLCKhKS5TN/gH2aXzXsUyfgmd68LD/JB2PXW3dRZ+WSybGrX2ENClTHHjaNaHor2xTB36RKDGjwCLDZ4L63Y39nt78wVlLK9TX/cZS/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N1BnzFW6; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729326617; x=1760862617;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kC860UNQILlYXJoY3aGl2lsAygAwRF1pXywCViXLZYw=;
  b=N1BnzFW6Xao8cAyb4e9aM1pUBFgsru/cKHrSlDXRfogmZ7nxWbJofBrt
   EZZQTvnVWiUGXgoNETRUM46IHX3zwBq/mfypx3wfA1T/Gzn+qK9hCtiCY
   hIlAGiTsJ2tWMAFEvoapV1ZstzHEmIk59Vu9iDp2YRRwjCjuMX5j/vn8s
   FcWHhbP5CaMYl5dpbCoW0EFtMZ0j9aa39KzNcV/Q9cVDo5DXGoLAaralz
   gaXz7wZbSIilwpB7BCG87A/0BSzZrNRL8rxIHVviOZE/roW4Yc4uyB6Fe
   jU2ohTOohF38f8k2wbqigqftfP40KI7hztnaR3i7Hgktya9gnqBJvCdoq
   w==;
X-CSE-ConnectionGUID: /Q71s0S+TLS+PERURsyPmQ==
X-CSE-MsgGUID: fmX3QIKNQCWt8kZIfjE+cQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11229"; a="40226145"
X-IronPort-AV: E=Sophos;i="6.11,215,1725346800"; 
   d="scan'208";a="40226145"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2024 01:30:16 -0700
X-CSE-ConnectionGUID: 2t3rdyWOTASgHWP6P/JZoA==
X-CSE-MsgGUID: 1Wnbku4HSjOahbPw3G0J9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,215,1725346800"; 
   d="scan'208";a="79040642"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Oct 2024 01:30:16 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 19 Oct 2024 01:30:15 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 19 Oct 2024 01:30:14 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 19 Oct 2024 01:30:14 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 19 Oct 2024 01:30:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ins+dAfwfUD5ydgB2QvD0TWRFNvHqWwwYv1kdd1Q/roN4/xr4MiOUAklEi2gAeXUn2U4Cg5mm3jn2R+OGPyK3EStzzrFXUeIPWOs7ut3/ibdvrEUqVl6hU5Wzd/NURRXsOVTYmnlCVpIudbeKBTnflUXjfXqDbBjYIqcJdbotavgHfgIAbTzdaGO3oKMQA8Z5iclvh3Hn+jLDmvmxnxK8IRFo37u+aHqlVWNj+9a5vK3rljhp5EOjEMxz1ys1tdzKO3oxxtWpmQk7VS1GtkNsYq/2uiSI/6XGKCASYonaMzopB2ibxVWvK6564trrbZW2PlUjhNcEg1z42ufFU8BCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kC860UNQILlYXJoY3aGl2lsAygAwRF1pXywCViXLZYw=;
 b=xLqZXDaoqvipOohQMzalKoY+yzT5HuNRgrhN/seZSkgTZq9G6ymspt9coiH6PjHDOarasLsWzYylj8jlMVTXQCdZP21B+p3yKbkeipuj+FhOyKYB7YRTc9bwnpOqVRNswQHfgR23jFFVGJjjDXr7cyaFIjlzEbIIU8Ol4k9nEP6zmm2Q+AqF7q9KFLepYTl9c0xFSQtcvCzClhyaWL7KGFzGM5Im+rKCV226NPuRKl8wAwmbffGHH0iOAVSgR4I//Wfqwc8EUmtgdVfd3/O8RZtcFU9xvD86W6x24yeSGM7yq/PE8ZTzFnRqCBQIook5RXmUMcDARxuWmOwVoRlfng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by SA2PR11MB4972.namprd11.prod.outlook.com (2603:10b6:806:fb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.26; Sat, 19 Oct
 2024 08:30:05 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%7]) with mapi id 15.20.8069.024; Sat, 19 Oct 2024
 08:30:05 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: "H. Peter Anvin" <hpa@zytor.com>, "Mehta, Sohil" <sohil.mehta@intel.com>,
	"Luck, Tony" <tony.luck@intel.com>, "bp@alien8.de" <bp@alien8.de>
CC: "tglx@linutronix.de" <tglx@linutronix.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"x86@kernel.org" <x86@kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 08/10] x86/mce: Remove the redundant zeroing
 assignments
Thread-Topic: [PATCH v2 08/10] x86/mce: Remove the redundant zeroing
 assignments
Thread-Index: AQHbH8qVDZ35fCCPoUul5iBQZYHMD7KM+CmAgACvGnCAAA1gAIAADTjw
Date: Sat, 19 Oct 2024 08:30:04 +0000
Message-ID: <CY8PR11MB7134A69052C691C9B2812F2189412@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-9-qiuxu.zhuo@intel.com>
 <f5d4d763-0fa2-4d84-8501-28d8cd8a1dde@intel.com>
 <CY8PR11MB71344BDC1A3AB4454FE9446A89412@CY8PR11MB7134.namprd11.prod.outlook.com>
 <36673130-7548-4BE5-8E70-ACC100A0BDBF@zytor.com>
In-Reply-To: <36673130-7548-4BE5-8E70-ACC100A0BDBF@zytor.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|SA2PR11MB4972:EE_
x-ms-office365-filtering-correlation-id: 1686eaf9-a3ac-491b-5529-08dcf0183ba4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?K2xGMzlhcGNpbEd6cnR6OTY5ZDNUTWtydmprbzArbDBCdkNSbGwvUUdYRGc1?=
 =?utf-8?B?c0w2dUw1M0x2VmtGa2Z2MnB6ZnFrQnRMNE1jR0hEa2p5ckljT1VUeUFVMDdO?=
 =?utf-8?B?cEFsQnltL0VZQWZCVHZsbU91VjUzLyt0dU1SUXA3VGhNaVpUc3kxYXBqcWFR?=
 =?utf-8?B?ankxSTIyOGJscERYUW5pclFrcFdvb3ZYZUlLTXFHaXpOZVRTUXZpYlk2VkVY?=
 =?utf-8?B?c3NCck10RG13ZTE3eUwwdFhuQ2s4OWVpR2hGSTBtZ2lNd1FScTR2cTFLVGJq?=
 =?utf-8?B?TDVjSllNZ3IxYS9SUUZ1ank1Q0JZSEVxZlI0Mlc1VjVLakRMY1ljNWJtNU9U?=
 =?utf-8?B?ZXdVbGQ0d1lpQ0hlekpRc1A1RGlhSU1FYW1tdmZHMTZFS0VSaG9OTEtsZW41?=
 =?utf-8?B?OUM1bzc2Z1M2amhibkNGeklpNHpxRERLUGJ1OEJOWmo0YjJPdVVDdWtVNEFR?=
 =?utf-8?B?M2RQKzFHOUt2U1MzMEdlQlpySTl0ME43TVhXc3ZTb0EvY0lwN1M4cXBLd1lZ?=
 =?utf-8?B?ZkNRUE1ETzBXenhQVmhNL3R2TmdPS2hhd0s1SkczRDR4WGVJOUJ4K3Y1RE9W?=
 =?utf-8?B?dnpOdTNlSTNLS0RVbVFEdDE0dk5vc2czNGZMQjJBTVNIUno1WjhrSk9wdVBa?=
 =?utf-8?B?eFp4Ni9jRHdVNjlGUTNyRUd6TzJwbk1COEY1SmYxOXM4dWdzT29jdGxXMElK?=
 =?utf-8?B?ODB1em45bklyWS9jYzIrcmF4Rk01RDFyRTNlak5ML3Ntbit4U1AvYTlMOFBv?=
 =?utf-8?B?T0s4WWFNL1RBNlFENFg5RzlkRTJib0lXWVpFSDZJTjBRdlpQNlYyb2RSdEdZ?=
 =?utf-8?B?QitIQ3JmV05Bd1ZxbFAwTGJ0YjFIYTFvS0kxRWh2RXNLbHpLM3Q2TXhtZHRH?=
 =?utf-8?B?YW9xOXFhenp0SEJVbDViWWk2UzdQeTM1UG5KSXZyUS9NZzY3RzVKWVFmSVIv?=
 =?utf-8?B?bHkvT0ZKK2FtVDVRQ0I0ODRhc0x5dmh4MFBMVFNJQlJidnFMVGttWDlKalB6?=
 =?utf-8?B?d2hVaStIMm9oWElKL0dEa1l2bjdUYlNLRitOMjRWb3hTUk52ajlqWTNmeTQ5?=
 =?utf-8?B?Y09XaUlVOWFLamQydzNrRWduclVuQ1lFVWs2N2o5WHcvWklMZEdmZzN0d2Yz?=
 =?utf-8?B?Q1VXL0RBYzhVWFpmQm5BZEVScU14MysvMnpmT01veE9DZ2JNR0QycjRWTEp2?=
 =?utf-8?B?RHUwS05ldVNvRTFoUGdHZkN1SnhlTXVEMk1YS0ZZSnV0U1N4Z0s3YmhPMWpB?=
 =?utf-8?B?UmFDSStjT25MQ3RDclFxWENPYStaODJjMkl5OXJxcDBrTTMreTA3ZmlEMElV?=
 =?utf-8?B?ZCtTdExuQ0lnSm5NcnZlYTVCWHV6M0JWcTU0L0pCVXp1Wnh0NmhIZGxBUGtX?=
 =?utf-8?B?Z2V3bnNub3VkcVFtdVMvZFhEWEhWZ3hIVFNub2h6NzNQbjJnaGNyM3J4alkr?=
 =?utf-8?B?Z2xnOW1vMlRKVG5MbCtIai80MUJSK0IvOUlNK0IvcmJqMldTSFVKWTZaSnY2?=
 =?utf-8?B?WCtZNUhrdE5QejNRQTNiN044S2FpVEhoSkxMQU8xWnVzTnZRZnJkcTRQNFdT?=
 =?utf-8?B?bG15QXhaOThtNys2VmtWUkpwZDcvT09OUlJ5YWFhNmp2dkhLM2RoKzBCb3NS?=
 =?utf-8?B?dFIxV3FLMXVJa3RuVjRCdUJjcmIzSEN0TElXTndXODFMV0lxdkZma3NPR2Zu?=
 =?utf-8?B?RW9aa0dIa1drRGhmR2E4c2RoTzZmdFdseXF2ZGNGTXd1MEdnYzFIVHlPb09S?=
 =?utf-8?B?MkczcExyaTRIRUR6NVZ5N2dHUlBpQUpWdi92U0xmbU45RXVOVFVvb2E1RmxD?=
 =?utf-8?Q?XcdefpdlLi9HpMYXUP4lgOxgVBXJSwBkJqhiQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UXJmeUNucGZvaDNudkhlSFZyN0VBTmlNb21DcFdsa2ZvTzNvUUhVZG9KQXN1?=
 =?utf-8?B?bGFQV2cxcjROd2l1ZE9hakRPT2lFSUR1YjkyRnk2ZENwNVk0Nm9aWmlBZEtY?=
 =?utf-8?B?ZzFtdHRxWnZoNmY4QVhVZ1JDMXB1N3F4ZEFrNXVLcENHMDdwMVhjaml1SThm?=
 =?utf-8?B?L2VPTXVUUytySjVzeTkvcGFzb0dMb1VWU2hXUDhYNUxFUzNxQ00rUlhmSVU4?=
 =?utf-8?B?blI2Z1Q4bnhnbVNwVzJ3b3dxTk0yMU41UVN2UFJaYXZyQm5rWk9iWUtaOFJL?=
 =?utf-8?B?Q1E3ZFh0WWlGU2N1WXVtRGkreWxubWpCL2JrdGVLQ3A1T0c1UkpSZmxaYXJQ?=
 =?utf-8?B?aGVVNFBrVktWVUxGaENiUXRTY0l3T0tSTDU2SXhackVGNUUrYUdUUG1rY3Za?=
 =?utf-8?B?RkJvT1RiOHYyR05LeEF2d0d5SnFteFNTblhDbVBvdEd2S01tWmxtZnpMdmxp?=
 =?utf-8?B?d3UzSTFTS09RaWcrMzlDRWFiRzZmUlE0U0hiSFhDOFFMeEJtN01VN1hvS3Ux?=
 =?utf-8?B?T1JBdG1OV0RlZWtCVzR3clNuVGdqK1N6cmdqcGY5b3gyRU1WbjM5cS8wR3Ny?=
 =?utf-8?B?bE9lZm9reWhkT0YyZWZBSTJiTjNLWTBNTVpnakJML3JBNXN5STkwTEVsNk1q?=
 =?utf-8?B?R2hmdWdqVU1qRkVEWkphc1kyTDNsSUVxalJCYk9XUDJxUDNhcW1TTzF6WmJD?=
 =?utf-8?B?NExDc3kySENzVXFNMG85VitQalRWQ016M0M0ZnJNSHBHMWJucmNtTjJQNmpl?=
 =?utf-8?B?VzlLVnFYZVBqaDBTRzkxejQxanJDRERRM08yLzFzbGMvdmFCV1BweEZOb2Zs?=
 =?utf-8?B?ZVkycE5GMlRiSWFoeVBpRS9TNXdla2cvRGR1blJFcFFWQW9BNHRaYlFUYWYz?=
 =?utf-8?B?WFJKc2VPRm1ZQVQ5KzcwOVZvZGE2TGFST2wwUmZKbmpYR0s0K2JnZmRXbS9N?=
 =?utf-8?B?eHp1b0RRaEpBYzNva0RObTJ0ZWRyVWdiaXFIVEFMZ2ZQRjZQUFhqQ0l3NFV3?=
 =?utf-8?B?a3BlWlVpdXhCb2J3V3lqdTN1RFA5SkxCMFJTbkFPR0N2VGtpK2x4OTRwUkNI?=
 =?utf-8?B?bllJbC9KSWZyRXdFVnZGdWpnZEdQUU1OdGFOQThCcGkvWm01QWRvd3JwUFg4?=
 =?utf-8?B?VmFrWFU3SGtYOXh3OU05K2JWdjdjMXRnK0IrNkVvUGRIVW5XTmU1QTZ3TzF2?=
 =?utf-8?B?Sm95VWw5K3hIRCsvMnZpT3RtYXNmMWxVWk9uVmdLdGVtRDJyZTBFeEpHRnRE?=
 =?utf-8?B?NGJUdmxwZFhYcE9sTXY4QkxuNG1LaS9DQStFK0VHdUY4MU9pM1FiR09VYlZy?=
 =?utf-8?B?Q1dlNlVIenI5WitaRmZLazBmMmlrSlRCcUllY09mYVBPNnNUeitzeUpJSVB1?=
 =?utf-8?B?RGsxV3BDTTFYb3VOdGdpcnJ0dFU0ekxUbk52MStNeDMrTC82Z1Y0M2RqZ2kv?=
 =?utf-8?B?QmZFWTVPeFo0YVJXMnVSdjlzSkt1WXNDdThDS3lidS9XeEEwRmt6SDVDUVBv?=
 =?utf-8?B?a2JkV04wSHFodXgvZ1l5VGVNZEszdGlaUS9PMElBd1FlU1JwWUtLYmI0TFRy?=
 =?utf-8?B?dWx3c0lBQXdFekdYK3kra2h1d3E2UStZSTVxUVI5SGtJMURyN2lPUU5vYkRU?=
 =?utf-8?B?bWg0cFpNM25kZGRvSitaSFRLbEpWbi8vZkJMbXhMWE5KTUNRTWVFSkNTNHVG?=
 =?utf-8?B?ZlM5dnNpMmpYNTlrcDFSdTlkNk96VXVObEhKbStDT3QrZzcrS01jNGFmaTdh?=
 =?utf-8?B?ZE5ISGFsSEo0SlFWVks2eWRwWEFxUHJTM0VXV21QU0dQUTN1ZEFiODluMHBr?=
 =?utf-8?B?V2FlTXBpUjNJdkl6V05EdFJIbVdrNkxBMmhEOTBwVUppT2p2TDZCdjdlWjlO?=
 =?utf-8?B?eXlFTjRMZnpBdDhiVzBkRHJ4aXRQckpqc0VURm9pMjdRQUdFK0NGMkJNNlNK?=
 =?utf-8?B?UkRBdXNjTEpUMVV4K1NiVTk5QzJvenFvQnNidnowZGQ3MkY1aklxaGNsTFpa?=
 =?utf-8?B?cnJDUlRZcFpzb2xqU3BwaUdtODNOcGswQkhnazJNbFRQL2NNdHZXeElCelhV?=
 =?utf-8?B?NTJ5UUtvZ2tGNUszUkV1QkwrNDRCNHlHRUdhMURTYy9RejZKajZwNkFWaFU2?=
 =?utf-8?Q?2sbq/B+RDbHHKdmPXzNizOvCK?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1686eaf9-a3ac-491b-5529-08dcf0183ba4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2024 08:30:04.9735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wA1ES++nE7dJL4GBiNowkys4ZqerkINRcEF+dNcIcoxRi/FU/4sS+0ZmOxs39tvh1RUzKrwJcLOjj3B9aUuE/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4972
X-OriginatorOrg: intel.com

PiBGcm9tOiBILiBQZXRlciBBbnZpbiA8aHBhQHp5dG9yLmNvbT4NCj4gWy4uLl0NCj4gDQo+IEtl
ZXAgaW4gbWluZCB0aGF0IHVzdWFsbHkgdGhlIGNvbXBpbGVyIHdpbGwgcmVtb3ZlIHJlZHVuZGFu
dCBhc3NpZ25tZW50cywNCj4gYW5kIGlmIHRoZXkgYXJlIHRvbyBvYnNjdXJlIGZvciB0aGUgY29t
cGlsZXIgdG8gZGlzY292ZXIsIHRoZXkgYXJlIHByb2JhYmx5IHRvbw0KPiBzdWJ0bGUgZm9yIHBy
b2dyYW1tZXJzIHRvIG5vdCBpbnRyb2R1Y2UgYnVncyBpbiB0aGUgZnV0dXJlIC4uLg0KDQpUaGFu
a3MsIEguUGV0ZXIuDQoNClRoaXMgaXMgYSBnb29kIHRpcCB0byBxdWlja2x5IGNoZWNrIHdoZXRo
ZXIgYSBjbGVhbnVwIG9mIHJlbW92aW5nIHVubmVjZXNzYXJ5DQphc3NpZ25tZW50cyBjaGFuZ2Vz
IHRoZSBmdW5jdGlvbi4gSWYgdGhlcmUgaXMgbm8gZGlmZmVyZW5jZSBpbiB0aGUgdGV4dCBiZWZv
cmUgYW5kDQphZnRlciB0aGUgY2xlYW51cCwgdGhlbiBpdCdzIE9LLiBPdGhlcndpc2UsIHRoZSBj
bGVhbnVwIHByb2JhYmx5IGNoYW5nZXMgdGhlIA0KZnVuY3Rpb24gaW4gYW4gdW5pbnRlbmRlZCB3
YXkuDQoNCi1RaXV4dQ0K

