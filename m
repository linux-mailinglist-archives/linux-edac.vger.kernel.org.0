Return-Path: <linux-edac+bounces-2139-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D519A4258
	for <lists+linux-edac@lfdr.de>; Fri, 18 Oct 2024 17:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7BEB1C2093B
	for <lists+linux-edac@lfdr.de>; Fri, 18 Oct 2024 15:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC3D2010F0;
	Fri, 18 Oct 2024 15:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SHYtdD2s"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FED1E0DF2;
	Fri, 18 Oct 2024 15:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729265335; cv=fail; b=Ay7yQY45xiq1ZCAFjC5CvreJ1GN0UxjL63iNUnMcgDnm5xu6P8VxWKdqLTFx4lv+6uN4och/1Bjz2sXlrUcdw/pR8iU0pXTYRaY9YR4p8K+nTIELi9Ux3J1sOGTn5H6+LhagcLJDa/r9lIoz2+tcRryAt6OQkyTCB+rrhsnGeBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729265335; c=relaxed/simple;
	bh=5Er5suefLjZjW8W/Uzpi9O1pRDM7LKuuto8+9q2XfRU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l+y3w4p1AS2mgQbNt6S/r7bXPooJ6dlcwbdm93VlbfHQQAeHIFcoVXK7l+Zb6JiwrDHvX9AQ8+4kdkYmS142o/gPFX6dEoH69zmkXUhLJoRLV4NjZRigl6jbSbjjQPeYUQwvod632Gv/CtbhhpHWq1cU7nR7UfbTArjfxulYrIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SHYtdD2s; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729265333; x=1760801333;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5Er5suefLjZjW8W/Uzpi9O1pRDM7LKuuto8+9q2XfRU=;
  b=SHYtdD2sK9WJHq2mN5pepDzCCnP2+r2wNI2yam/YwDcjF7JpykCmT0y4
   gSB2jwzu0yN2k1l0reo6DIR4pXYYboWVzfI/1Xg/Urz3LnExCldxvC6Mi
   ZLR9OKNG37W03bdg4uCo7pqmal76MAMa8WY0dFR2NrNqvFevZzAbeGxL9
   oIFKddZcJpJaj3PW8vAl89qUpeHsI1SByoG3ToD/IgxKJV3lnv59pqYKm
   oc2zdR8RuGvhboTXmrnZZcbx7oRqYgykUufRzAraIYRrckTe4wDXfH4qq
   gX/LLAkAcylXJX+s8R4H9wZeoVAr8cOdBO8AoMASt0TpcC0ntCkB6d1oa
   A==;
X-CSE-ConnectionGUID: yLqCEHlwTyuIxo3IOTRgZw==
X-CSE-MsgGUID: AQ4WefkMT96+l+zcp/NMsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11229"; a="16416837"
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="16416837"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 08:28:48 -0700
X-CSE-ConnectionGUID: zrsGjmVMRYGOFDa/DcXwDQ==
X-CSE-MsgGUID: XY6BGMgeSCy1A2O6N2pOIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="79040364"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Oct 2024 08:28:47 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Oct 2024 08:28:46 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Oct 2024 08:28:45 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 18 Oct 2024 08:28:45 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 18 Oct 2024 08:28:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ctBFKLb/k1LIndZdb4BkvLWTzmEU4AcVhcDBHpQEMEm1itHB+wbh7+mYXPSsIcKlGy97ZtUo/kWuJZwbr5aGR26ZVkSpPFH0yQklN9tWeEODtcJ6UnY5w5fsRp7qkzDUJNb2GRjPUBNsqcBZrC+Fi2TEWqlpqDqOgRafU52BVheeoO5j3CIKeIP/zfTukaRcuTGxpp9qtHZT7JHSNIKv4M9PB1fD1c5WdZ5ZolDLR5Z/+WhMOQO5Phzu2fdLxH/EIc2hjXYjearGXpmc+DiUN54fXcUKwNbhVMD2jRaVATjH7ir5XXywBFiByeytdq+3LdxQeUopYm2eNXBEuamZFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Er5suefLjZjW8W/Uzpi9O1pRDM7LKuuto8+9q2XfRU=;
 b=V7ntrRlcWqMPkYQpP8GpUsAp9n/4Sq5G7wJYrxPAIu9Rkx495nirvfcUV0ZjCtr2IhhYxaw8wYkZCZmvOPV4mqCaKB9EBKlHTctvdcrtvv4akD/JQcq6AuOUeS6e59AXxDSPp1D+ZeSvHhcSqW5TcDrMkB0DzEtBBvm+V2MNMFspLnUCsAElHp4lGM91YU78lCbPAh8WcKxACQjXsetZlDSn/K431iVCFtxz0H1w6bjuUmtUHZki+b1R4Nd8Y50Mg5Ix0bjq2sL5SQNnyztxGmDKJCp5q4dg42bkP+0Z8anHsqFmX/KBoaemUOHSDlXbR4pL2hTGhmkOqcLBtNZNpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA1PR11MB5804.namprd11.prod.outlook.com (2603:10b6:806:237::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23; Fri, 18 Oct
 2024 15:28:42 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%4]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 15:28:42 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, "Naik, Avadhut" <avadnaik@amd.com>,
	"x86@kernel.org" <x86@kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-trace-kernel@vger.kernel.org"
	<linux-trace-kernel@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bp@alien8.de" <bp@alien8.de>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>, "mchehab@kernel.org" <mchehab@kernel.org>,
	"yazen.ghannam@amd.com" <yazen.ghannam@amd.com>, "john.allen@amd.com"
	<john.allen@amd.com>, Avadhut Naik <avadhut.naik@amd.com>
