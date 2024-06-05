Return-Path: <linux-edac+bounces-1196-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BB68FD918
	for <lists+linux-edac@lfdr.de>; Wed,  5 Jun 2024 23:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4743C1C210CB
	for <lists+linux-edac@lfdr.de>; Wed,  5 Jun 2024 21:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5518A16D303;
	Wed,  5 Jun 2024 21:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="l87mZ7g2"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2090.outbound.protection.outlook.com [40.107.223.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1301667D8;
	Wed,  5 Jun 2024 21:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717623188; cv=fail; b=RWkbskB9xIaT/ANKpRo1hGGF9pN7wSseD/TxpwjQroROcZx9lc6YyjMgjsOezil/hbp9+wTXExzOA4CAUZpRHMZIu+yasBYSEUXIfGvcHUhdM+wHTtJ+XgCKdYtGG8CQha+TwAEtgicfAy14l6kpjphAlBXOAziYbyhac6li3HI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717623188; c=relaxed/simple;
	bh=T8V7PvlCh8SPErcaHSHLJ/Y/wRXqgLHr/l+syAqhlEg=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZXCfV1oXH+mFvIuT/16OnDvI0No9aRGw7t77Nl0XwF+H78OenEGBiAAf5zLLAdZ7SVcQhdfvTh1DShKE9DRiBON4CyJnc1uMW5ExjWC4uLBa8IE0UCXtUB/3j3tGIM7L3oZPGT+Hu8fNYD7lII9aMyoffIbU4oAN3XOXcmC9mBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=l87mZ7g2; arc=fail smtp.client-ip=40.107.223.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HNwFt8RVEKUX4XIfhuvuOye1fIzoHMKdlpFd1WESehbqz2fJ/hISi5fwOV4dxTcWA7q3InI5vm39G1mrodMANvKR/ugTETnz+O4MGsmuRGgodpTqMf2SAYEfEcgZCXozAHM5VvRM7V9dYtY4ExuNU/OQi7PetmGAWWlnXYyctMlI9HGXeDKVcgsmdbuXLd1glab494Hd6iaVoX+FpQqYIc6+7DYCBItwA3f0+4WCawkH0YX7hu0Y7yJ0cOoF9HmbQmmJIV1c+O2vAv2qR7rWiDVO5Zxmfw0hPkx0A1TBDBrAtiBHNfX1FXb+d94+Q+weZuZKLCFHAmyCpXsKNu5mhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JdVpxNo5LWawmLbsSeAfZhRkYDyrntsgTTS/HwrbKvU=;
 b=VYqzi3d1UFfCCXLeU+mqQd+5Hi/MUCDkAeDcoBcb9LTa26IjeLl+uhBMA+Qwc+R3aQ7lV1EqpLRBrWlJwVHk8TTDWwC3hGu3OuYUCW4khC64I9v5sXsLec1gOOZi512vMzjjGPOpysND//Pphc25J4kvN9+YwCVqN3XwjHhVIz7FWySSnYhi7arOtzeWkJFgJeq97DEDIrorohnEJ0lrrOvrOdk5ycnIGW4xsszDAq8aD7xfvhXYR2zov3ty3d1QjYXPm2WHmlZ/DkTpn7sOwL+/eXJSdX0ssXn9qUHKftrY07DUp/wjXnUfg3omUyqsuMPMRRa5R12h6uBBtFrouQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JdVpxNo5LWawmLbsSeAfZhRkYDyrntsgTTS/HwrbKvU=;
 b=l87mZ7g2tSiGr6P29t3W1m9rmV/slHuBKPP6EPEb6Y6tEus2YEDJ5PJCpwLfdAEns+KLRKYiy8CsUq+4AE63hrdPG/t0WfZ1uYx4un0x03rkc2e/3IpgiBivbugUuAGqdReg40eDS6s6UN/LgHwaw5GEkm4YvofAZdwLXlkstqc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CO1PR01MB7370.prod.exchangelabs.com (2603:10b6:303:159::16) by
 LV3PR01MB8462.prod.exchangelabs.com (2603:10b6:408:1a7::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.27; Wed, 5 Jun 2024 21:33:01 +0000
Received: from CO1PR01MB7370.prod.exchangelabs.com
 ([fe80::6e98:87d1:5562:ad73]) by CO1PR01MB7370.prod.exchangelabs.com
 ([fe80::6e98:87d1:5562:ad73%4]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 21:33:01 +0000
Message-ID: <fec6ba82-aef8-4ffe-a18b-20ac8e0a1a03@os.amperecomputing.com>
Date: Wed, 5 Jun 2024 14:32:55 -0700
User-Agent: Mozilla Thunderbird
From: Daniel Ferguson <danielf@os.amperecomputing.com>
Subject: Re: [RFC PATCH v8 08/10] ACPI:RAS2: Add ACPI RAS2 driver
To: shiju.jose@huawei.com
Cc: ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, dave.jiang@intel.com,
 jonathan.cameron@huawei.com, dave@stgolabs.net, dan.j.williams@intel.com,
 linux-mm@kvack.org, linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org,
 linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, david@redhat.com,
 Vilas.Sridharan@amd.com, leo.duran@amd.com, Yazen.Ghannam@amd.com,
 rientjes@google.com, jiaqiyan@google.com, tony.luck@intel.com,
 Jon.Grimm@amd.com, dave.hansen@linux.intel.com, rafael@kernel.org,
 lenb@kernel.org, naoya.horiguchi@nec.com, james.morse@arm.com,
 jthoughton@google.com, somasundaram.a@hpe.com, erdemaktas@google.com,
 pgonda@google.com, duenwen@google.com, mike.malvestuto@intel.com,
 gthelen@google.com, wschwartz@amperecomputing.com,
 dferguson@amperecomputing.com, wbs@os.amperecomputing.com,
 nifan.cxl@gmail.com, tanxiaofei@huawei.com, prime.zeng@hisilicon.com,
 kangkang.shen@futurewei.com, wanghuiqiang@huawei.com, linuxarm@huawei.com
References: <20240419164720.1765-1-shiju.jose@huawei.com>
 <20240419164720.1765-9-shiju.jose@huawei.com>
Content-Language: en-US
In-Reply-To: <20240419164720.1765-9-shiju.jose@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:303:8f::18) To CO1PR01MB7370.prod.exchangelabs.com
 (2603:10b6:303:159::16)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR01MB7370:EE_|LV3PR01MB8462:EE_
X-MS-Office365-Filtering-Correlation-Id: 60a3abb0-2605-4905-1787-08dc85a71390
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|52116005|1800799015|7416005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SVdvQ1pjbHVCMEdnaUNzVW4yTnFKaDYzSG5oQzZpbmRuWmJhL2ZQLytWampE?=
 =?utf-8?B?Z3REZWMydHFnMHlvMVpuYzVVeG5kSlc5WitEUHdaMUZKV3NjTjFSeEpGUXc4?=
 =?utf-8?B?eDZqYzlnQzA1aXF1VXFmUXFEVWlRVjQ0dG1jMXdCK3BWMFIxVEJrV0NxVW45?=
 =?utf-8?B?YWZYV1BwcXpIbkljOUNmbVhoTnpuOGNXRWNrZ3dpQlhXM2dyeDU2bUVqWDdl?=
 =?utf-8?B?ak90em5BV2VtM2hJQ3J1b0VuaUFVdzQ2ZTBUMkZzUGh0a054STd5VmtIWkxS?=
 =?utf-8?B?LzU4OUJRUDJ1ZStlV0k2aWNtcUhyaEx0ZERHb29Nd0NEcnY5cjZKMTJGMUpV?=
 =?utf-8?B?emJyRXowYmRCYzBQdEw5N29Fa25RandvSXFzajNoVVZoN1ppT0wxcy8rRUtT?=
 =?utf-8?B?ZTI5L2dVTGFLS1dPMTJpdy9qdURaVVNUaXhxTHJDbE85eG83MHNyQTNDaWNr?=
 =?utf-8?B?TkVWNU8rRkhRczR4TTkySllMRXNtcXdIczN5T04wNzRqQW15Nm53cVh6RG5P?=
 =?utf-8?B?N2w0WlJ4aCtTYXoxMVJIREdzdmt3blg3Vy9ScGxpOEF4MWtoMlo5UHV3cWxL?=
 =?utf-8?B?L0d4KzlnN0dlRlRqSDNjYWg5WjRxOW5HWXp4dGxTMXg0STJTV0hwTmRGQytu?=
 =?utf-8?B?L0NBQTZvQmFiaXU3TmNJMTVOcVV4Sm4xN2ltRWpjbkduaEtiMWZockRlVmY0?=
 =?utf-8?B?YnRvcDhmeUFqQUhpYTBzZEcvcmdTTzk3anQrVmNaOXdtWmFGUzNRZEkwQldN?=
 =?utf-8?B?Ti92WFVBMk1CTitPRkFvQnhaZ28yR0Z2YU1SeE9YaVR2U3Q0Ync2VFU4dHpX?=
 =?utf-8?B?bTN4RkQ5MVVmTkdMUmp0d2xhMTNWRmN0OGhjM1I0b3ZVdGpCOW1hN1NVeGdh?=
 =?utf-8?B?MXh2RXVXWW1XMFZqL1owblFEQTF5OFpRSWtNUlBWRTgvNjd2N2U5K1l1SFBT?=
 =?utf-8?B?Q2pEbytRUHhwRkZyaFVEMEF0V2Z2enFVRWdrRWNpcHBSSDZseFJ6MjRsWHdL?=
 =?utf-8?B?MTdkeU9sa2lmRjdZMFJ0V25NNFk2Y2Qza2dWd0NaMTViVi9WeTgvUHRxVi9E?=
 =?utf-8?B?aDNYRnlLV3E3UDRuR0E0R3VRNHZjT3hhWnY5QUM5UExxM1d3eWQ5Rml4Zkxh?=
 =?utf-8?B?cWVCak1tUmdvNUIwcTRRcm9Ea3JxM3QxdXVRY3FPeTRwSjZUR0krM1dSeEFZ?=
 =?utf-8?B?UzFiTTIzOFlBNHZJeHc3ZEtYeHE2T1JsaUNmUlJwZ3BvU0F5SGN4Z0dHOTFQ?=
 =?utf-8?B?bldDejBiZi8vL3hFMTB5dGdJOGo0MjRaTVI4N2hhNFEzL1RMa1hubUNOVEZC?=
 =?utf-8?B?d1UwZmJyQkpwdVB5eTlrd0M0WWMwblhFcmZPclI3UTBSSW9oZEV6d2x3cStM?=
 =?utf-8?B?YkFkN3E4Mk9sRjZ0M2M5WHVoVEFMR2U1M2Q3ZFNtYVlESTBkQm41b0FKWHow?=
 =?utf-8?B?b29YU0dFOC9leVd1QjlhZFdlOE1uWStxSWhpWXdMNGFvR2VsR2xmUVJiejZL?=
 =?utf-8?B?Rms1b2grbURXRVpuSVl2eWc2TSt2bkpPVUdkalNQaHp2VlpoUkEwTzZiN3BG?=
 =?utf-8?B?TEd5MkhaTVB3R1lRdGwyZEpCQ2Y1OW90ek9Id1FHbFVWY013VnB1c2o3WFdD?=
 =?utf-8?B?c0dDUXRxOVV3R0FjbzVSRnp1em00RktMeFZLTVN0cGdlZDRTR1FLenVQb0J3?=
 =?utf-8?B?ejNoSFBMSmRlZnEzNmFxNWtVK2Y5VjloOThBLys2U2FyeEsrYTBuRHlaRzM0?=
 =?utf-8?B?KzhEU0FzSFhNNG1KbUQ1REFDNWVUT0ttKzVPbjgyOC9GNkIrT09WVTkwL1pG?=
 =?utf-8?B?T2VnSmJsQ3FxdFBpSDY4Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR01MB7370.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(7416005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WEpMRXFBOSt6bnlHa0o5eTBhVnZkeU90a0VrUk4xRjhRTFdMR2NrTmJjeW1q?=
 =?utf-8?B?cm40N0VWZ3htWnRGUFNMOUt1anZXWjAwY3B2QmRzRmFJSER1QkJlRUpTMFdr?=
 =?utf-8?B?SmdBOEhHenJxQUxzSjNhVmlWRHJaeUR1Z1JPYTQzRmJWWlRBRWtWakFtM2ZJ?=
 =?utf-8?B?d0F0UmZ2MFZYVEdDZjFWTUppb0R0VURRTUZiU2lvMlRiTTltMEtrY3hqeXdu?=
 =?utf-8?B?Y2E4VUY4MXhtdjBXTE10WGxva1Zub0xvelBZcDZaOVV6ckZjZVZXU2lpVk1R?=
 =?utf-8?B?T3BuZmpYUFN6bE1nalVrcSs2WDhobGErakw3NnVBbXFVNThCRU1DODgzYnFO?=
 =?utf-8?B?Y2FFaUJvMm1IbkN1MTY3bGc3YUwxajVYRHdsSGF5YUJIbnlidGcxb1ZTOEY4?=
 =?utf-8?B?dHcrb3ZHK0wxTGtXWjVKbnFzVzIwZm43Tm93bHV6UHpXUDd1c1BtODZWbnp3?=
 =?utf-8?B?bVVkY0RDRW1QMG96TlFHNUtTeFJpTnBHTE84bVQyQjRDZUdVZndzcXRMaHpk?=
 =?utf-8?B?WW9BZ0N2UlY5anExT0FXZnluRHlzYmxFWW9vNXpXUEZOQS8xajZ3enp1dFht?=
 =?utf-8?B?K1YzMVN6WFYwM2pwckxIRnRlM2p6THBPK3NTZ0twNnU0UXFId3ovc1pVbmNm?=
 =?utf-8?B?S01lS0VOdW9XTG92UjRSb3QxKzJPL1BPdlRDN1NXRmVhdTFKTWRqWFhwWFBp?=
 =?utf-8?B?UjlBT3p2Y2ZNNm1SUENkL0RMNlRDaGdGQ3EzaGFxVTJlTkJ1WGtNRTQzOEV0?=
 =?utf-8?B?ckNrbFN5MHVadktZT2NrZFkzZlVGZ1h1Mk9KRTZQLzVBdjRpbFprVGJHQTdX?=
 =?utf-8?B?amd5Q0NFTHhsK3ZhTk9qYWZDekVoRkV1Mjk2YXRZUWE2cjFXZGpsRUhDbG5o?=
 =?utf-8?B?SXRaWkUrUXZYMnduVGtqejRlK0N4SzcvMlEyT0NSN3NPcmp1a2NqS2VrRnB2?=
 =?utf-8?B?OExTQWhJRkUrN2tUc0tlUmQ0SStUYmtDbHdqbUE5V01KUU05ODRqeEZ5Zk5i?=
 =?utf-8?B?YnAzYmZLQWlJc2xDVUFTVFk4ZHFYb2g5cGVpaWIxdGpYZ0xSN1N4OVZWOVFn?=
 =?utf-8?B?R05KVENrOWZZN3hQTUlyTVJvazBSVGcyRlQyTHhGTEF2UlN3U2M2V3Jtem00?=
 =?utf-8?B?ODdSUGVxK0M5VzgrRXlrR3d0ajJsVVJCZW94bWx2UElsalBmY3RmRllPTCt3?=
 =?utf-8?B?ZW4vUFZTVEQwcm9RRnNMSUF2S2x2Q0dxbEtZWlFNU0RDZERSQVdHdU5IdXd4?=
 =?utf-8?B?azhmVDlSaVZSdmNXVkFpNDI1ZFRGbDNZcUNUZGxhYlBlQ2pUaS9QdVE4U1pW?=
 =?utf-8?B?Y01iYUh0dnFodTE3TW8yMFpTTk10Y1RiOEY4RkM4RnBWdFBTekdCRzNuZi9z?=
 =?utf-8?B?L3VTTTBqQU9jdTFaMlVVdEo4azlLY1BvWjNCSEpJU2ZLS0R5dWlwd0xGY3Jx?=
 =?utf-8?B?YXMzdWV4M2laMUd5dFRTQ3c1aC90ZW9TZkVVQTNLT2dxeVZYNWlBQnpyVTFm?=
 =?utf-8?B?VW92bit2VWk5NUFoL0xhKzkva0JiYVBRQkhTaUp5MnJaUUQ2d3VGMzVybExh?=
 =?utf-8?B?U00xSXpoaEppWWd1bmM4bldEaDJXeTNzaFFHRzdQbW40eDJsejkvRTFUMzJ5?=
 =?utf-8?B?UmVpb2JFSTNzRVpWdkc2N1paSHdWbFJyNmkzUlFJeXVSWkwydVRuem42TDNm?=
 =?utf-8?B?WFBxb0o2YW8rbnEzMmY1YmxOWm1DUjVheCtHd3lRYVNxZUowTGhRajhHaWlk?=
 =?utf-8?B?TGRVeUhiUVoyNGtnU2NRRnplazd5bHVidE5WNFMvRVFvNXk5OGRDOEtkUXVi?=
 =?utf-8?B?R0xDZTBCazN4bitSa1VIeHdMczVHNllCV0p4dDVVcDJDSTBqbmtOa2xDZFJv?=
 =?utf-8?B?SXNGUk1VZXd2NUNXQkJQaUNNcDJHaHhXa3RmWXF6R0FYWVQxSTVVQVExdUl0?=
 =?utf-8?B?bGtNTkxORmdaQlpMU2xzM2xONTI0ajlJRlJaL2ttQWV6ZTdvNnozN282QVpt?=
 =?utf-8?B?T0cvdzFDZEd3RUVjMHFoc0V2NVVhTHZKTnZvakhJdjRYaW0zUnFjZzVwTVFE?=
 =?utf-8?B?OUJhMFhTZGpFb1VKZ1o5MjZSL05GZ2JoNFRoZzBydUdBbmU2OU84dHZ1L2U0?=
 =?utf-8?B?ak02aE0zdVJqdjBlV3V1UHdjNzhPT005U3pDVU9pNGV5ancxREw5OEJlbFds?=
 =?utf-8?Q?PeP2crEHQmXFDlDy2402tIg=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a3abb0-2605-4905-1787-08dc85a71390
X-MS-Exchange-CrossTenant-AuthSource: CO1PR01MB7370.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 21:33:01.6331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KuAsfeDpHsllQ/s4ueeeor3nWxoMwljsZ4Svx7co1fF3AEDhvh4SxVuRsxIuwiuYLPaxtVtoFg+QlcSEk1OrNmfbxg3mNTlCrfCq5t+zA/MzGY2qSpKaOIjfjs+NbiN6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR01MB8462

> +static int ras2_check_pcc_chan(struct ras2_pcc_subspace *pcc_subspace)
> +{
> +	struct acpi_ras2_shared_memory __iomem *generic_comm_base =pcc_subspace->pcc_comm_addr;
> +	ktime_t next_deadline = ktime_add(ktime_get(), pcc_subspace->deadline);
> +	u16 status;
> +
> +	while (!ktime_after(ktime_get(), next_deadline)) {
> +		/*
> +		 * As per ACPI spec, the PCC space will be initialized by
> +		 * platform and should have set the command completion bit when
> +		 * PCC can be used by OSPM
> +		 */
> +		status = readw_relaxed(&generic_comm_base->status);
> +		if (status & RAS2_PCC_CMD_ERROR)
> +			return -EIO;

We need to clear the error bit before reporting an error.
Maybe the error was transient, or specific to the last transaction.
So clearing it here, lets us try again later. Like This:
		if (status & RAS2_PCC_CMD_ERROR) {
			status &= ~RAS2_PCC_CMD_ERROR;
			writew_relaxed(status, &generic_comm_base->status);
			return -EIO;
		}


Also, we are thinking that using the "Set RAS Capability Status" as a
way to communicate RAS2 Scrub specific error conditions is appropriate.
If we agree on that idea, then we can additionally check the
set_capabilities_status and return an appropriate error..
for example, we can add a new error mapping function:
static int report_cap_error(u32 cap_status)
{
	switch (cap_status) {
		case 1:  /* Not Valid */
		case 2:  /* Not Supported */
			return -EPERM;
		case 3:  /* Busy */
			return -EBUSY;
		case 4:  /* FailedF */
		case 5:  /* Aborted */
		case 6:  /* Invalid Data */
			return -EINVAL;
		default: /* 0 or other, Success */
			return 0;
	}
}

and then instead, modify ras2_check_pcc_chan in this way:
		if (status & RAS2_PCC_CMD_ERROR) {
			cap_status = readw_relaxed(&generic_comm_base->set_capabilities_status);
			ret = report_cap_error(cap_status);

			status &= ~RAS2_PCC_CMD_ERROR;
			writew_relaxed(status, &generic_comm_base->status);
			return ret;
		}

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
> + * @ras2_ctx:	pointer to the ras2 context structure
> + * @cmd:	command to send
> + *
> + * Returns: 0 on success, an error otherwise
> + */
> +int ras2_send_pcc_cmd(struct ras2_scrub_ctx *ras2_ctx, u16 cmd)
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
> +	if (ret)
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
> +	return 0;


As of now, this code doesn't consider errors occurring after the
mbox_send_message.
Checking errors is, probably, necessary to take appropriate action - such as
reporting an error to the user.  Also, error or no, it is important to
call the txdone bits.

One simple solution that works is to modify the previous "return 0" to
look like:
	return ret >= 0 ? 0 : ret;

> +}
> +EXPORT_SYMBOL_GPL(ras2_send_pcc_cmd);




