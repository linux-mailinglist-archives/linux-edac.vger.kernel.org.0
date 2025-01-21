Return-Path: <linux-edac+bounces-2936-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC038A18812
	for <lists+linux-edac@lfdr.de>; Wed, 22 Jan 2025 00:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F0E116A04B
	for <lists+linux-edac@lfdr.de>; Tue, 21 Jan 2025 23:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7CD1E9B0A;
	Tue, 21 Jan 2025 23:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="OAUxalRU"
X-Original-To: linux-edac@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020121.outbound.protection.outlook.com [52.101.56.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E381714A5;
	Tue, 21 Jan 2025 23:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737500481; cv=fail; b=uzLLr8YhhqhzH3sSVcD/fODa/N2LchppJzLS3gd6Vegy9X/2Ma+5H66GUtQ8WlFQ32MUw6XYtNoGcT6l36Y8h508BzX5Z6fE56QSwUwTkekdRKKllnaCP/zOeAGbmvoFldTUMo44Nir0N9HlyL8+JVhMa+hPmjSTOciQyoK9Pk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737500481; c=relaxed/simple;
	bh=GQUAD72A2kclcHjhI4KwK5GMnh0/5rOZSvLuSaY5EX4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O6GYE5Rd+gLmWrbfyKkjJs2/J+48XMlIU6g+uIOeKLcbHmjGvRVG2eWckLqqN0AyqP+GLMcnknJrpd5fDIAWcJxnysXGr96xU4fwap2Y0hzK3ovMELErLCn/tmy8/INo8U9FMKpVboD8cyKjbDNgX0Z1yiIIowff+Qste0v0SxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=OAUxalRU; arc=fail smtp.client-ip=52.101.56.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a/8btaL8RW2g/ZMBP56NfvnPRa3bbcROvsx9kw9yHYyP3tPN6bIOU/Wx1W1KdR2mUSQIfHFm9XqQ9vEGE+bUEaIa615Lk3Ou0F4p4uwDGbaU2d2I3nAhJdVxqWiS9yMRwOdEc/Rpor0Jmg84rUUIL+D2Y9u/RzPEciF7A5CA49OdyjYnRV8OGqlpEAleY2FkkooBXh788MOV6D6DaDHTAS4Q1KN2H5e6xX3Xvj4XYB6JeFSBToxQA/UQWhh/TSwm92llddq20T/pyGDKelKPGFJrJpP6hqA9todYPqfsqDt0+/g/MinkjahR3IzVxQuWvqjtsV81vfQebtdvuihjyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uBzu3VHF/3/ri/1ju2GAVvkCEAb/RpYjvjm6xQB29FU=;
 b=k3QE0q1ZIO53wFHDj6Vr9l1orc9fcvriXtyRfvNu0A4TWhtOljLLusy8nVdpo4crQaSDQFg715v8sziLLfkwtxE/Wd71SoneHCIv9iZRZhv4h+5lc3phmxBN085Dbb1selL4obr+3OAcELN9BUGW4f6Wpzk7JWHH2Wg+bpv8h97ofk+AdbePgEOreRa6Z+52FNunup7KJDzVCp/w9+bl5cnwfvtxOpkjKZxMqN54Y1eZEvI9iJM0f+8xSlCE++wJn3nbKt06kXnmlZxgOO3hnaLagnQRDR/ErZoI5WlBCGS/RNcEjRsS2yD3gK9h927jfamXJVdO0CxEjnLDA2Q11w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBzu3VHF/3/ri/1ju2GAVvkCEAb/RpYjvjm6xQB29FU=;
 b=OAUxalRUEPvo01Y9UXDGkmOaWBSQVIF3Th4MuFvHY/atzkyqqHxYXH8+cucgkWMcGomBxuTamPR+vysVyOqSpWhCc46DDWTWJZRj+Od0XEiPRbK/8OmqHQK6op/O/H3wr9iJ7oOcOe3SvR6sTppDHg/2tXUZc94qpnnvwQSnK2o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA3PR01MB8473.prod.exchangelabs.com (2603:10b6:806:397::12) by
 CH2PR01MB9134.prod.exchangelabs.com (2603:10b6:610:27f::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.11; Tue, 21 Jan 2025 23:01:13 +0000
Received: from SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3]) by SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3%3]) with mapi id 15.20.8377.009; Tue, 21 Jan 2025
 23:01:13 +0000