Subject: RE: [PATCH v6 3/5] x86/mce, EDAC/mce_amd: Add support for new
 MCA_SYND{1,2} registers
Thread-Topic: [PATCH v6 3/5] x86/mce, EDAC/mce_amd: Add support for new
 MCA_SYND{1,2} registers
Thread-Index: AQHbH5ZrC2wI9dOUOUWJkMDDdFnFkLKKh/cAgAD1tICAAEzpgIAA2cBw
Date: Fri, 18 Oct 2024 15:28:42 +0000
Message-ID: <SJ1PR11MB60838E591B5E4EE1DED07869FC402@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20241016064021.2773618-1-avadhut.naik@amd.com>
 <20241016064021.2773618-4-avadhut.naik@amd.com>
 <CY8PR11MB7134178B954B4DFFF6AEF81689472@CY8PR11MB7134.namprd11.prod.outlook.com>
 <8c71d83b-4dd2-4411-aac2-81284bf3a9df@amd.com>
 <CY8PR11MB71346E0906C0540C998730DD89402@CY8PR11MB7134.namprd11.prod.outlook.com>
In-Reply-To: <CY8PR11MB71346E0906C0540C998730DD89402@CY8PR11MB7134.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA1PR11MB5804:EE_
x-ms-office365-filtering-correlation-id: 3149c350-a4ad-438e-1e05-08dcef898c53
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Y2tmdnRVQTNqZlMxeWN1b0NSQk1iMGF1bXZ1dytMU25JVGtTRUtaQkdtcU52?=
 =?utf-8?B?ZGRIVWlodW9kaFF6QWIzVlgySE5SYUZqa2xITUJMYVZDZU1LTWFTVTgzVGZV?=
 =?utf-8?B?MkhUNXlFcjJBbzFkYVVNMjZjUWJldWVmTTMwRUtYNUdjNmIzSXRTVmVHZHEy?=
 =?utf-8?B?NEYvV05oR0lyZkY1OTdnbFYrY2E3T1d3ckg3MUt5Yjc5T0hldTRTeDJVRHVw?=
 =?utf-8?B?cW96WHkydUkwaUpoc056VjNmZnpEUDJBZ1FEMmFIa2ptbFR3eG1vYTFacnpi?=
 =?utf-8?B?cjV5dkFNSUd3bS9rRWdQR0Q3SmswK0YxWUs3a3VhZS9aMlFvTkY5dmlubzZl?=
 =?utf-8?B?ZXkvdERTRXRvckZ2VzNkZEVmT25HVHJaVEhCRkxxVWhMbTloNFdXRGlqYk5l?=
 =?utf-8?B?Z3p0Slc1L2ZCUk9yY0ZBMFJTRVcxb3I5a1hPL05SMjJwZ1lGNnZQSTFOVnhD?=
 =?utf-8?B?bHBTbjQ4cjVFbTN5cmRocUszb00xdmZBbU4vd2VqWTcxMXhZcUU5b3lYZXVh?=
 =?utf-8?B?dWpSTHNxNDFDLzJ4Zyt6ZUNUVWF6cGk1V256YlhSWlRWSk1JZzhEYk0wNWQr?=
 =?utf-8?B?NGJFQU4vM01saEtXc0hNdE1PVDgyVjBXZG5wQ3RSWW83dUU4OGlNTU5NVStn?=
 =?utf-8?B?SHhpMlBsVGczbGJ0STQ5S0RqSlJENzVQTVoyNlUvNENpREhDc1JUMVhGenhn?=
 =?utf-8?B?S283OHlSdHdvNFBuQ3BMM0R2WFE5dFlvN2Izc3doMWtaQXJDaUE3d05wRGxO?=
 =?utf-8?B?RVEyOTVxajJFZDJrWnQ5cHczM1VYemRFRWFmbHI0MTBSU3pMSHJwV3pyci9J?=
 =?utf-8?B?emVaK21LaStJZ2V4UFZXWDkvMm5jTUkzUFdubnpQY1hDVFNzWUsvbDNja1pV?=
 =?utf-8?B?VGMxaDRUbXZmeFlQTzMrbGxEcVl1aG02UzNWSWRZdXUvYlViMTJ5eTB4ZDhN?=
 =?utf-8?B?YWR6Ny9ha28xdGJlSlVMWkpVTEt4NERKSEVZMjN3aTBjRkYrRjBKK2czT2lr?=
 =?utf-8?B?TDBsbUYzaSt6UDgrYm1hNWpRZk1yY2tlYkMvaUN1SkQ0dVBycWl3NWx2cHBN?=
 =?utf-8?B?cDhwZFJ0YVlrQ1c1UWtzeFVtU2hrd29OOGtXNEdZK0tjL3pyMHpSa0g2bXd4?=
 =?utf-8?B?ekJSR2t1ZnlXQ1NadlJaeEdrRElLeDh6eUNHbFpocEZKRXF2M0Rvd3pHelRD?=
 =?utf-8?B?bnFxcElicjk3TUpMN2dWTVNwMEYvOUwyM3RLR2FhZWdsR2c2NjdlamNOcy92?=
 =?utf-8?B?WTd3SlVtSVBTSmlTcE9lYTBLbFRocDhnMzJwOWhPek1JZ2MvVEkzZlBNRkVo?=
 =?utf-8?B?NU9acTd1Zm40RTJGL3Q0UzI2UUFNanVCK1FxWTRrRENvS1BwN0xjZ3JJdDVL?=
 =?utf-8?B?dzZmVkd3eXN1WUdrb3RVd0ZuaStOZ3JZTXFUak9VR0d0aS9lYWk0Z05mUHJl?=
 =?utf-8?B?MDZPZzRJcHdadUVEaFdhS3BDUlNDNHVlTG5IZWtqdFVRcDUrNDRCWWxQVkg4?=
 =?utf-8?B?Rk94K0JmVTZKMVZSck52Zk9SQXNLUHpPZTJCdTZWTXpFdmpKZXdTemhIQjBZ?=
 =?utf-8?B?OGg5czlRSlFhMGIwSGxWV1F2T3N2OElia0dLSlZVUUVhdyt2MWNWVmNDTkcw?=
 =?utf-8?B?UDVzRE55Q09hVUxHYjErT1pYSzV3UTREMS85bXBHbTRERk1HdmxvbUVqc2U3?=
 =?utf-8?B?SGhXT3NLbUpzdVd2R2JOajh0VEpCKzMrL2lnWkMxdVdNdU9lMXQxZmJTd3JM?=
 =?utf-8?B?OWVmVGNZMW02aGZiczIwSWVIdXExY1k1MVp4bkxIMitmVkdyTXJsRStiejRE?=
 =?utf-8?Q?p3QDHy6j29UeYDOlWlP8jEpe5LXGR2TYXseS8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UUgvT3RGbGZNejdvRmtJdndxMXl2TlZQR0JKVUgxbWhudFhIMlZQM0ord1Fm?=
 =?utf-8?B?cGlLQ0c1b09oUE94aGJnN0JBanVQMTZJcVhOenlXYU1GcHdNWmVaOEFHT2xS?=
 =?utf-8?B?eHA1aUNFMDNNYzB2Zk9LL2RBeUg3R3U2S1BYbGE0aGRMUWhueUUydFZ3djZa?=
 =?utf-8?B?clVFTVVjdzZ4R1QwM2xVUEpBVHpjdGYrS3MwVGhQTnREalZVclBMY29aTDQ0?=
 =?utf-8?B?aXYyUTVSWVNoOTVybEpSckhSZm5vb1Nmb1RscmtlYVhMVFhobXJCRkxUOVFl?=
 =?utf-8?B?TDkvWGlYWWphbmlsSDFMaTlrUWRCYkh5UTQ3aGxkYUwwTlczZEdGQTc4QVBw?=
 =?utf-8?B?OXlINk1FWHo1V0FVSkQ2eU01N09CcmkrYlNSdERMdU8vdDB6czdENm9Eb2Jr?=
 =?utf-8?B?eDl6TW1pOG4valdKaTB4VjlIMkZydGNRblg2ZVY4Uk53SXRSNWtlZXl3MEU3?=
 =?utf-8?B?MWU0dEdBSS9kNkVxK3dDRG0wY0lEYTJmaEhvOWNLaHNZTVBnVlZ1c2d6RVZG?=
 =?utf-8?B?YlNqeVljMWhsb1d2aGJoTWplaUJ1cG9BSWRzWXVRNFFkTWVKdmo0SWJPdFJu?=
 =?utf-8?B?TVhzbGMvUFQwR09iQ21JaGN3WU12Q2pubkg2NXU3SW8vOEdQVVVlU0ZuOCtj?=
 =?utf-8?B?MTk5Q0dUbGw1ZWJSNm5ZODhWbWgvOElMcXo3ZXdkV3hwelMrdjY5Z1F0SWsv?=
 =?utf-8?B?RXlGNlZRZ0pmaHRydHVJMnRsTHFHRGUzam9ya1N0YjVPWTcwNEgxMjcrMEdD?=
 =?utf-8?B?RGp4OWQrckowcnNLcit4V0VtdGxkZlpRWjRuUXZNYzFIaElONEI2Q05NQUFK?=
 =?utf-8?B?WnVjdzY4U3pTSDRCWTltZDl6OEU2OVpwYnhodDF1eXMxU3hSZ1VkRW1YL01m?=
 =?utf-8?B?OEQyVmh4OXRTd0JXcHV6MkthWjAyRFRkOVhVVDFyM0g5WTd3WHd6QWx0dnhG?=
 =?utf-8?B?V3VLZ054OHptT3VNVlJJRkk0NzA1dzg4RXRYUEg1bkpPWUxTSmFocWEyalJa?=
 =?utf-8?B?anpFTFgzUVYxS28yMmcrZTRYZEtCY2ZMQ0hVejdCTlZidU9GWFBvQllxN3Vp?=
 =?utf-8?B?VEtvd2JDVElMSG44VjRSSkJXbjNqSzVGNUJ0NVB0Vzk3MjRESkhpd0hSQXBm?=
 =?utf-8?B?dSsycVNOYVpwaitEUVJrRk02TWkzcGFvVmF2Z1VrSTRvUmltSnZCenMzWUlO?=
 =?utf-8?B?RWJHOGx3NDFhd2NXc09Hb2FOTEdlUEh3cVl6UkJhNjJ2QXg0TG5qQm5OcU11?=
 =?utf-8?B?L21ycXZMNXFKK2NIejMwRTFpb2dvbHpFL3B6bkFVeHJKYmNIS1VwS0dwQkg2?=
 =?utf-8?B?OHk3NmJDSlVFY1c2VFJNWmJiRElNUmdlY2R5N2JpbmhDNitsdzZ1WkErYnhR?=
 =?utf-8?B?N0tUdWlrNWNSU0p2ak81RHZIdU0rSkxQVmREMlpqZHFDeXFUOEdadnJxcTlM?=
 =?utf-8?B?Tk5JbU1iVmdKQ1hSRnZFcHl3QUtNSkZ3d3lQVVdxMkZuQTZsNjAzcWhZSnVT?=
 =?utf-8?B?RlZDOVcvQ3hnd1RNZVdmWTZvaFllTFJzbFpVZm9LMTNpWExNc0NNc1RGSTkw?=
 =?utf-8?B?UGh4TU1SSTl3c05tUEphTXFHWTRvMUZWbkdFM3E2MlFsenBmcDAwM3NLakpl?=
 =?utf-8?B?QXBVZXFQYjBHb1BUeHNESTZhVXl4K1ZiTnpUZEEyTXZCVXBHUHYrTGh0YXZ6?=
 =?utf-8?B?dlc5OTJNWURmQTJoSytwUmtUNVk1VzJ4b2pGeVFlQkdhb2djNFVScmhkeU5j?=
 =?utf-8?B?R1hZaE5kZGdRTmRySTRUVmZGZUxZSlVuYnlTNUg0c0VDYU9wNlp0K2RKdVR5?=
 =?utf-8?B?TWZRWHg5eGVZTG5HSjVPZG80ZXlmc3FFaUh0R3l5YzVDKzM0b1ZmN1R0NXlX?=
 =?utf-8?B?alBIalZnWkxrOWFMYVFQNzViT1I3MHJid0loTi9WeklBME0vdmw3Qm5OWEZ0?=
 =?utf-8?B?Y2toWk1SVHF6c1Q3ZHIxNER6S000QnZsRTJzNTdPVWRFODRPN0U4aWNzN205?=
 =?utf-8?B?THhDVGNyaTF4Sm1KWmNwV2hKYzdNSnVIbnpmSU9mRVRzOE0zaVhPNVZ2VVdI?=
 =?utf-8?B?bUZJcFl4VHoxbHlaKzErSnI1VzBCTDNOL2VrdWUwbVgxMnl6NkxIUStXRm9j?=
 =?utf-8?Q?R+yoHCld+d8XT+w/Hwk7qmnQA?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3149c350-a4ad-438e-1e05-08dcef898c53
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2024 15:28:42.2952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xQ7xQFsGlt2KEedY/y5zjSvSPHT0IKj0oqXav+W9igedm6lQv2HFkRRKda5NYWPT+MsKwCK1o8M38YENAqYybA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5804
X-OriginatorOrg: intel.com

