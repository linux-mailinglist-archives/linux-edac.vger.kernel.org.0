Return-Path: <linux-edac+bounces-4096-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52754ACD79A
	for <lists+linux-edac@lfdr.de>; Wed,  4 Jun 2025 07:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02C3E177466
	for <lists+linux-edac@lfdr.de>; Wed,  4 Jun 2025 05:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C13238145;
	Wed,  4 Jun 2025 05:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UJnC9NIP"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2080.outbound.protection.outlook.com [40.107.96.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FFC2581;
	Wed,  4 Jun 2025 05:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749016711; cv=fail; b=nYo8s6SCp7iLcrjHiK1JcVA2tUthMv83fCYLbFVcep+IRa+/FU0ITSdeHEaTxnJsvzMM7xzQYO4LOPpAiWNRhnCS24thmsKCTrbWydEKXlv7Hkpb/Q7TnChrcoSFBlG07C1pHVonQTQ4aLIMaaVpsZbrDBgQQ9YRRRsQZeiArPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749016711; c=relaxed/simple;
	bh=Rf51hhLNfHCyFhdwgPrzsgesLEZz5txMBwjAPOk/ZbI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c2sibekl5PGfy1lJCvrQeCFAIsHlylwf18wPW7yS7nl5wOA9GyA/td3xsbZWyooq6QRpiYpOM/Bds5IxQl199SeJguA0+k+aLWF+PlIKM4RQmAGfa2rodImBHw8sVz/ihwXE7sWtS7vzdeT3n7gvulQP2BUgbIm2SlTBwygqXeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UJnC9NIP; arc=fail smtp.client-ip=40.107.96.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iQ57iKU4WCJo5vW0RVuVG3kGrpzKbTV+j9HKhMLu4cV7kSpKhuIEXyH4mNqEECEgacKOBgVBFV3+xrGSGv02ORYVZQbKyqNf4xpPdqPcVuOd9YjEvpBrB4IxG1a2yd4lSxNWTX6GNAl46BoE/rqunwj3Pcnm8u5/itlF6cW3AlQvCMdTJGPTi6t36aA2cLbuLcTU9fk7Z35naiSm/wIIhD5PiegZhhixVgfdEYDnJLuYT9uVokFnlpfcIgjdQiMAL7ECVWTVptOYGVkP5S4NwyZblfFWyaWCXQqp+192y/7yPJ679YtTABNjOq6sHwJFfLoNyaoY/D6I+3s1XdIopg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rf51hhLNfHCyFhdwgPrzsgesLEZz5txMBwjAPOk/ZbI=;
 b=yrFE2M+MLtbf6re9HeREaPjHd0d4oJMtsUd8uu88edlOZm0YKRL+KEY6Tx0C5SaJg6qbywZcfuFuQO6ZYX+5VtiuPXIvwGhBLogwIGS9996O5laNYFPhiwU9mlpURR2YY+sDnasRs4VjOHvpsUbeywhb0gO0dNiVGa/MpnfsdOVDlJg+SNQsqWBdkNpoj3mVdjcYHgTloxG4nLkFh65ggeAdNJM++8V9WnGVjH5NHTgc0YyGfj4l5a+gb/iqA9gxFAlB8bFIFu+cIPsLSD+FJ1ZSZFZgRJ7xpXqUr8euldsdZ+FXGNJ49zG0peHBkBHIP93thxmwibcfJZKlKp+6fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rf51hhLNfHCyFhdwgPrzsgesLEZz5txMBwjAPOk/ZbI=;
 b=UJnC9NIPcaOubxjHljQ90zek8x//9lGyHnqfNwVWIKKsKyhfcYJkOooeRtMDTVtUD0/ZDL+qoUCk87WbOQwfvniopyhdpYyTO54CmqD9HTC040g4okZZpy7fhDMvdvwKJiR6aTPddkGRdYAX/wpVU33asYm6szRzD81BwrTYtEo=
