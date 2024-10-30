Return-Path: <linux-edac+bounces-2358-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 822909B6983
	for <lists+linux-edac@lfdr.de>; Wed, 30 Oct 2024 17:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5CD41C20AF3
	for <lists+linux-edac@lfdr.de>; Wed, 30 Oct 2024 16:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECA5215011;
	Wed, 30 Oct 2024 16:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rlc04MG/"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E652768FC;
	Wed, 30 Oct 2024 16:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730306949; cv=fail; b=OeU103D925Q4sJpo1QCc9EH5/s/Mi11fZkiynyoyk5S2z5U23TCVWP3bzedjiAgK/xtSwzhOxy6h5WnEzxCHgCJnNBUmIGqN0U5MyzjK0mxrbOjINTJTUSNvczOqm3X5wcRLv4sqZ3yp86SlLHzOfR6ayAgzfZ17SziQvj9t4uU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730306949; c=relaxed/simple;
	bh=DYa21Of2PehToAGwvbpnzH2WJq7StncLhhuaRP2aiNA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IcNsWBmA4VJ+YS8fzQNaIKRMP8kqa5Y6/rn06hJg1rcUvmSASUqQdzN3TyN/2W+RTzezqhhSqE6E71Olsv74HHtaV1/drm9XbKe1Z7Kkfi+o7qEmQCJSSJAU31TARInLKmXvXq2zpvX30bICnw7hZq/9wLp1F8no1Ci1RAGzRcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rlc04MG/; arc=fail smtp.client-ip=40.107.94.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BIIwe2TWJdT+nPkE/TruodTMvZvXHWPrT4Mj+9L6b+vIlx7FDLZg82NjtcSfDrYcDEWxkP/Q8hbxrx9K1AzfVwhQZZLKfY5VqSiihSO1S8lnmOSnUIApKGg1LQspJu5xRhbafDSZernhDgIPNdxSNj/+LeozBxeFRihKxNe655/e9QyD+NSHGdJRgcJ6dFO7aKKE4BDvEAca0ZlfahTATUcnoNeWjdxyLsceanBi2SfdIDQmxLhPajPqlyfD6ly9044QBp8bO9gyfDbvsuuyG94jfk+z6SIZp05LnkgEfVtJ5w2jpNgM9YexKmPAiANv6xI9K0HmKJ4tqLqOMbLvvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dcNdRap056SjhfQCKLqJQWiyGryuUFvTl3sH0t7Uz2k=;
 b=yPZ/pMu9YAgFWDqFdy5t7TsGxmryii09ommW4isqbFoHvv6jclNFDplDpEQFRIAdIF7ve16cIZO2KJrls61Wr2I4aD1R+DC7E+ZOR6FUvDHk/fpT0XL7zKwa//Ace3s6mjdnfGxSt5qIKIOCFmY4R0m7okR87xDC9e3n/INrSg3A2geXEZoo5t57WXCP/s/VIbfjUJIzAKwvjhgoTwgW8zMPxMabMtFNKeAb2VxSpWdIDNur8ljVbyexpdu6gdZbVXxZP7hieA/ephCpBXmQ4uPartSMTrf7ecpT2E1xS6hhgagDpAD1gjck/V+QBn6MUDEd2Oet7DUQlMVKGc4LFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcNdRap056SjhfQCKLqJQWiyGryuUFvTl3sH0t7Uz2k=;
 b=rlc04MG/C4pO/dr7nNf2wzRHgiRF1zy8y1ne5WWHoHBFlrrwVaT3Bqnm1v/LFe+QYjZWFWXfKuwMogI9zxQgSdLJOcUym9UkU2ikTPqnPsjH4QTYBVn4I4Eu455qvY7NdVcmA4sER+B8ZdaGYQg+dOVlVKxUFaIw+3IngYNxlNs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5388.namprd12.prod.outlook.com (2603:10b6:610:d7::15)
 by PH7PR12MB8106.namprd12.prod.outlook.com (2603:10b6:510:2ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 16:49:02 +0000
Received: from CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607]) by CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607%6]) with mapi id 15.20.8114.015; Wed, 30 Oct 2024
 16:49:02 +0000