PiBTbywgdGhpcyBpcyBiYXNlZCBvbiB0aGUgYXNzdW1wdGlvbiB0aGF0IGFsbCB2ZW5kb3IgZGF0
YSBmaWVsZHMgYXJlIG9mIHRoZSB1NjQgdHlwZSwgd2hpY2ggbWF5DQo+IE5PVCBiZSB0cnVlIGZv
ciBvdGhlciB4ODYgdmVuZG9ycyBpbiB0aGUgZnV0dXJlLiBJbiBjYXNlIHRoZXJlIGlzIHNvbWUg
bm9uLXU2NCB2ZW5kb3IgZGF0YSBpbg0KPiB0aGUgZnV0dXJlLCB0aGUgcGFyc2VyIHdvdWxkIG5l
ZWQgdG8gYnJlYWsgdGhlIHU2NCB0cmFjaW5nIGRhdGEgaW50byB1OCBkYXRhIGFuZCB0aGVuIGNv
bXBvc2l0ZQ0KPiB0aGUgc3BsaXQgdTggZGF0YSBpbnRvIG90aGVyIHR5cGVzIGxpa2UgdTE2IG9y
IHUzMiwgd2hpY2ggc2VlbXMgZXZlbiBpbmNvbnZlbmllbnQuDQo+DQo+IElNSE86IFByaW50aW5n
IHRoZSB1OCB0cmFjaW5nIGRhdGEgYW5kIGxlYXZpbmcgdGhlIHZlbmRvci1zcGVjaWZpYyB0b29s
IHRvIHBhcnNlIHRoZSB1OCBkYXRhIGlzIGENCj4gbW9yZSBmbGV4aWJsZSBhbmQgYmFsYW5jZWQg
YXBwcm9hY2guDQo+DQo+IE1heWJlIEJvcmlzIGFuZCBUb255IGNvdWxkIHByb3ZpZGUgbW9yZSBj
b21tZW50cyBoZXJlLg0KDQpJIGFncmVlLiBJdCdzIGhhcmQgdG8gcHJlZGljdCB0aGUgZnV0dXJl
LCBidXQgdGhlcmUgc2VlbXMgdG8gYmUgbm8gZ3VhcmFudGVlIHRoYXQNCnZlbmRvciBzcGVjaWZp
YyBmaWVsZHMgd2lsbCBhbHdheXMgYmUgInU2NCIgc2l6ZWQuIFBlcmhhcHMgdGhlIE1TUiB0aGF0
IGRhdGENCmlzIHBpY2tlZCBmcm9tIGhhcyBvbmx5IGEgZmV3IGJpdHMgZGVmaW5lZCBzbyB3ZSBl
bGVjdCB0byBzYXZlIHRob3NlIGJpdHMgaW4NCnNvbWUgc21hbGxlciBkYXRhIHR5cGUuDQoNCi1U
b255DQo=