Received: from SA1PR12MB8947.namprd12.prod.outlook.com (2603:10b6:806:386::7)
 by CY8PR12MB7610.namprd12.prod.outlook.com (2603:10b6:930:9a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Wed, 4 Jun
 2025 05:58:23 +0000
Received: from SA1PR12MB8947.namprd12.prod.outlook.com
 ([fe80::8730:918c:b34b:d058]) by SA1PR12MB8947.namprd12.prod.outlook.com
 ([fe80::8730:918c:b34b:d058%4]) with mapi id 15.20.8769.037; Wed, 4 Jun 2025
 05:58:23 +0000
From: "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>
To: Borislav Petkov <bp@alien8.de>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "git (AMD-Xilinx)" <git@amd.com>, "Simek,
 Michal" <michal.simek@amd.com>, Tony Luck <tony.luck@intel.com>, James Morse
	<james.morse@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Robert
 Richter <rric@kernel.org>
Subject: RE: [PATCH] EDAC/synopsys: Clear the ecc counters at init
Thread-Topic: [PATCH] EDAC/synopsys: Clear the ecc counters at init
Thread-Index: AQHbz53DeAbkSv25gk2QG9HHGnijYrPxLhoAgAFcYQA=
Date: Wed, 4 Jun 2025 05:58:22 +0000
Message-ID:
 <SA1PR12MB894764756C6538EE985BDE24816CA@SA1PR12MB8947.namprd12.prod.outlook.com>
References: <20250528065650.27646-1-shubhrajyoti.datta@amd.com>
 <20250603090536.GCaD664IbJB5IoR06g@fat_crate.local>
In-Reply-To: <20250603090536.GCaD664IbJB5IoR06g@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=3da563c3-0301-4975-aefb-01b4afff790c;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-04T05:52:29Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8947:EE_|CY8PR12MB7610:EE_
x-ms-office365-filtering-correlation-id: 0cba78ab-2d5a-4fbb-948a-08dda32cd099
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WWRpYmFCWC9FcGZpM0xXSEpWT0t3WTJ5MzlLQUIxdnMxVUpOMVZvN0ZGK0sw?=
 =?utf-8?B?c1JKSlV3aWJpYXJVNldOK2c5SFBZL2R6dXdveUNDbjMwdXpxLzAwSElqNUFG?=
 =?utf-8?B?THRjV0FSU2dqU0lIbVJod2lzMjY1azZ0Rm96dzVDRGdibUY5RzJKaUk0ODQv?=
 =?utf-8?B?Z1l4SkJrb1hTMUpZbGM2bitRb1I3OGVOMTg1L1MrbXp3NDBaV0tHa20rbjg0?=
 =?utf-8?B?ZVM5cmp1bWFFcU1KV3hlNTlrNjRGdGR0YmpSVFBSeWhhLzFack1vSkxwUEVw?=
 =?utf-8?B?WWovcldqYWFoWHI1czlNdFNYMzdzRTNlZmtsenNmTnJEanVFdXdUOTJYemJp?=
 =?utf-8?B?dzhITTlxdWxJcmFSVDdHOHg2Q0UvOEFkamovSTFDbW9ROFQ0VTRQT0RMb1U2?=
 =?utf-8?B?aU8rbklRZFBrclVDSFVUYkY3ZGpjZCs5a0d5c1VPUE5JTnRpeERLNnpIVlFL?=
 =?utf-8?B?K0FBRmw3L1VWT01aTk9QemNRWE9NQjQ5dmlzdVE4UDEya3lobnhlSldTV3VE?=
 =?utf-8?B?cmczeU91SGF2TE5UODF1NTlFWFlLRkltQ1FONWtFckkwTExVSy85Y1V2VVRS?=
 =?utf-8?B?dTZ1Q0F6QVJwN1lMWkdvTEV6eTNZTG5RUGN6Uk1MaHUwalNEeWtrc3lhVzRz?=
 =?utf-8?B?OXNXb0sxMnNMb0x1NlhaeU53eVNxUTRvSEVjTXFVdmR4TFpENjFKNlN2UEtu?=
 =?utf-8?B?VHdpTnBMTW53NU92STF2Y1N1UkZhZjZOUzFuZ1lObU9pQkJtZU1ZSUQ2YzVl?=
 =?utf-8?B?TEt6THlaOTljUFJlMnllU3VHbit2WWxqcExZZVdraHIxc3lFV2pzRzlNTXNz?=
 =?utf-8?B?elZYTi8wRzJXaTdQajZtRE9xUzJOSmI5R0lwUElxWGZwRFJtWmpkdjArZFVZ?=
 =?utf-8?B?REVvZEtxUkNiVm1TTzd2aGxDekhpd3d6NFZzRzJybThVczY0RkxGa3ZONWxX?=
 =?utf-8?B?WTI1Y1ZoQ2pBcWhYYnZsZkVQYVMvdGtweFFZZ1JvVVppVVhMOTNpTkJLMHY5?=
 =?utf-8?B?dldtRk00RHppeW01QTNSZlc4RXJmQnE3ZmlMRmxhaWNINnliMkEvdzlES1c0?=
 =?utf-8?B?S01JVGJiSERjY3RBeEg1dmZkUGMvMnRuTGx3RGRVTUZneHFtay93REZrVVVI?=
 =?utf-8?B?QlhWYTFDbnlPSnkrMzVldEwrYWtJeEJBakFUWllnU1Z3cm9iWndrU2NDVjhW?=
 =?utf-8?B?UytyRStXOEp6KzB4NHVZRTE0Qm5uOUNMdmY2VXNFWEI5RExGcU1WVkxKMkl1?=
 =?utf-8?B?OC9tc2l0TktxazBZMmhUMThWaDZ0WEl3SmxpdTZoKzgwWHZVN0M1cFF5MjBI?=
 =?utf-8?B?Z3I2MFlYS3VjU05xaTNjUTNIbVJTMENlMjA2OWx2Vm9RK2h1cE4wYlRXTHk1?=
 =?utf-8?B?MGhxL3Z5cUN5aEpZSWFIMVRQd2E0MjV4cEcrMjVHaHhFOXZuc2Vya3oyWURQ?=
 =?utf-8?B?R3owbmxzV1JOa3RvOE9rVU9hUWdKSG5NK0NQaGJ6QmdEVTVxSE14cnFpbmZ3?=
 =?utf-8?B?Nk4yUmNWL20vcm5YbnR3Y21FTUVYU05ZdUhYc01SWXZuUVJKOTZKVlU4Wk5E?=
 =?utf-8?B?cVNLU29Ick1RNGY4aDlDcDI5NXNxbWtjSjFWaTc1dnJlejFrSDcvdHZiOUZY?=
 =?utf-8?B?bFRBWklOQ2R2TDFPTitpMDVSbFNUdVBodFN2eU1ITXdzT3V0VTRnTXJQQTF3?=
 =?utf-8?B?ZGxid0hPZEhCNC9PMTNwNXcrQ3JNZ0lFeVFyS0JWbUpSSFRuMjBDSDBocFAz?=
 =?utf-8?B?SDJwWktwLzhyMUdmUmFqdUwxNTFRd3N1T2hrVVVWek14L1ExMGttQWhIT3lR?=
 =?utf-8?B?ODN4ZnlKa01WU05SMGkwUWRUR1VCRCtZaHA3RzRId0VGOWUzYjNtTEprZmE3?=
 =?utf-8?B?Ym84VzFDL1c0MGVRZnNqaHFGRjMrV3ZCQ3RjcGZ6aGdEWVQ5V3VMeUxBQUtR?=
 =?utf-8?B?eUN5anN0L3B3ZFhKeDR0d1AyNk5VNGh6eFVlWTJoMzY2eDB0NW4vWTUrYVMx?=
 =?utf-8?Q?NOoMibJAYgmriJNEkQCAgawgy318WM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8947.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SE5xNWl2RzljbGxhUWMwTEp6V3prMVd3QkJTVGpUTGx2c1BwanZOZTFRM210?=
 =?utf-8?B?Y2IyRGNGaTR3RlRVcEZwWnQwc0REREJjQTV6aUVTRXFNdjVBNGJQbURmTGVE?=
 =?utf-8?B?dzh3WmRoc0hzcVEyWXFsZjduU3IyMVlMZnNCdU05NEV0dEZYU0p5eWQ5UUlK?=
 =?utf-8?B?S1VqNVJzN0xicWllaEhzai9rZmJaYUIyZmJFVlo4aDkySWlEaDRNeWVid01T?=
 =?utf-8?B?ZWNSaThOajh2SkNxMDg1S2NYb0RwK3Jnc01OUEVhcWhGRi96Z2FsMVhsRjN5?=
 =?utf-8?B?M2xuSjNlbGZDaERLTU05M1h6M3RtS0RzZW0rY0kySU9HK3Z3WThPUGluUURk?=
 =?utf-8?B?MlFRUE1BaU9PaWJpREhGazRkTXc0TzhoUEZhVlA1dlV5ZENvZ2NaL1hxMlZq?=
 =?utf-8?B?eTFRVmhNdS9UVURkOW1QdGlzZTZFbVFzdzFLTjFjeFpVMkNPTFA3Q2pyaGxC?=
 =?utf-8?B?SE5LbzRKUDk3TXUwanlSMEVSOTBQRGFLSityMFc1SzhmcGFKbytBbS9QMjlF?=
 =?utf-8?B?b2Q3YTdOMmdVaE9BR29ubXRKakJGNndVdlNYTCtzN2VUV0dpdUpOcGFhNENH?=
 =?utf-8?B?aFBRQW5tWlBqNkpidGR4RC81TE50ZTArUEhqVkM4WGliRVdzd2QyRTZ5Z1A3?=
 =?utf-8?B?b2J5NzNvT3RkRWtnaTBZRjNsR0tYdUVCZEl6VHJiT2FrM2hDK212ODdEaXRv?=
 =?utf-8?B?NVdTZjllU2FRME9VTTI3SWM0YjEvV1FtYytoMG1Wb3FyendabVpZYktwYkVo?=
 =?utf-8?B?dmYxSC9uSjlkSXZla0NSM0NBZG5SbGJOZ1RyTWorekZBc1RVNHhUdnlzQmU2?=
 =?utf-8?B?c1NSbzB4RWxOZnBGcGNENExjbjRYakxlcms3Yi80dVlDREVOKzBmNXJTYmI1?=
 =?utf-8?B?OWFvUFlGVWN0bWRHZEZ6dWJnd245OTJqRjIyU043aE5xTFRocFBJUnFnL2FJ?=
 =?utf-8?B?ODZNVkU4a2xzTnRVWktrMkRwMm8wak5QZkR2WWFraHZRbStVeiszQXc1eXYr?=
 =?utf-8?B?QnhjOGIybHZBOTdGaTQzNElPMlBvZmNjbUo5QVM0R3ViMEVvUThhVlBxVUtn?=
 =?utf-8?B?LzJOQko3cGVyclYyMVZoRUhIN3dmZTNUd0xxc2xramZKY2N6K2RIVjBlVXpG?=
 =?utf-8?B?QlBLL253QlBaYmRtNkNmTEdyV1NKaWdySGYxdTl5cWpoc0VwUjRjbTJpYTZq?=
 =?utf-8?B?NW03KzRGMTkyU2pybFVxRG8zNW9LVzkxeUMzNkx5dG93c3VTSGNuR2o0Vkd2?=
 =?utf-8?B?dUFRdUxUcTR2Nmwzb3BLSS95WGhDdHlhcGFKZHJZU2pyMTRWWDd0QUJwSXl4?=
 =?utf-8?B?ZlRjSFovYnFnUXJScThEdjhnWTNPaStnZDZTdlJJNnV5R2wyRyt1em1XSGhx?=
 =?utf-8?B?STBDNzJPRGh4QlZGZGVEVzJZU21TbzRwQ21yaDhlSVY3R0FIQXE3S0k1UW9m?=
 =?utf-8?B?eTc1cHNQTjVRc3M4eUJpUy93YUxJN2lNZUt0WFp3N01Ma2NtYWVqR0FCbnRO?=
 =?utf-8?B?SE9hTkNzZlNyL0p0WTAydXJMVURqSjNpd3FmN2FsUUdtamR5SUEzMFV6WHJ5?=
 =?utf-8?B?c0Ywc3A0OEU3Tng2S0I4TnZiZ0g3WUppZzh3NHgwRWQ2UEw1ZXQ2NGRmM0hl?=
 =?utf-8?B?eFQ0RDhoeTZNc1pFb1VQcGlaT0xteFdqdkNYeWRuazN0Zmd1bjJpY0hwakkz?=
 =?utf-8?B?VlUxUkxmcmRxWFJ3eEdTMEdqTGNaQ0VISUx0NVlFVEp4TzRLd05yUUNjbTJq?=
 =?utf-8?B?d1dhR3F0ZHRMcXk5WWU1OEtEYnNEdXdmNkFkTm0ySjhWMDJyczdKdnQ3WDZZ?=
 =?utf-8?B?WWJsdk9CRU5OaWdPN1g0YldSYWNiK1JMSWc1Z0xpbVFvV1MyVGRaNVRRbnpp?=
 =?utf-8?B?M1k1VVhaTXZLZE5zRE0vbkF6QjBSTk9BelpsZmpYTzgwQThCSG9UZHlpNkNm?=
 =?utf-8?B?eUlKeXFJd1NMcGZSb3lNamd2ejVTZ2xzbUFTN1B1MWdIalpFWUhVOWkyYmZZ?=
 =?utf-8?B?OTV1LzdwVU4xYlRiNXJZWm5TamVScCtaNUhBMHRLOTk4Y2lmR2UxamVDMFdM?=
 =?utf-8?B?dStnRktiem43NGRNS3RpTk90UDk4SWpvaUM2OXZ4d1k2TnJxdllPaW9Rc3Z6?=
 =?utf-8?Q?5Ov8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cba78ab-2d5a-4fbb-948a-08dda32cd099
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2025 05:58:22.9632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rkEdODZsFCHmNKrpa0lfNyWS5v8iQJBP+aCBpYEjzgbg5f+ZUMGBrpZnaAnh7XwsgUa98b+3/4tqJlmVF88TcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7610

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3Yg
PGJwQGFsaWVuOC5kZT4NCj4gU2VudDogVHVlc2RheSwgSnVuZSAzLCAyMDI1IDI6MzYgUE0NCj4g
VG86IERhdHRhLCBTaHViaHJhanlvdGkgPHNodWJocmFqeW90aS5kYXR0YUBhbWQuY29tPg0KPiBD
YzogbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1lZGFjQHZnZXIu
a2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGdpdCAoQU1ELVhp
bGlueCkgPGdpdEBhbWQuY29tPjsgU2ltZWssIE1pY2hhbA0KPiA8bWljaGFsLnNpbWVrQGFtZC5j
b20+OyBUb255IEx1Y2sgPHRvbnkubHVja0BpbnRlbC5jb20+OyBKYW1lcyBNb3JzZQ0KPiA8amFt
ZXMubW9yc2VAYXJtLmNvbT47IE1hdXJvIENhcnZhbGhvIENoZWhhYiA8bWNoZWhhYkBrZXJuZWwu
b3JnPjsNCj4gUm9iZXJ0IFJpY2h0ZXIgPHJyaWNAa2VybmVsLm9yZz4NCj4gU3ViamVjdDogUmU6
IFtQQVRDSF0gRURBQy9zeW5vcHN5czogQ2xlYXIgdGhlIGVjYyBjb3VudGVycyBhdCBpbml0DQo+
DQo+IENhdXRpb246IFRoaXMgbWVzc2FnZSBvcmlnaW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwgU291
cmNlLiBVc2UgcHJvcGVyIGNhdXRpb24NCj4gd2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlj
a2luZyBsaW5rcywgb3IgcmVzcG9uZGluZy4NCj4NCj4NCj4gT24gV2VkLCBNYXkgMjgsIDIwMjUg
YXQgMTI6MjY6NTBQTSArMDUzMCwgU2h1YmhyYWp5b3RpIERhdHRhIHdyb3RlOg0KPiA+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0hdIEVEQUMvc3lub3BzeXM6IENsZWFyIHRoZSBlY2MgY291bnRlcnMgYXQg
aW5pdA0KPg0KPiBzL2VjYy9FQ0MvZw0KPg0KPiA+IENsZWFyIEVDQyBlcnJvciBhbmQgY291bnRl
ciByZWdpc3RlcnMgYXQgaW5pdCB0byBlbnN1cmUgYSBjbGVhbiBzdGF0ZQ0KPiA+IGJ5IGNsZWFy
aW5nIGFsbCBFQ0MgZXJyb3IgYW5kIGNvdW50ZXIgcmVnaXN0ZXJzIGJlZm9yZSByZWdpc3Rlcmlu
ZyB0aGUNCj4gPiBjb250cm9sbGVyIHdpdGggdGhlIEVEQUMgZnJhbWV3b3JrLg0KPiA+DQo+ID4g
VGhpcyBhdm9pZHMgcmVwb3J0aW5nIHN0YWxlIGVycm9ycyB0aGF0IG1heSBoYXZlIG9jY3VycmVk
IGR1cmluZyBib290DQo+ID4gb3IgcHJpb3IgY29uZmlndXJhdGlvbi4NCj4NCj4gUnVuIHRoaXMg
Y29tbWl0IG1lc3NhZ2UgdGhyb3VnaCBBSSBhbmQgYXNrIGl0IHRvIHNob3J0ZW4gaXQgYW5kIHdy
aXRlIGl0IGluDQo+IGltcGVyYXRpdmUgdG9uZS4NCj4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTaHVi
aHJhanlvdGkgRGF0dGEgPHNodWJocmFqeW90aS5kYXR0YUBhbWQuY29tPg0KPiA+IC0tLQ0KPiA+
DQo+ID4gIGRyaXZlcnMvZWRhYy9zeW5vcHN5c19lZGFjLmMgfCA5ICsrKysrKystLQ0KPiA+ICAx
IGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZWRhYy9zeW5vcHN5c19lZGFjLmMNCj4gPiBiL2RyaXZlcnMv
ZWRhYy9zeW5vcHN5c19lZGFjLmMgaW5kZXggNWVkMzJhMzI5OWM0Li5lYmQyZDZlNzcxYTENCj4g
MTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9lZGFjL3N5bm9wc3lzX2VkYWMuYw0KPiA+ICsrKyBi
L2RyaXZlcnMvZWRhYy9zeW5vcHN5c19lZGFjLmMNCj4gPiBAQCAtNzU1LDcgKzc1NSw3IEBAIHN0
YXRpYyBib29sIHp5bnFfZ2V0X2VjY19zdGF0ZSh2b2lkIF9faW9tZW0NCj4gKmJhc2UpDQo+ID4g
c3RhdGljIGJvb2wgenlucW1wX2dldF9lY2Nfc3RhdGUodm9pZCBfX2lvbWVtICpiYXNlKSAgew0K
PiA+ICAgICAgIGVudW0gZGV2X3R5cGUgZHQ7DQo+ID4gLSAgICAgdTMyIGVjY3R5cGU7DQo+ID4g
KyAgICAgdTMyIGVjY3R5cGUsIGNsZWFydmFsOw0KPiA+DQo+ID4gICAgICAgZHQgPSB6eW5xbXBf
Z2V0X2R0eXBlKGJhc2UpOw0KPiA+ICAgICAgIGlmIChkdCA9PSBERVZfVU5LTk9XTikNCj4gPiBA
QCAtNzYzLDggKzc2MywxMyBAQCBzdGF0aWMgYm9vbCB6eW5xbXBfZ2V0X2VjY19zdGF0ZSh2b2lk
IF9faW9tZW0NCj4gPiAqYmFzZSkNCj4gPg0KPiA+ICAgICAgIGVjY3R5cGUgPSByZWFkbChiYXNl
ICsgRUNDX0NGRzBfT0ZTVCkgJiBTQ1JVQl9NT0RFX01BU0s7DQo+ID4gICAgICAgaWYgKChlY2N0
eXBlID09IFNDUlVCX01PREVfU0VDREVEKSAmJg0KPiA+IC0gICAgICAgICAoKGR0ID09IERFVl9Y
MikgfHwgKGR0ID09IERFVl9YNCkgfHwgKGR0ID09IERFVl9YOCkpKQ0KPiA+ICsgICAgICAgICAo
KGR0ID09IERFVl9YMikgfHwgKGR0ID09IERFVl9YNCkgfHwgKGR0ID09IERFVl9YOCkpKSB7DQo+
ID4gKyAgICAgICAgICAgICBjbGVhcnZhbCA9IHJlYWRsKGJhc2UgKyBFQ0NfQ0xSX09GU1QpIHwN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFQ0NfQ1RSTF9DTFJfQ0VfRVJSIHwg
RUNDX0NUUkxfQ0xSX0NFX0VSUkNOVCB8DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgRUNDX0NUUkxfQ0xSX1VFX0VSUiB8IEVDQ19DVFJMX0NMUl9VRV9FUlJDTlQ7DQo+ID4gKyAg
ICAgICAgICAgICB3cml0ZWwoY2xlYXJ2YWwsIGJhc2UgKyBFQ0NfQ0xSX09GU1QpOw0KPg0KPiBB
IGdldHRlciBmdW5jdGlvbiBjbGVhcnMgcmVnaXN0ZXJzIGFuZCBjb21taXQgbWVzc2FnZSB0YWxr
cyBhYm91dCAiYXQgaW5pdCI/IT8hDQo+DQo+IFRoaXMgbG9va3MgbGlrZSBhIGhhY2suDQoNCg0K
enlucW1wX2dldF9lY2Nfc3RhdGUgaXMgZ2V0dGluZyBjYWxsZWQgZnJvbSBwcm9iZS9pbml0Lg0K
SSB3aWxsIHVwZGF0ZSB0aGUgY29tbWl0IG1lc3NhZ2UgdG8gcmVmbGVjdCB0aGUgc2FtZS4NCg0K
Pg0KPiAtLQ0KPiBSZWdhcmRzL0dydXNzLA0KPiAgICAgQm9yaXMuDQo+DQo+IGh0dHBzOi8vcGVv
cGxlLmtlcm5lbC5vcmcvdGdseC9ub3Rlcy1hYm91dC1uZXRpcXVldHRlDQo=