Message-ID: <826bd51c-87a6-4488-8142-ccf7e5e62b71@amd.com>
Date: Wed, 30 Oct 2024 11:49:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/5] EDAC/mce_amd: Add support for FRU Text in MCA
Content-Language: en-US
To: Yazen Ghannam <yazen.ghannam@amd.com>, Borislav Petkov <bp@alien8.de>
Cc: Avadhut Naik <avadhut.naik@amd.com>, x86@kernel.org,
 linux-edac@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tony.luck@intel.com, qiuxu.zhuo@intel.com,
 tglx@linutronix.de, mingo@redhat.com, rostedt@goodmis.org,
 mchehab@kernel.org, john.allen@amd.com
References: <20241022194158.110073-1-avadhut.naik@amd.com>
 <20241022194158.110073-6-avadhut.naik@amd.com>
 <20241030161550.GFZyJbthMO_2Wxe3bV@fat_crate.local>
 <20241030163147.GA1379143@yaz-khff2.amd.com>
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <20241030163147.GA1379143@yaz-khff2.amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0052.namprd05.prod.outlook.com
 (2603:10b6:803:41::29) To CH0PR12MB5388.namprd12.prod.outlook.com
 (2603:10b6:610:d7::15)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5388:EE_|PH7PR12MB8106:EE_