Message-ID: <a562f557-0530-4e29-b0d0-78d4441e06e1@os.amperecomputing.com>
Date: Tue, 21 Jan 2025 15:01:07 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 05/19] ACPI:RAS2: Add ACPI RAS2 driver
To: shiju.jose@huawei.com, linux-edac@vger.kernel.org,
 linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: bp@alien8.de, tony.luck@intel.com, rafael@kernel.org, lenb@kernel.org,
 mchehab@kernel.org, dan.j.williams@intel.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 david@redhat.com, Vilas.Sridharan@amd.com, leo.duran@amd.com,
 Yazen.Ghannam@amd.com, rientjes@google.com, jiaqiyan@google.com,
 Jon.Grimm@amd.com, dave.hansen@linux.intel.com, naoya.horiguchi@nec.com,
 james.morse@arm.com, jthoughton@google.com, somasundaram.a@hpe.com,
 erdemaktas@google.com, pgonda@google.com, duenwen@google.com,
 gthelen@google.com, wschwartz@amperecomputing.com,
 dferguson@amperecomputing.com, wbs@os.amperecomputing.com,
 nifan.cxl@gmail.com, tanxiaofei@huawei.com, prime.zeng@hisilicon.com,
 roberto.sassu@huawei.com, kangkang.shen@futurewei.com,
 wanghuiqiang@huawei.com, linuxarm@huawei.com
References: <20250106121017.1620-1-shiju.jose@huawei.com>
 <20250106121017.1620-6-shiju.jose@huawei.com>
Content-Language: en-US
From: Daniel Ferguson <danielf@os.amperecomputing.com>
In-Reply-To: <20250106121017.1620-6-shiju.jose@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0143.namprd03.prod.outlook.com
 (2603:10b6:303:8c::28) To SA3PR01MB8473.prod.exchangelabs.com
 (2603:10b6:806:397::12)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR01MB8473:EE_|CH2PR01MB9134:EE_
X-MS-Office365-Filtering-Correlation-Id: aa60e0da-bcc2-47d0-e09f-08dd3a6f809c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z1dtV3BOU3RxdVhZRkZMOW15djZmUzNmKzdTQmlRQ05HRVFUYnRET3NMSG9q?=
 =?utf-8?B?a2VPbTV4dU9rUlBYS2JLbitFRjZFM1R3T1JtWjcxamZBSU5KS0R2SHBZclBa?=
 =?utf-8?B?NEIvRC93MnE0dDVYU293TDk5REdSVnZFdEZvdWhRTVZqWVJwK2pSK09EVXNO?=
 =?utf-8?B?NnRUejN5cG52azhqVExHWlZVQmJJZ3NaK1RIKzUwSkFnRDZGWjkvbFB0MEFK?=
 =?utf-8?B?K2VsQ3VDVzFKeXM5aWFvOHl0MHRXWGNkditIUzlCY2Q4M2FiT2NGN2JqZExh?=
 =?utf-8?B?ZXRrY0Vncy9MaEpjUzRCdjQwcFhlZ2N0YWdvZFVOZGl1aERjazNYdXhnOXRE?=
 =?utf-8?B?VUxLbGdkOVpkMW05WkJ0ajB4eVF2bGZaV3h4c3JNU25xN2Y2NVRlUDlEYUdZ?=
 =?utf-8?B?ZE95ajFOQy84b2VSRVhpbXhwYjVucDZoM1Z1U3RwaUJxd3IrdzFZMi9SSGJx?=
 =?utf-8?B?TGNmWUp2TDkrWkpiWE5LZmpsSzJKcjhmZzYzWGc4b2R0NzJrZTE0NEJydkJx?=
 =?utf-8?B?dVN6SGlHc1NpRXpkbWFCMmhBcFpIUEd2NFRTUGc2UjR3SGh2MHpzbTdIOWpx?=
 =?utf-8?B?cWZUNHlZRElpY0JiYVNOT2FxS0M0b1FTSzg3Vkswd1VhamwrZTFGQ0RmZHdQ?=
 =?utf-8?B?dVg5bjNlaHJBWGpta2thNnM3R29vbm1peC8zSHRBaWtoRHVqZVhQYlowRzBx?=
 =?utf-8?B?WXp3bHdRWUZqak90TWpKUjl0dit3VTBKWWxmNmZmQUtUMHMrVGJXNDFZMWtL?=
 =?utf-8?B?NVhRejFFS3ExaUs3QWc0czlZQnNGeldnYTVSNjJDTlA4c3pKdTdnWHZlNXNn?=
 =?utf-8?B?dGk4ZytWNU5VMWlWSUFLK3hvQ3lsZWoxd1hTcVlYK0tVTDVldHlndlBIUGtH?=
 =?utf-8?B?T2hUc2V1UFY4Y3FFcWI4MlhUSnhYUWJ1am5NWGNFV1NTNFRvZHV5RDIzYjlQ?=
 =?utf-8?B?L3A1WmJPd0JUcStxNHFVa01BM2kvMW5SakdhdGpIMEp6WGNYaUVMNjBsNURi?=
 =?utf-8?B?RDBDbVpyQ0tlNHhDZ3lUVGRKdDV2aTVUeEI0THJwK1hFbUxJMFZRUlYyMHVr?=
 =?utf-8?B?enFSMUlSRkMrM2tjVzUrWC9NK3dwaEVNczB0WDBhSERwdjB6WFRua2ZmTEdV?=
 =?utf-8?B?VDJjUWh5ZDBKM0VJUERWcEQxbFBoUThpRHB1cHRNQ1hSUFd1RnMrS21CN3pW?=
 =?utf-8?B?bXdLaXhYd1N6RXBEQTZ6ODdHclR2aFAvUHFEdEdHc0t5R1g4c21EWVIxOU1x?=
 =?utf-8?B?U0JkQzdydmlZMXZpblp0YkFiUjFoTzJzL3Yvb3h2dkZ1ekhOSGJrclh0NDhj?=
 =?utf-8?B?Z0FJUy9tb3dKYWlsY2lHY2d5c0pvbml1Y2RFOGswKzU4S1NqNzU5NzBmZ1ZB?=
 =?utf-8?B?MHhpWkZ1RU5pWlg2N2xjSHVUekxRT2EyUjZibk9jYldRemtUeHJRSHpraHps?=
 =?utf-8?B?Z2lRekFoNDViczcxVEQ0ak1MVWpSWWhoZkRmTGxoTStJamsyY1E3YzBMTW9l?=
 =?utf-8?B?U2sxdkhqaUN1YldRUkNpc0UrWHlHVUc3ZjB3VWV3SzA2U1ovRGxnSTRrcUNW?=
 =?utf-8?B?L3JpbVI3Ym1vRzZZZGdzaDUzMnoyRGlkY2l6cUN3SGxBOG1PQ25SbkVVU3lF?=
 =?utf-8?B?allzVC8zVE9vazRYYkpjd3NBcVlvMUNUUkl3bmUwTnY4b3RtQ1pHVFJnR2N2?=
 =?utf-8?B?T2g1dEt3OHVGMysvNCt2djJnOUpFUllhVGdtY01CSTVHcEY2QmZ5MW5UdlBu?=
 =?utf-8?B?dmY0VlMwdFpOQVpLOU1HRFp2MEY3TTNZZVZSbFJEaC9Yb3grcy9mNmxFNC9O?=
 =?utf-8?B?aWxoL3l4Z1daUzNQTVFQVnVwcnBhaVB2YjhLc094K2M0blR0RmR3dTdRU2JB?=
 =?utf-8?B?TnU3ZEJRYnBBMFZOT2dyWnlHbndpRUdKOFhVampGTXp5c0NvUXZ1R0JMTzI0?=
 =?utf-8?Q?6UVsyTbkQSkSnTjQVVJs079I/DO0V99v?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR01MB8473.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDFGMk9JWDBrbkpUVlQycFB5aXdoNmRsQ0dTRGJXTTFYZTFZSk5pcm1Yd3da?=
 =?utf-8?B?UU1BR20rK3FOUHExZW5JT0dqY24yUTg2cVltK0ZOYkZZYm5iWVVHZWdadUU1?=
 =?utf-8?B?SCt5Yk0ySmhtZGt4azVQZEhaaHBIMnB3NUdIdVQ4bG1qb1MrOWQyK0lLMnA0?=
 =?utf-8?B?NEpjR1dTQzQ4aTFqODYwRy92dFA3aXZrRk04T0pZUisxTHRSbER4T2dKc0lp?=
 =?utf-8?B?Q2Q4UEVMbld4YlVsT2wrMjBMMk5vYWxBSnAwd2cvVDBsMUhCeFp2c1E2Z0lE?=
 =?utf-8?B?KzhtdmljbWFXcU4rK0t3eitCYTNPTUs1clo2MXc1SlFoUkVCM0krYXZDakVP?=
 =?utf-8?B?WTJYbWNSbGNYRHVqV2duS1JGOENOSjRlQS9xR1RiM0pXMW4rYlNZMjF0Q3gr?=
 =?utf-8?B?TFRONHFpdHJCMUtIVmpVUFYyVG5tb1lMZngrc1hVcHgxb0ZWaVhuMzNkV1RI?=
 =?utf-8?B?V3VObnZva0YwUHBRWE9UQUdJWkNQZnk4Zjh6THdLSnZxaURodC9CZERlOHZw?=
 =?utf-8?B?TW9lWSt0RUc2RU53bFVhRzVkZWQwODlwbXFWbUZ5cnVuc1prWTZxQzR3V1k0?=
 =?utf-8?B?VmUyS1VGSzJkSDRGdmNUNXFFM0NNMEkvWURWN3lNVzZ1R0IwN0Q1WVZTS0VJ?=
 =?utf-8?B?RDZ0ZlEycm9ya2FidVI2VGxPdEJId2FtTWFnTW5RM2wxZ3NheHJ6c3dpVDg5?=
 =?utf-8?B?TG51eG1IaFRlZzNpZVZETWlZd0poMVMyQWR0TkFUUmFTdXZBQlBKbVA0QUUz?=
 =?utf-8?B?T1JVQThoWm50bG5URDY5cldxUmdtZU5DNDY3QUIzTFBETWlvam5uOHFJNzY4?=
 =?utf-8?B?SUNrMnhyRUUvT2ZJR050S2M4cldQZlNtM2MzSEhqK0pZZ1VJa3E5UlY3WjUx?=
 =?utf-8?B?ZXhvWDRKWEJMaGlGWjVsRlJvTnpVeHRnNk5SaWR0VWdVaU5UVm5BMnVCaXRP?=
 =?utf-8?B?S0k2dmw3TXE3S0t5dXlZL1RyQnNYd2VNMVNnc2EzY25mbGpocVl2dzNCRVV6?=
 =?utf-8?B?dWlVRnNuK0FTZVR5NFVHVVE0dVJBd1NXeHVpQVpsYm5lbHFCRjVtSG9IT0Vz?=
 =?utf-8?B?MWZxNHdyRjFEcFJjaThBWm8rejR1R01ocnhjd2xkN1hjeUlOSDBhcHhDeVUv?=
 =?utf-8?B?UEZPMW5nanBIbklZWjZOalhnYWNQV1VFZHczZkxXZGNwK0lRSTFLUzVnVmgy?=
 =?utf-8?B?dlRqMzFrbERXcFA4TDhqdGdkelRBRG1wL0owdUFaRHREVXpPenlQMFVNRUhs?=
 =?utf-8?B?K2ZGNTR1K3pvSjBaVnJ5bzMzem9ORk16T2NGcW9NMm1oSE5OSUNDeHRUVjA2?=
 =?utf-8?B?VzA2TGh2RGJFSjc1QVYydzhOdUk5V0N2czlNOGl0eFNaM3k1OHV4eTEvOGlR?=
 =?utf-8?B?bU9mRmdYNTcvcStpRlBLOHd3dkZuNEVVV0dCTTl3NjU5WWg3VUZrNUhLdGRu?=
 =?utf-8?B?RkRiM1N0S2kvODRLZTBkMm9yQlV6N29zYUJTR0N4YjVWdVp5UWFuejA2Wm0w?=
 =?utf-8?B?K1k0eEp5dysyMEYwK1orcTAxMkREc2NjU0pJMHRlcFd4SkVuMU1Bek5lRUcw?=
 =?utf-8?B?UXd5ZitKR1RpS0NHaXdHU0hpakRUbU9ORHg5ZW9HT0J0dEx0Z1BNWjBVdm82?=
 =?utf-8?B?UFd4UWQ1SnZudEJMVGxQZWM0M0tVaHlGZWlzRmQvT2UvcVdQUjRieHo0RWtj?=
 =?utf-8?B?NTI1NHhnVW93bzlGZENCd3RBZXNkNk5VRjZET0FUOWhWamdhMXdaOGE1K1Zq?=
 =?utf-8?B?TjNrQXNmQWNndFdOMVpIaUR0aXl6ekUrRllaemplSDh3b0JtcWd3NUd5QTBD?=
 =?utf-8?B?dmdFbTZjYnlQYTdvOWtEaXloTU1BQUFoVm5EL29XcFZqNkJwSUtzeTJ5NVpl?=
 =?utf-8?B?ZjhTdW52SzlySU03MGFOQ2JSY1Z1RWVNeG02K3lCYzRXZVo5aG9aWUdlbTJX?=
 =?utf-8?B?QndYS1NncjlWMjJRMVp5Wkg4VnN5cG5ONC9STklKMC9peWJwWnN1NG1xbS9Z?=
 =?utf-8?B?L2FIeUZwaVU1NHBmRklWT2FkOG93STdrVEdJQUx3WVdmNTJuTXBDZ1FqZzBt?=
 =?utf-8?B?d01kRHlYaVBDeGhJV1MxY3pBUHZjellwWUF3dlM0bzMzU3pUaVZacHRONE8x?=
 =?utf-8?B?bVc1TnpFeE5oZEdyMHcwalRuL215UTFvWDdKS1BEWk5NVERscVEvbHhBU29K?=
 =?utf-8?Q?gB69W92xoKIIBZBlqnjDTTM=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa60e0da-bcc2-47d0-e09f-08dd3a6f809c