X-MS-Office365-Filtering-Correlation-Id: d1138e25-2088-4656-cac3-08dcf902c1f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QXNMK0tqSVgwd1dNUllkSXkxQWc1OUpya0dWSFFVQUJEK2xpaXJCQ2lkbEx6?=
 =?utf-8?B?eWYraTQ5SytPM3dZcTJmWXN5YmhnaFdCT2hkOWNRNGVmUDRpcHpXbEVQQnVw?=
 =?utf-8?B?SDViaXFKVTlOa1pwbWFpWktvckNRTklUYmF5aGJRTjNjUUNzU1JFYTVpeEpu?=
 =?utf-8?B?ZkhjTlhZUzVORVdQMkhCWCtUTThsTEtiMkR4TVFGcFBITE5OeTRYN1ZNUUZQ?=
 =?utf-8?B?ekJHRnJLNzRIMVo5UDdhN0pZaFFGYmYrMTNKZHpFYjFtUzBvanRtc1Vqb1RE?=
 =?utf-8?B?MFpwUm9Vb0ZFNmdub0xhdGNkNFRzSW1XRStORGtjZGpWWU9IYjBKOTE5Rjg3?=
 =?utf-8?B?K00rQ01nczZkbldJNndzK1kycEtUc3ZWK0w0N1VsVUZsWWdJdTFVNlVmdldP?=
 =?utf-8?B?YnFnV0JmK0dYV3dJcTFaR2d4OXhkSG15QnNxcXczVVVEQ3NkQm9Sc2J4bGlI?=
 =?utf-8?B?WC9GVEhPMVFTcEhiYmxEWlpYV1dKRGxVZWplT0JyV0s2Ny9XTHZ1c2d2ZDVT?=
 =?utf-8?B?a05LRzVhSm5LNm1JOEU4MXNBTWtnMTlBTE5iOXVjUmw5NDBKaDRBMDNjQm1z?=
 =?utf-8?B?Z1hlQlhLRUdRU1hwR1FjVFI1Y09LZHpueS94LzVmbDJacllnWGF3V0k0ZEsw?=
 =?utf-8?B?ZEZPNE5XOE5lWTlkWDBUbzJCS3JwRUtwQ1BlSm1YWWRDL01SUi9UVkROb3hG?=
 =?utf-8?B?cmdFQXFsZGI1MmtFSEFUSnJxeERmQ1NwWmlCMG9HcjFyV0lJTzhZSngzSml2?=
 =?utf-8?B?QTB2VGFYbFlnTkR2UU8veTZ5bklZZ202TFpaS3M4enRYaTFqb1Z3M0FYYUhM?=
 =?utf-8?B?cjhlcFI0ZFlDQnlNb1F3eUoyWFl1Nk9OdG8wVm8rQStubFlkSmJrTkpWbng4?=
 =?utf-8?B?djk4MHBaOXQ5TXJwcHArWnloM1lhbTdQR1lkMjVqM0g3WEc1QlFGMXRPN09D?=
 =?utf-8?B?VUYzTENVWnNKbmRmODFEdVI4ZGduODhNRFBkRnE4RVNBY2ZCMjQwdmJJYi9L?=
 =?utf-8?B?a08vUEIrN0RYaG1jMkVCcndFSXpuU29UR2V0ZGxlM2w0SEtMSmVGZTFEOE15?=
 =?utf-8?B?TENZSko0d09adWhCQnorTDJkdXNmYTdIY3pTUTdieTdZT0dZTGZ0MEhpeXlk?=
 =?utf-8?B?OC9hZmpmNFN2cmpXQVc1WEhLenFmT1crYkNqTlJKRFZqMzJ1cmdrUk5uL3ZR?=
 =?utf-8?B?UEZqTGdXZ1N1SVpuVmVlajNnU2t3c3cwWVJ0MjltMVJ6dkx2eXFoUXdrRWhY?=
 =?utf-8?B?SkxhcGNOajJkYTZvSVRPWUJBU0xMMXpteldTbVY5UytuUExjRXpISkUweVZs?=
 =?utf-8?B?TEJndE5Sa1kvOWtTK1o4NEdPSUpRV0diMnJhMTNuNEZmZTZ1UzRiRmVpOEho?=
 =?utf-8?B?NVdDYmx3SDdLOVZxRE1ZWU4rSXMvcFBKYm44WisyNVhUUHgrNUV4a1l6bXIr?=
 =?utf-8?B?MytramRvckNQL3BjcVEvVjAxUVBNekJTck5GUUNFbFpoYmF4NHN0WkRsaFg2?=
 =?utf-8?B?aHZjNU1zK3N5Sit4R3BKRG1nbCtxZjV2cnpFd09IQ0JPblFEMjliSUpabXV5?=
 =?utf-8?B?MFhIVSt6MG40RmRFQk92OEJDdGUrNDhsWjRnRTV1MjFjM1hKZmtMeXVYNk9u?=
 =?utf-8?B?WXl5QlllZ2VUVXI2OTBNajAyU2l3NER0VlJqTFFzUUovcVNxNUdGQ3BpK1A0?=
 =?utf-8?B?dUN3WmRhL0JFdUt2RmxqYitBZUxkcW1rODQxY29Pa01yMzNmdGpXR3V3emZJ?=
 =?utf-8?Q?NVdfrYNpy3Z2BiurihI1Ca8zyK7eWas5BlOGTXL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5388.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?clF0T3htVC91TEJuV1lKQzl1YWZHVG1rN3dUdXAvU29YcDhESCtpdU5aK2s2?=
 =?utf-8?B?Ym0rcVpvamRrODVTOTlKSlNJaEw5anRDc05TdTZCTHUvYjNyNENVYnNyM2dj?=
 =?utf-8?B?UzZlSlJvMzdSY203Qm1Ec0N5RnlmTVFIalRqM242YjU5RXpCMXRabS9ZVzM2?=
 =?utf-8?B?VU5ibkZ3aVhpSm42OTBrSjNQYVJJbXA1cVIxSGNWQmRXVnpjQ09WUnpucjFt?=
 =?utf-8?B?emNNclNKRFZZdElpQTEvUXBBVnpIbGJhQWpDNUVKT0s4T3B4Z0pSQmlrWkkr?=
 =?utf-8?B?Ujl5TmN3cUxQUlpIdmZ2WEF3a0JlSGcrVVFRSlJwaHdldjg0d3NiWUdMWjl2?=
 =?utf-8?B?Y245TVRGOUlKM2Q2RkpHZ3hSK1ZGOGVsSk93dWhKWEJQeGNnejh1aTM3NllG?=
 =?utf-8?B?UE15OWxsVElET1k1TTM4QklxOGpqUjlNQWFPMGNRbEcwREk2WjVxc1hmaURm?=
 =?utf-8?B?TjBHWmRiK1VxNXRXYXlRNHB2ZkliRkpVRGk4Uyt3N2xOZTB0dDlRMW1xeEJL?=
 =?utf-8?B?aU9BWWFQK1B4UjlOeTdXTmxYeGdxVTZqMDFaVEZoOHIxNEpjU1NJR1hTOHJU?=
 =?utf-8?B?Zitsc0VHZUozbEZabVZFMDd5R3Y0NW9WdWRVYUlURDRCKzBlTW1SeVV4WG9t?=
 =?utf-8?B?UnJRZ1hRcXBhOS9Ha1ZTS3Z3RnBNN3BTUEhHQmlhdThiWitxbDZCVEd2WnBs?=
 =?utf-8?B?QytvckVuVzUwSUVOYnZxeTd5VWRRbWJXZnh3VENFQkdaZlJQaE9hM0xXQUMz?=
 =?utf-8?B?WWloQnRnUDVIbHk0NWZCWWJBalppOEhqQnJXMzhNRzhxaWFEcFI5UkhrMlpP?=
 =?utf-8?B?Szl3WE9pak9iN3VlZ1BRZGNQK3I5V2xOV3E2MU8xcGJUWnUxRWtqT1p2ZVBV?=
 =?utf-8?B?cjkyUVVjUWtvL3NCOEhXYkpxREE5QkhHeE9YU2FtRkp5S2VHNlJFL0J4bHM4?=
 =?utf-8?B?U0xIWVZDSGY3b0pyeUZqdkZ6TFlDWnJoSEI2cDdTVDA1NXdRclBIcU5LWlFG?=
 =?utf-8?B?VFJXbHFIVFJyMjNGQmprYXpEVnMvRzJUY1BKbW1VRjg4NFdwc3dMMUNDL0tL?=
 =?utf-8?B?elhWVjIxYUFQaFQ1aG1EUHdrQTlmdy9vWDhoV2x1WDZPK2FKNEFlSy8rRkJF?=
 =?utf-8?B?MHNWM28wRXFjOVZKNk9qQzFjS21HdTBXMmJXK3BJY05Bb3lraWNtQTR4K2Qv?=
 =?utf-8?B?NWMvbDVCZ3BVN0RXcGZNMVA1dnlKd0lzUVMrYm4zbVhjUXpGNWJObUsvdjN0?=
 =?utf-8?B?UzZ5Q0gwWVdmMGJWa05TNm9SRmRVM29OUWhuVDlQVXBlVGRRcXpBSGdKcENn?=
 =?utf-8?B?UFNXREFrOWFRQkp6Q3Z0dUhQVXFwVDQ5QzR6TXZSTjRMbldVZ0gvcmYzSUtU?=
 =?utf-8?B?U1RFVzVoTFBOZmdlTWc2bkZVV3M1TjdHS2I4ZGlUUVlsdUUzanA4c3lndHpV?=
 =?utf-8?B?MCs0K25lNjhmNVIrRWJmZkpINldBS2VPUXNXOVJSU1V3RXVCb3NjOUcxc0JB?=
 =?utf-8?B?YVpsa3NzMEplSGZPd08xWXd6SGd3NlFrRjBPdEdRbC92QjRpMDZMYjl1MHF3?=
 =?utf-8?B?TEYxSXU5M0VtMnVRRDJtLzM2M2xsVWNRZ21KZ3BsSmFwUktydHZYWFBWUVFY?=
 =?utf-8?B?Snk4WlcyM0lKWjhvd2NQeERCVGhvRSt4ZFp5Q0FzTFJwSCtPM1hXdWQxSVlv?=
 =?utf-8?B?ZHk2NWUxQ0lVaXdwcVlTdVo2QXlhNmpEczNHQU5JWXB4ZFNBNC9ZdVppWVFG?=
 =?utf-8?B?aHRhMTJJeHFkdFRkWEt5ei9IZlZNcWlvV01RbEozM2VXNUV6ak9Jbm9pdnFj?=
 =?utf-8?B?QmZDNnMvUW44S28xQzN5My9ST3kxditSeHZJb3ZFemFmeTlGOVBoNSt5VlJL?=
 =?utf-8?B?bnBmdVdRbTF0ZjZHVVkyT3QzTW1sdDdVMDNVMmluWmljUHJ6bXNldktOelVU?=
 =?utf-8?B?b0NoaE53QlNCd2g4K051bGlTSzhLKzBYeUVWNysvK0pzZlJldmFlSXVxOTN4?=
 =?utf-8?B?ejEvRklaVkkvd3lGUnpZYjVWV3BiZ0JNWStNb21zN1l2ZW9vM3FTbFYvMnFG?=
 =?utf-8?B?VG5UblFwOEZDUWN2Vms3QkVYcGd4M1lZZk9meVZRMFNnejFwdXR3MFcwYmoz?=
 =?utf-8?Q?AcT8NEmLzj/how/yTsdTMZ6N6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1138e25-2088-4656-cac3-08dcf902c1f9
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5388.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 16:49:02.1097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qxtqMJZneFlNzEKT/xERchGAKVzCrdn73PUhY2RUKDZfjx8mRwGmxsMwJt6NjB88mupOue/9hzRhVwrHo6o9KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8106