X-MS-Exchange-CrossTenant-AuthSource: SA3PR01MB8473.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 23:01:13.1843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2bylRyjVClVV+9ecK8Rh5T7nb3s39neYJoHO8fxAEzQPY68NNblC10pCPqaRLjQTh7hOUrKv6DRbYjia2C9zpLvxVH5us9OmRg8SQ7nzhWgIJDjy8q2pEIoZY+rF/ZBZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR01MB9134



On 1/6/2025 4:10 AM, shiju.jose@huawei.com wrote:
> +static int ras2_report_cap_error(u32 cap_status)
> +{
> +	switch (cap_status) {
> +	case ACPI_RAS2_NOT_VALID:
> +	case ACPI_RAS2_NOT_SUPPORTED:
> +		return -EPERM;
> +	case ACPI_RAS2_BUSY:
> +		return -EBUSY;
> +	case ACPI_RAS2_FAILED:
> +	case ACPI_RAS2_ABORTED:
> +	case ACPI_RAS2_INVALID_DATA:
> +		return -EINVAL;
> +	default: /* 0 or other, Success */
> +		return 0;
> +	}
> +}
> +
> +static int ras2_check_pcc_chan(struct ras2_pcc_subspace *pcc_subspace)
> +{
> +	struct acpi_ras2_shared_memory __iomem *generic_comm_base = pcc_subspace->pcc_comm_addr;
> +	ktime_t next_deadline = ktime_add(ktime_get(), pcc_subspace->deadline);
> +	u32 cap_status;
> +	u16 status;
> +	u32 ret;
> +
> +	while (!ktime_after(ktime_get(), next_deadline)) {
> +		/*
> +		 * As per ACPI spec, the PCC space will be initialized by
> +		 * platform and should have set the command completion bit when
> +		 * PCC can be used by OSPM
> +		 */
> +		status = readw_relaxed(&generic_comm_base->status);
> +		if (status & RAS2_PCC_CMD_ERROR) {
> +			cap_status = readw_relaxed(&generic_comm_base->set_capabilities_status);
> +			ret = ras2_report_cap_error(cap_status);

There is some new information:

The Scrub parameter block intends to get its own Status field, and the
set_capabilities_status field is being deprecated. This also causes a
revision bump in the spec.

See [1]

Assuming this change is ratified (not guaranteed, still pending):
This change implies that we cannot centrally decode errors, as is done
here and now. Instead error decoding must be done after some
feature-specific routine calls ras2_send_pcc_cmd. It should be the case
that each new feature, moving forward, will likely have their own status.

Please see my follow up comment on [PATCH v18 06/19]

---
[1] https://github.com/tianocore/edk2/issues/10540
---

> +
> +			status &= ~RAS2_PCC_CMD_ERROR;
> +			writew_relaxed(status, &generic_comm_base->status);
> +			return ret;
> +		}
> +		if (status & RAS2_PCC_CMD_COMPLETE)
> +			return 0;
> +		/*
> +		 * Reducing the bus traffic in case this loop takes longer than
> +		 * a few retries.
> +		 */
> +		msleep(10);
> +	}
> +
> +	return -EIO;
> +}
> +
> +/**
> + * ras2_send_pcc_cmd() - Send RAS2 command via PCC channel
> + * @ras2_ctx:	pointer to the RAS2 context structure
> + * @cmd:	command to send
> + *
> + * Returns: 0 on success, an error otherwise
> + */
> +int ras2_send_pcc_cmd(struct ras2_mem_ctx *ras2_ctx, u16 cmd)
> +{
> +	struct ras2_pcc_subspace *pcc_subspace = ras2_ctx->pcc_subspace;
> +	struct acpi_ras2_shared_memory *generic_comm_base = pcc_subspace->pcc_comm_addr;
> +	static ktime_t last_cmd_cmpl_time, last_mpar_reset;
> +	struct mbox_chan *pcc_channel;
> +	unsigned int time_delta;
> +	static int mpar_count;
> +	int ret;
> +
> +	guard(mutex)(&ras2_pcc_subspace_lock);
> +	ret = ras2_check_pcc_chan(pcc_subspace);
> +	if (ret < 0)
> +		return ret;
> +	pcc_channel = pcc_subspace->pcc_chan->mchan;
> +
> +	/*
> +	 * Handle the Minimum Request Turnaround Time(MRTT)
> +	 * "The minimum amount of time that OSPM must wait after the completion
> +	 * of a command before issuing the next command, in microseconds"
> +	 */
> +	if (pcc_subspace->pcc_mrtt) {
> +		time_delta = ktime_us_delta(ktime_get(), last_cmd_cmpl_time);
> +		if (pcc_subspace->pcc_mrtt > time_delta)
> +			udelay(pcc_subspace->pcc_mrtt - time_delta);
> +	}
> +
> +	/*
> +	 * Handle the non-zero Maximum Periodic Access Rate(MPAR)
> +	 * "The maximum number of periodic requests that the subspace channel can
> +	 * support, reported in commands per minute. 0 indicates no limitation."
> +	 *
> +	 * This parameter should be ideally zero or large enough so that it can
> +	 * handle maximum number of requests that all the cores in the system can
> +	 * collectively generate. If it is not, we will follow the spec and just
> +	 * not send the request to the platform after hitting the MPAR limit in
> +	 * any 60s window
> +	 */
> +	if (pcc_subspace->pcc_mpar) {
> +		if (mpar_count == 0) {
> +			time_delta = ktime_ms_delta(ktime_get(), last_mpar_reset);
> +			if (time_delta < 60 * MSEC_PER_SEC) {
> +				dev_dbg(ras2_ctx->dev,
> +					"PCC cmd not sent due to MPAR limit");
> +				return -EIO;
> +			}
> +			last_mpar_reset = ktime_get();
> +			mpar_count = pcc_subspace->pcc_mpar;
> +		}
> +		mpar_count--;
> +	}
> +
> +	/* Write to the shared comm region. */
> +	writew_relaxed(cmd, &generic_comm_base->command);
> +
> +	/* Flip CMD COMPLETE bit */
> +	writew_relaxed(0, &generic_comm_base->status);
> +
> +	/* Ring doorbell */
> +	ret = mbox_send_message(pcc_channel, &cmd);
> +	if (ret < 0) {
> +		dev_err(ras2_ctx->dev,
> +			"Err sending PCC mbox message. cmd:%d, ret:%d\n",
> +			cmd, ret);
> +		return ret;
> +	}
> +
> +	/*
> +	 * If Minimum Request Turnaround Time is non-zero, we need
> +	 * to record the completion time of both READ and WRITE
> +	 * command for proper handling of MRTT, so we need to check
> +	 * for pcc_mrtt in addition to CMD_READ
> +	 */
> +	if (cmd == RAS2_PCC_CMD_EXEC || pcc_subspace->pcc_mrtt) {
> +		ret = ras2_check_pcc_chan(pcc_subspace);
> +		if (pcc_subspace->pcc_mrtt)
> +			last_cmd_cmpl_time = ktime_get();
> +	}
> +
> +	if (pcc_channel->mbox->txdone_irq)
> +		mbox_chan_txdone(pcc_channel, ret);
> +	else
> +		mbox_client_txdone(pcc_channel, ret);
> +
> +	return ret >= 0 ? 0 : ret;
> +}
> +EXPORT_SYMBOL_GPL(ras2_send_pcc_cmd);
> +
> +static int ras2_register_pcc_channel(struct ras2_mem_ctx *ras2_ctx, int pcc_subspace_id)
> +{
> +	struct ras2_pcc_subspace *pcc_subspace;
> +	struct pcc_mbox_chan *pcc_chan;
> +	struct mbox_client *mbox_cl;
> +
> +	if (pcc_subspace_id < 0)
> +		return -EINVAL;
> +
> +	mutex_lock(&ras2_pcc_subspace_lock);
> +	list_for_each_entry(pcc_subspace, &ras2_pcc_subspaces, elem) {
> +		if (pcc_subspace->pcc_subspace_id == pcc_subspace_id) {
> +			ras2_ctx->pcc_subspace = pcc_subspace;
> +			pcc_subspace->ref_count++;
> +			mutex_unlock(&ras2_pcc_subspace_lock);
> +			return 0;
> +		}
> +	}
> +	mutex_unlock(&ras2_pcc_subspace_lock);
> +
> +	pcc_subspace = kcalloc(1, sizeof(*pcc_subspace), GFP_KERNEL);
> +	if (!pcc_subspace)
> +		return -ENOMEM;
> +	mbox_cl = &pcc_subspace->mbox_client;
> +	mbox_cl->knows_txdone = true;
> +
> +	pcc_chan = pcc_mbox_request_channel(mbox_cl, pcc_subspace_id);
> +	if (IS_ERR(pcc_chan)) {
> +		kfree(pcc_subspace);
> +		return PTR_ERR(pcc_chan);
> +	}
> +	*pcc_subspace = (struct ras2_pcc_subspace) {
> +		.pcc_subspace_id = pcc_subspace_id,
> +		.pcc_chan = pcc_chan,
> +		.pcc_comm_addr = acpi_os_ioremap(pcc_chan->shmem_base_addr,
> +						 pcc_chan->shmem_size),
> +		.deadline = ns_to_ktime(RAS2_NUM_RETRIES *
> +					pcc_chan->latency *
> +					NSEC_PER_USEC),
> +		.pcc_mrtt = pcc_chan->min_turnaround_time,
> +		.pcc_mpar = pcc_chan->max_access_rate,
> +		.mbox_client = {
> +			.knows_txdone = true,
> +		},
> +		.pcc_channel_acquired = true,
> +	};
> +	mutex_lock(&ras2_pcc_subspace_lock);
> +	list_add(&pcc_subspace->elem, &ras2_pcc_subspaces);
> +	pcc_subspace->ref_count++;
> +	mutex_unlock(&ras2_pcc_subspace_lock);
> +	ras2_ctx->pcc_subspace = pcc_subspace;
> +	ras2_ctx->pcc_comm_addr = pcc_subspace->pcc_comm_addr;
> +	ras2_ctx->dev = pcc_chan->mchan->mbox->dev;
> +
> +	return 0;
> +}
> +
> +static DEFINE_IDA(ras2_ida);
> +static void ras2_remove_pcc(struct ras2_mem_ctx *ras2_ctx)
> +{
> +	struct ras2_pcc_subspace *pcc_subspace = ras2_ctx->pcc_subspace;
> +
> +	guard(mutex)(&ras2_pcc_subspace_lock);
> +	if (pcc_subspace->ref_count > 0)
> +		pcc_subspace->ref_count--;
> +	if (!pcc_subspace->ref_count) {
> +		list_del(&pcc_subspace->elem);
> +		pcc_mbox_free_channel(pcc_subspace->pcc_chan);
> +		kfree(pcc_subspace);
> +	}
> +}
> +
> +static void ras2_release(struct device *device)
> +{
> +	struct auxiliary_device *auxdev = container_of(device, struct auxiliary_device, dev);
> +	struct ras2_mem_ctx *ras2_ctx = container_of(auxdev, struct ras2_mem_ctx, adev);
> +
> +	ida_free(&ras2_ida, auxdev->id);
> +	ras2_remove_pcc(ras2_ctx);
> +	kfree(ras2_ctx);
> +}
> +
> +static struct ras2_mem_ctx *ras2_add_aux_device(char *name, int channel)
> +{
> +	struct ras2_mem_ctx *ras2_ctx;
> +	int id, ret;
> +
> +	ras2_ctx = kzalloc(sizeof(*ras2_ctx), GFP_KERNEL);
> +	if (!ras2_ctx)
> +		return ERR_PTR(-ENOMEM);
> +
> +	mutex_init(&ras2_ctx->lock);
> +
> +	ret = ras2_register_pcc_channel(ras2_ctx, channel);
> +	if (ret < 0) {
> +		pr_debug("failed to register pcc channel ret=%d\n", ret);
> +		goto ctx_free;
> +	}
> +
> +	id = ida_alloc(&ras2_ida, GFP_KERNEL);
> +	if (id < 0) {
> +		ret = id;
> +		goto pcc_free;
> +	}
> +	ras2_ctx->id = id;
> +	ras2_ctx->adev.id = id;
> +	ras2_ctx->adev.name = RAS2_MEM_DEV_ID_NAME;
> +	ras2_ctx->adev.dev.release = ras2_release;
> +	ras2_ctx->adev.dev.parent = ras2_ctx->dev;
> +
> +	ret = auxiliary_device_init(&ras2_ctx->adev);
> +	if (ret)
> +		goto ida_free;
> +
> +	ret = auxiliary_device_add(&ras2_ctx->adev);
> +	if (ret) {
> +		auxiliary_device_uninit(&ras2_ctx->adev);
> +		return ERR_PTR(ret);
> +	}
> +
> +	return ras2_ctx;
> +
> +ida_free:
> +	ida_free(&ras2_ida, id);
> +pcc_free:
> +	ras2_remove_pcc(ras2_ctx);
> +ctx_free:
> +	kfree(ras2_ctx);
> +	return ERR_PTR(ret);
> +}
> +
> +static int __init ras2_acpi_init(void)
> +{
> +	struct acpi_table_header *pAcpiTable = NULL;
> +	struct acpi_ras2_pcc_desc *pcc_desc_list;
> +	struct acpi_table_ras2 *pRas2Table;
> +	struct ras2_mem_ctx *ras2_ctx;
> +	int pcc_subspace_id;
> +	acpi_size ras2_size;
> +	acpi_status status;
> +	u8 count = 0, i;
> +	int ret = 0;
> +
> +	status = acpi_get_table("RAS2", 0, &pAcpiTable);
> +	if (ACPI_FAILURE(status) || !pAcpiTable) {
> +		pr_err("ACPI RAS2 driver failed to initialize, get table failed\n");
> +		return -EINVAL;
> +	}
> +
> +	ras2_size = pAcpiTable->length;
> +	if (ras2_size < sizeof(struct acpi_table_ras2)) {
> +		pr_err("ACPI RAS2 table present but broken (too short #1)\n");
> +		ret = -EINVAL;
> +		goto free_ras2_table;
> +	}
> +
> +	pRas2Table = (struct acpi_table_ras2 *)pAcpiTable;
> +	if (pRas2Table->num_pcc_descs <= 0) {
> +		pr_err("ACPI RAS2 table does not contain PCC descriptors\n");
> +		ret = -EINVAL;
> +		goto free_ras2_table;
> +	}
> +
> +	pcc_desc_list = (struct acpi_ras2_pcc_desc *)(pRas2Table + 1);
> +	/* Double scan for the case of only one actual controller */
> +	pcc_subspace_id = -1;
> +	count = 0;
> +	for (i = 0; i < pRas2Table->num_pcc_descs; i++, pcc_desc_list++) {
> +		if (pcc_desc_list->feature_type != RAS2_FEATURE_TYPE_MEMORY)
> +			continue;
> +		if (pcc_subspace_id == -1) {
> +			pcc_subspace_id = pcc_desc_list->channel_id;
> +			count++;
> +		}
> +		if (pcc_desc_list->channel_id != pcc_subspace_id)
> +			count++;
> +	}
> +	/*
> +	 * Workaround for the client platform with multiple scrub devices
> +	 * but uses single PCC subspace for communication.
> +	 */
> +	if (count == 1) {
> +		/* Add auxiliary device and bind ACPI RAS2 memory driver */
> +		ras2_ctx = ras2_add_aux_device(RAS2_MEM_DEV_ID_NAME, pcc_subspace_id);
> +		if (IS_ERR(ras2_ctx)) {
> +			ret = PTR_ERR(ras2_ctx);
> +			goto free_ras2_table;
> +		}
> +		acpi_put_table(pAcpiTable);
> +		return 0;
> +	}
> +
> +	pcc_desc_list = (struct acpi_ras2_pcc_desc *)(pRas2Table + 1);
> +	count = 0;
> +	for (i = 0; i < pRas2Table->num_pcc_descs; i++, pcc_desc_list++) {
> +		if (pcc_desc_list->feature_type != RAS2_FEATURE_TYPE_MEMORY)
> +			continue;
> +		pcc_subspace_id = pcc_desc_list->channel_id;
> +		/* Add auxiliary device and bind ACPI RAS2 memory driver */
> +		ras2_ctx = ras2_add_aux_device(RAS2_MEM_DEV_ID_NAME, pcc_subspace_id);
> +		if (IS_ERR(ras2_ctx)) {
> +			ret = PTR_ERR(ras2_ctx);
> +			goto free_ras2_table;
> +		}
> +	}
> +
> +free_ras2_table:
> +	acpi_put_table(pAcpiTable);
> +	return ret;
> +}
> +late_initcall(ras2_acpi_init)
> diff --git a/include/acpi/ras2_acpi.h b/include/acpi/ras2_acpi.h
> new file mode 100644
> index 000000000000..7b32407ae2af
> --- /dev/null
> +++ b/include/acpi/ras2_acpi.h
> @@ -0,0 +1,45 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * RAS2 ACPI driver header file
> + *
> + * (C) Copyright 2014, 2015 Hewlett-Packard Enterprises
> + *
> + * Copyright (c) 2024 HiSilicon Limited
> + */
> +
> +#ifndef _RAS2_ACPI_H
> +#define _RAS2_ACPI_H
> +
> +#include <linux/acpi.h>
> +#include <linux/auxiliary_bus.h>
> +#include <linux/mailbox_client.h>
> +#include <linux/mutex.h>
> +#include <linux/types.h>
> +
> +#define RAS2_PCC_CMD_COMPLETE	BIT(0)
> +#define RAS2_PCC_CMD_ERROR	BIT(2)
> +
> +/* RAS2 specific PCC commands */
> +#define RAS2_PCC_CMD_EXEC 0x01
> +
> +#define RAS2_AUX_DEV_NAME "ras2"
> +#define RAS2_MEM_DEV_ID_NAME "acpi_ras2_mem"
> +
> +/* Data structure RAS2 table */
> +struct ras2_mem_ctx {
> +	struct auxiliary_device adev;
> +	/* Lock to provide mutually exclusive access to PCC channel */
> +	struct mutex lock;
> +	int id;
> +	u8 instance;
> +	bool bg;
> +	u64 base, size;
> +	u8 scrub_cycle_hrs, min_scrub_cycle, max_scrub_cycle;
> +	struct device *dev;
> +	struct device *scrub_dev;
> +	void *pcc_subspace;
> +	struct acpi_ras2_shared_memory __iomem *pcc_comm_addr;
> +};


Could we break the ras2_mem_ctx structure up a little bit so that when
we add a new feature, it will be easier to add a new context?

In the following example, we show what it *might* look like if we add
another feature (Address Translation). But the ask here, is to split the
ras2_mem_ctx structure into two structures: ras2_mem_scrub_ctx  and
ras2_mem_ctx.

struct ras2_mem_address_translation_ctx {
	struct device *at_dev;
	...
};

struct ras2_mem_scrub_ctx {
	struct device *scrub_dev;
	bool bg;
	u64 base, size;
	u8 scrub_cycle_hrs, min_scrub_cycle, max_scrub_cycle;
};


/* Data structure RAS2 table */
struct ras2_mem_ctx {
	struct auxiliary_device adev;
	/* Lock to provide mutually exclusive access to PCC channel */
	struct mutex lock;
	int id;
	u8 instance;
	struct device *dev;
	void *pcc_subspace;
	struct acpi_ras2_shared_memory __iomem *pcc_comm_addr;

	struct ras2_mem_scrub_ctx scrub;
	struct ras2_mem_address_translation_ctx at;
};