On 10/30/2024 11:31, Yazen Ghannam wrote:
> On Wed, Oct 30, 2024 at 05:15:50PM +0100, Borislav Petkov wrote:
>> On Tue, Oct 22, 2024 at 07:36:31PM +0000, Avadhut Naik wrote:
>>> From: Yazen Ghannam <yazen.ghannam@amd.com>
>>>
>>> A new "FRU Text in MCA" feature is defined where the Field Replaceable
>>> Unit (FRU) Text for a device is represented by a string in the new
>>> MCA_SYND1 and MCA_SYND2 registers. This feature is supported per MCA
>>> bank, and it is advertised by the McaFruTextInMca bit (MCA_CONFIG[9]).
>>>
>>> The FRU Text is populated dynamically for each individual error state
>>> (MCA_STATUS, MCA_ADDR, et al.). This handles the case where an MCA bank
>>> covers multiple devices, for example, a Unified Memory Controller (UMC)
>>> bank that manages two DIMMs.
>>>
>>> Since MCA_CONFIG[9] is instrumental in decoding FRU Text, it has to be
>>> exported through the mce_record tracepoint so that userspace tools like
>>> the rasdaemon can determine if FRU Text has been reported through the
>>> MCA_SYND1 and MCA_SYND2 registers and output it.
>>
>> IOW:
>>
>> Author: Yazen Ghannam <yazen.ghannam@amd.com>
>> Date:   Tue Oct 22 19:36:31 2024 +0000
>>
>>     EDAC/mce_amd: Add support for FRU text in MCA
>>     
>>     A new "FRU Text in MCA" feature is defined where the Field Replaceable
>>     Unit (FRU) Text for a device is represented by a string in the new
>>     MCA_SYND1 and MCA_SYND2 registers. This feature is supported per MCA
>>     bank, and it is advertised by the McaFruTextInMca bit (MCA_CONFIG[9]).
>>     
>>     The FRU Text is populated dynamically for each individual error state
>>     (MCA_STATUS, MCA_ADDR, et al.). This handles the case where an MCA bank
>>     covers multiple devices, for example, a Unified Memory Controller (UMC)
>>     bank that manages two DIMMs.
>>     
>>     If SYND1 and SYND2 are !NULL, then userspace can assume that they
>>     contain FRU text information. If they will report other information in
>>     the future, then a way of communicating the info type contained must be
>>     devised.
>>     
>>       [ Yazen: Add Avadhut as co-developer for wrapper changes. ]
>>       [ bp: Do not expose MCA_CONFIG to userspace yet. ]
> 
> The entire struct mce_hw_err gets exposed through the mce tracepoint in
> patch 3 of this set.
> 
>>     
>>     Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
>>     Co-developed-by: Avadhut Naik <avadhut.naik@amd.com>
>>     Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
>>     Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
>>     Link: https://lore.kernel.org/r/20241022194158.110073-6-avadhut.naik@amd.com
>>
>> diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
>> index 4d936ee20e24..649a901ad563 100644
>> --- a/arch/x86/include/asm/mce.h
>> +++ b/arch/x86/include/asm/mce.h
>> @@ -61,6 +61,7 @@
>>   *  - TCC bit is present in MCx_STATUS.
>>   */
>>  #define MCI_CONFIG_MCAX		0x1
>> +#define MCI_CONFIG_FRUTEXT	BIT_ULL(9)
>>  #define MCI_IPID_MCATYPE	0xFFFF0000
>>  #define MCI_IPID_HWID		0xFFF
>>  
>> @@ -212,6 +213,7 @@ struct mce_hw_err {
>>  		struct {
>>  			u64 synd1;		/* MCA_SYND1 MSR */
>>  			u64 synd2;		/* MCA_SYND2 MSR */
>> +			u64 config;		/* MCA_CONFIG MSR */
> 
> Anything that is added here will automatically show up in the
> tracepoint, since it's a dynamic array. That was one of the reasons to
> do the wrapper struct idea, right?
> 
>>  		} amd;
>>  	} vendor;
>>  };
>> diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
>> index 6ca80fff1fea..65ace034af08 100644
>> --- a/arch/x86/kernel/cpu/mce/amd.c
>> +++ b/arch/x86/kernel/cpu/mce/amd.c
>> @@ -796,6 +796,7 @@ static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
>>  
>>  	if (mce_flags.smca) {
>>  		rdmsrl(MSR_AMD64_SMCA_MCx_IPID(bank), m->ipid);
>> +		rdmsrl(MSR_AMD64_SMCA_MCx_CONFIG(bank), err.vendor.amd.config);
>>  
>>  		if (m->status & MCI_STATUS_SYNDV) {
>>  			rdmsrl(MSR_AMD64_SMCA_MCx_SYND(bank), m->synd);
>> diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
>> index 0a89947e47bc..19a1c72fc2bf 100644
>> --- a/arch/x86/kernel/cpu/mce/apei.c
>> +++ b/arch/x86/kernel/cpu/mce/apei.c
>> @@ -155,6 +155,8 @@ int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
>>  		fallthrough;
>>  	/* MCA_CONFIG */
>>  	case 4:
>> +		err.vendor.amd.config = *(i_mce + 3);
>> +		fallthrough;
>>  	/* MCA_MISC0 */
>>  	case 3:
>>  		m->misc = *(i_mce + 2);
>> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
>> index fca23fe16abe..edc2c8033de8 100644
>> --- a/arch/x86/kernel/cpu/mce/core.c
>> +++ b/arch/x86/kernel/cpu/mce/core.c
>> @@ -681,6 +681,7 @@ static noinstr void mce_read_aux(struct mce_hw_err *err, int i)
>>  
>>  	if (mce_flags.smca) {
>>  		m->ipid = mce_rdmsrl(MSR_AMD64_SMCA_MCx_IPID(i));
>> +		err->vendor.amd.config = mce_rdmsrl(MSR_AMD64_SMCA_MCx_CONFIG(i));
>>  
>>  		if (m->status & MCI_STATUS_SYNDV) {
>>  			m->synd = mce_rdmsrl(MSR_AMD64_SMCA_MCx_SYND(i));
>> diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
>> index 194d9fd47d20..62fcd92bf9d2 100644
>> --- a/drivers/edac/mce_amd.c
>> +++ b/drivers/edac/mce_amd.c
>> @@ -795,6 +795,7 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
>>  	struct mce *m = (struct mce *)data;
>>  	struct mce_hw_err *err = to_mce_hw_err(m);
>>  	unsigned int fam = x86_family(m->cpuid);
>> +	u64 mca_config = err->vendor.amd.config;
>>  	int ecc;
>>  
>>  	if (m->kflags & MCE_HANDLED_CEC)
>> @@ -814,11 +815,7 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
>>  		((m->status & MCI_STATUS_PCC)	? "PCC"	  : "-"));
>>  
>>  	if (boot_cpu_has(X86_FEATURE_SMCA)) {
>> -		u32 low, high;
>> -		u32 addr = MSR_AMD64_SMCA_MCx_CONFIG(m->bank);
>> -
>> -		if (!rdmsr_safe(addr, &low, &high) &&
>> -		    (low & MCI_CONFIG_MCAX))
>> +		if (mca_config & MCI_CONFIG_MCAX)
>>  			pr_cont("|%s", ((m->status & MCI_STATUS_TCC) ? "TCC" : "-"));
>>  
>>  		pr_cont("|%s", ((m->status & MCI_STATUS_SYNDV) ? "SyndV" : "-"));
>> @@ -853,8 +850,15 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
>>  
>>  		if (m->status & MCI_STATUS_SYNDV) {
>>  			pr_cont(", Syndrome: 0x%016llx\n", m->synd);
>> -			pr_emerg(HW_ERR "Syndrome1: 0x%016llx, Syndrome2: 0x%016llx",
>> -				 err->vendor.amd.synd1, err->vendor.amd.synd2);
>> +			if (mca_config & MCI_CONFIG_FRUTEXT) {
>> +				char frutext[17];
>> +
>> +				frutext[16] = '\0';
>> +				memcpy(&frutext[0], &err->vendor.amd.synd1, 8);
>> +				memcpy(&frutext[8], &err->vendor.amd.synd2, 8);
>> +
>> +				pr_emerg(HW_ERR "FRU Text: %s", frutext);
>> +			}
>>  		}
>>  
>>  		pr_cont("\n");
>>
>>
> 
> The only changes I see are dropping a couple of kernel prints. I think
> that's probably okay. But I don't think that's what you intend by not
> exposing MCA_CONFIG to user space.
> 

Like Yazen mentioned, we dont explicitly need to add MCA_CONFIG to the tracepoint
Just adding it to struct mce_hw_err should be enough as it would then be
exported as vendor-specific data.

Additionally, userspace tools like rasdaemon would need MCA_CONFIG to undertake
FRU Text decoding from SYND1/2 registers.

> Thanks,
> Yazen

-- 
Thanks,
Avadhut Naik

