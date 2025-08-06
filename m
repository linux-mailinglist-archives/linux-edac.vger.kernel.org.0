Return-Path: <linux-edac+bounces-4529-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 982AFB1CE3E
	for <lists+linux-edac@lfdr.de>; Wed,  6 Aug 2025 23:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46D44623A2B
	for <lists+linux-edac@lfdr.de>; Wed,  6 Aug 2025 21:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7225C2248A4;
	Wed,  6 Aug 2025 21:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oiH6orew"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2059.outbound.protection.outlook.com [40.107.100.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE00221F15;
	Wed,  6 Aug 2025 21:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754514500; cv=fail; b=GYqkbg0+iIIZcr2us9KVDS7Z/A6xrQwoj7gNgCrxmG42jYEdETDDHze2bQQcruHr7ZTIrItde91IoerytMKfO4WCtyfMaeMDDATI9YAW5WanqkBI/wnIcSDMOeSpK+0PAH306UJ4J5WhA3QdapiY2WVUv9SjCOot6oKenJIdZvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754514500; c=relaxed/simple;
	bh=roAjjsGxyErJ+Z6Xz2qIMia51ek3TCHZN8DI4TlCHpo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Dlwc/bJpZlUnDbZ/xLmAKsVAPF4gF/KLUZoj1tThiWGpWFyEeuamu1arqltiUA73BexHM80CWbadYecFtIHh5xM3SjTF6tQqh9rPnUlassHDHKRGDhajexv6NUjEPiRWrPvJlXbBlxmMFIiXXcL6/E4uBe+LVGAHg/N17HfpcSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oiH6orew; arc=fail smtp.client-ip=40.107.100.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ab0G5YwIWl8oA/o4UN5mjvZiO86R6EKiyXTG03t/xVr7TiJBdd7h4C6w01EMjYoNdPTg2Dg6qS3vKC7s4WAmydSMJ08kQiPsftVvuFHuryYVbECuLLoW+TCCLwYx8mrV7ZlwYouCEQn/5YP3b+1+Cc3yuMInJZhI7MVx1b0jb1iKqL9MF+vi0+Nsv4+PPf4NPIWhdtk97YsQh+3eGIHTkJ6iPURKLzk3k9eLF4bq9kK6AstzcevJWHCApHXBl0vxuf41VanIgSfgDwu3+o7sXxlTIFZvOYSsbGc5cLR+0Uzw4YS5bewan7QK7GURmLOm5zlKkZi4vCAhrNQeXe7F2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1qsKmbWwCFTZfJO3+4Gvrqbay/UI0XNaLrU8PhRo1c=;
 b=xDZLjibAg5upSut+KYOSvI4BH3xYlV43WWalDDhqk4Fqluxfyo6HrwX/15SJr42OO7VNuOt9HRpyvm/saYi1D59OruPG2MumbfvlIxINZHhE3IZ1+Kjbkh63eALys6MrxtcJ1mnYmLYv6YJBpewjwhgYgWZFV1JmdKv61IFMUhlM+XmPgDRo+WY2qiZ+qsMfFnyDgaCKpdSQqEYD6J0OZzRBfxIxWbGi/pfOBqb+Gp5Ldu08AoQBBsYJXAxeN30hSH6hiiwPZD4p7105OEYMcWOsvvsYDCqQeHxPIyiF1JEDG+5fKXTf9CYd+v9aq2EUgUlijw0goB/hMqVpFx6RFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1qsKmbWwCFTZfJO3+4Gvrqbay/UI0XNaLrU8PhRo1c=;
 b=oiH6orew+mUlSgbpakQdQIO6kzMNIsZX+UckcMtF/+cdjkP4EyOkRlf5isnAJVbdqq+TLCwzUK2v00AkvY3C2VEXHbbu2bTbHW4RYKovwry9bmqJMUIfCNeb8A8XkAUx8ImQDjwue1GdjTSfbM8jdxcqpzcCYNwAMjb6B24eRsQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5378.namprd12.prod.outlook.com (2603:10b6:208:31d::16)
 by IA0PR12MB7601.namprd12.prod.outlook.com (2603:10b6:208:43b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Wed, 6 Aug
 2025 21:08:14 +0000
Received: from BL1PR12MB5378.namprd12.prod.outlook.com
 ([fe80::9cf4:a6ba:b42f:d135]) by BL1PR12MB5378.namprd12.prod.outlook.com
 ([fe80::9cf4:a6ba:b42f:d135%5]) with mapi id 15.20.8989.015; Wed, 6 Aug 2025
 21:08:14 +0000
Message-ID: <c9ae8b26-e254-47a7-8e2f-b5da90f50030@amd.com>
Date: Wed, 6 Aug 2025 16:08:07 -0500
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/2] EDAC/amd64: Incorporate DRAM Address in EDAC message
To: Yazen Ghannam <yazen.ghannam@amd.com>, Avadhut Naik <avadhut.naik@amd.com>
Cc: linux-edac@vger.kernel.org, bp@alien8.de, john.allen@amd.com,
 linux-kernel@vger.kernel.org
References: <20250717165622.1162091-1-avadhut.naik@amd.com>
 <20250717165622.1162091-3-avadhut.naik@amd.com>
 <20250728151440.GB33292@yaz-khff2.amd.com>
Content-Language: en-US
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <20250728151440.GB33292@yaz-khff2.amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0154.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::24) To BL1PR12MB5378.namprd12.prod.outlook.com
 (2603:10b6:208:31d::16)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5378:EE_|IA0PR12MB7601:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c8f801e-4976-4650-8a8f-08ddd52d5a76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cDJTaEZoM0RFU3lCTEY5bTVzS3lUMnNkdFVkenp3U2ZjdldRTHNDUytnanlY?=
 =?utf-8?B?M2lkWGtNMk81VEFKYmFDVlJ5dDF1WjVEa25YY2tpM1Znd01PY003MFZRSCtL?=
 =?utf-8?B?QUw4V3hxV013czgrNkVFcjVNc0MyMXpSVmpzbk5uSmhIV3k5OVduVzNWWVY0?=
 =?utf-8?B?MjR5aUlkZzhVUFN2aTJpdDJDWXlXTVFpTVozVHd0RjVSaGdLY2JRMUZKRlJC?=
 =?utf-8?B?Y0NmTURoYkhUcmY2UWtqU1A3eEZ5eno1YWdkZUx0ZmFyRUV5T3NCVFNqUHk5?=
 =?utf-8?B?NVIxQmNGWGJJRWdkVW1sNHJIYzU5bXpmU2N0ckRkeWh3VjNkSzU3ZlBsZktQ?=
 =?utf-8?B?L21HWFVJVmVTMDhNdG0rNmJYc09LaU9CVVY3c2lFbVBsaGFQak1DcXFNNXZr?=
 =?utf-8?B?amtoKzZXSHQwNWM0c2o0UFJZbndabTgvL0c2aDd0bkxHemtKRFBrSk5SREl4?=
 =?utf-8?B?TGJDdGhGWXkxTTJuVzBVMXl3aTFldi9rcFNITkpBL2x5d0x5aTV6dFhUZUxy?=
 =?utf-8?B?Y09saGNySjdYSkJzNnlEOVdwTFExNTVWNEs1VEJabDlVMmZOeldFaXVBc1h6?=
 =?utf-8?B?aDI1RU5SSzJqTzZrSHF6NDhTZzlyeGRIZndOa2JKMnAyMUx6ZjQyY3JhNUFh?=
 =?utf-8?B?V3o2aFFQM0E4SXJabmgyc1R3eXBDcDQ0NHhGVzBwZzZBajBPNkxhSURjSG4x?=
 =?utf-8?B?RVJGTHZLK1FZL0pac0c1a2NtdzVNbTZiODdUeXRsdTkzbndlU0RSNkhsMzFO?=
 =?utf-8?B?ME11aUc0VEtnQWlzUkNKZ2ppUEdtaXRjZk1yU0g0UzdTTnUvbW5tSFJFMkFT?=
 =?utf-8?B?eUNJZGg0U0VSanFZWVRpWXpucEo2Ykd4Zlo5UUpKQ1VDSmlkcVU2TmNtNlJr?=
 =?utf-8?B?OElaMkl6L3BqNWFpOTFwVyt6L0hySlVTTVN3eFRtMnVEOFJnOGdPQ01WODNp?=
 =?utf-8?B?KzFTVGxJK3drbzM5cWM2ZHpRSVp6dVAxSFQxM1VqQlM1aE5hTU4zdWxNMDFn?=
 =?utf-8?B?dURBUVhKRXhWL3ZUdnlTVzRSZEd2UHl4SkFnYVkvU1lYaXZVbFBLZi96SWNn?=
 =?utf-8?B?THNvTDdQNWE0Y0U4WFYvdldQbGdWSEVnOEZxSW8wc1NqSUFOSFJ6UCtpMFlY?=
 =?utf-8?B?R0Q2dGExQ0E0Rm5BOUY2OWVHVy9OWCtTMk40M3NaMDFJUWpGclVvajNyODUz?=
 =?utf-8?B?VEd5SXZxamlvcXFuL1RXKzQ3VlQvYjBNZE5JckpIMmJuTEg0dnFMOGkyNjlL?=
 =?utf-8?B?b2Ntb3Rwb2VGWlpodUxqRmdSSE8wN3JRWFJ6RzhiODFRci90OVdEb0Jxa2U5?=
 =?utf-8?B?aG8zL1NQSWZsODI3cVhVbTZiNzVHcGVYUTJFcU5rZjY0bGFVb2Z1ejVITi94?=
 =?utf-8?B?Q3NrUkcxdmJEVzlISlZxNUhJcVBCTUtONlJhT1J4cy9qd2JUKzZ2WFNXRmR6?=
 =?utf-8?B?YVdSRXViOFk1THJ2UG5XanhpcDllVTI5aWpGTW5yOGwvT3pZNjhTSVhxaGhp?=
 =?utf-8?B?b095V0F1Q3liRWVDcG8renR2bDVIZTNsejdTdnVORlhIcFpSeEtQbjMyYkNv?=
 =?utf-8?B?d0pWbUhObFMxck1iQ2pWUjhjOVF5aEZFbnYvcWtVU0ppYmlyR3NKNUwrUVVC?=
 =?utf-8?B?eEZUOW1vUUd1eE5nVldwTGd2T3BpSWx6NDM2dVZ4U0t2RHdUWEJ0U2plWW5Y?=
 =?utf-8?B?TDhhME5Ia1ZZL3hkTmtFSnhjMm5sMnZjM2tlMkVtY0FjUUhRNmd4d2dDczVv?=
 =?utf-8?B?RDNrR1M0RU04SGM2Qjk0OCs2dnZ3ZFNVZDJYazFMWjlCa1JicURYVEJnbzIr?=
 =?utf-8?B?VXc4emQwTjBkSlFmS01zdkRYT0thR1JVYWZHSGFZQmtnKzFPbVRDSHZzRDlJ?=
 =?utf-8?B?ZzArbStKdVZuRmk3cGFicHJ1QlFHbXJwekhBOGcxZ0FFSXpKNUN0enRCVEhj?=
 =?utf-8?Q?hTUufIRtx4o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5378.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1dRRy85SVpVMTlpcGhaMVV3SGd4aWlqSzdBQkFkSEx5MW96b2kvTzFVaVlS?=
 =?utf-8?B?K0h3czZCZWJwUnNYbGRSc1RqMFQvNS81ejRZeGRVOWlpUTlsUUV1UFpJZVVz?=
 =?utf-8?B?TFJORmRnVVg0R2ZaMzV5Z1pwcmJKdFA5SEpSQllPQUdqaExza05UeUNNejdV?=
 =?utf-8?B?aHdlaENxOWRQdUVxcUp2eCtxR3RZRHJNZW5nWHgzOTc2N1REVEJQRkY2RTZl?=
 =?utf-8?B?cURHNzNBek11NFV4SWdtMjdzTTd1OUlaNkRvcnNwVUVZcWYxT2krZDF6NjN2?=
 =?utf-8?B?Y1NHV2JaeEN6dTBSTVRkRzZjRDhLUnBuTlRKbDZZN1hCdlRkRTNQNHNwT3RN?=
 =?utf-8?B?bnQ5QmtmSEg3eHV2NERoWGdwRkJSVVhOM3lsSFl3WUJndDd3eTNSYjlzcHlz?=
 =?utf-8?B?NjQ4WFNpaXE4d0lTNU1PRWd6cXFuWUlkUjFzMzhkRkZIdnVraVk3elFrTG0x?=
 =?utf-8?B?eGhnUWtKci9na0dKNFZGWWRIU2MySE9yTFFJbkhQaDFjdlZMVDJudmwxY3Z3?=
 =?utf-8?B?L1RSMmdoMWc1TURZc1RnVC92UE1EYmJpNmMxU1orcUJOSktMYmhvUzJ3NitE?=
 =?utf-8?B?a2Q3YllHSjlhdy8xK1prWHNoTTU1ZytIczZLRmVhRjFrdVhUeFFrNVBobzNG?=
 =?utf-8?B?R0x1UmdrcUFXbW1LUGNPUEo0UDh0ekExQ0pDL1FaYlVscEtyMTlNTU04ZVBM?=
 =?utf-8?B?djJxeThmNWppMUNLamNWNnVEUGdvc2VEVVVXTjd0VG1rMms3SVNrWVZpK2Fr?=
 =?utf-8?B?ZEQrTDZjQTdoUjJZOW13dVdPd3JiRStsSmF2azNQTm12SDlMcFdhbld0SWZk?=
 =?utf-8?B?ZDVoUUFhTlNlcGpGdUF2UWhvUGxDNlRSdlJTWU5UdHJjQ1FkUzZndzVHWjRT?=
 =?utf-8?B?MVorczBpUDlqRGJQNGs0ZXhYR3JzYUFsMG9Gb2hQUGFycVJvblJnZ1VudXBW?=
 =?utf-8?B?OWl6MzZKYlJ4ZjcwUTc0anJ0aVhMcmZnY0pnMFNvT1BzNFJOaTBBbWNObU5y?=
 =?utf-8?B?d0NKOFJBais1VHVKVDRTODgyMzNSNlRpYWNwcE93ektWQUN6Tm9JYTdiV3Rn?=
 =?utf-8?B?dkZWVE1xdFFQYk41OFdzdVZaeTBBK0lGSjNSTm5EeEtVbHVZU2U4aE5vcVBT?=
 =?utf-8?B?cll3WWpuVk00T3pHazhrMEx6RklaYXljWHkveldjWGlQYzhIMFdydGRhMnJl?=
 =?utf-8?B?NXBOU2hXa3lUVjlLME15Wk9pVStRMW0wZTNrZEFPdWFnYjlJR3pTdU1WYzlp?=
 =?utf-8?B?L2dCRFFyaGo4S1ZWYW1KYnFqM0R0aEdxdGxuWU1JOTBPSjZyM2hjQis4QWVj?=
 =?utf-8?B?ZjNqRjdJOVZHTXh2eEdwOWdBeW4xNjZTajZFSHFXRzZkcXRhNHFmRUs1NU5N?=
 =?utf-8?B?RXlFdnBRS0ZFUTMzQktEVWZFZjFpL3NzMXEvTXdXNXlEbVNIeGowUE40eUN1?=
 =?utf-8?B?SXNzYnlmMkNuWjRUU2UveUV0MjNORmZ6emFkUm1iK0hhMFVta2NTejBBN1J5?=
 =?utf-8?B?NE9aRmxuQnBzeCtqRm8xSG9aVzBhMWZMck1zVnNjUWdNWnRDT2pGVFUzRzlV?=
 =?utf-8?B?VkVYMEhIZk1PWExoNEQyekpBWklyVEs5Rjl3eHNzNVdPVDVxRzEzRlZ4NHJC?=
 =?utf-8?B?YWJJYk1mNFF0U0dMZ2ZTZ3R5TkRON05Tck9HSStONXBhaXkyN2JxZE1ITG9N?=
 =?utf-8?B?ejhneWN2b2lnWElVTndYMXdSMmZzTFNPTGZENjNSL28wOFdUYlJzbFJQRlB5?=
 =?utf-8?B?bWptN0F0dFBJNWh1cG5nMUhVcHBrc3BuUWxEdEd3c256bFJWZjl2eUpsdnZp?=
 =?utf-8?B?bEs5Zm5lSEZFckh5cjFtU3V1QmcxUG5zMnNtUmwydENRZDJCVjRGTGhGRzBG?=
 =?utf-8?B?djZVOEJPRnN2NzFYVFJKZGs2dVFyK01ldDcxYUxYS3g5TmRqTmRHSWJSY3Nr?=
 =?utf-8?B?ZnhGT2VYR3dnOXFaY0ZnNkZxK0YyK3pIWEtIUUxsY2t6Vzh5dVhGeFNhb2Ra?=
 =?utf-8?B?Njk3eWpqcVRORFdFU09kL2pMUlpYYkdmZ1F1UGZRTGJyUHFraVlmQjE3V2RJ?=
 =?utf-8?B?YkRBZEtaTzhSSVhzOWlJOGlkSkFUUXFVTTMvYWttbXluejRGN3F4c3g1TVV3?=
 =?utf-8?Q?1GvZ22vhZS22pTbfvF+QYzsbm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c8f801e-4976-4650-8a8f-08ddd52d5a76
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5378.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 21:08:14.2583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s/BCkEPf2mONcam4NLfLlBkIc0IayBPvRH6sr1QiIZWmhnWAwIjqAY0ZWUfU2ba3XGa43QIDvi6mRBZVHycl1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7601

Hi,

On 7/28/2025 10:14, Yazen Ghannam wrote:
> On Thu, Jul 17, 2025 at 04:48:43PM +0000, Avadhut Naik wrote:
>> Currently, the amd64_edac module only provides UMC normalized and system
> 
> The amd64_edac module provides data for the EDAC interface. This is only
> the system physical address (PFN + offset). The UMC normalized address
> comes from MCA error decoding.
> 
Will reword this part.
>> physical address when a DRAM ECC error occurs. DRAM Address on which the
>> error has occurred is not provided since the support required to translate
>> the normalized address into DRAM address has not yet been implemented.
> 
> I don't think this last sentence is necessary.
> 
Noted.
>>
>> This support however, has now been implemented through an earlier patch
>> (RAS/AMD/ATL: Translate UMC normalized address to DRAM address using PRM)
>> and DRAM address, which provides additional debugging information relating
>> to the error received, can now be logged by the module.
>>
>> Add the required support to log DRAM address on which the error has been
>> received in dmesg and through the RAS tracepoint.
> 
> These last two paragraphs could be something like this:
> 
> "Use the new PRM call in the AMD Address Translation Library to gather the
> DRAM address of an error. Include this data in the EDAC 'string' so it
> is available in the kernel messages and EDAC trace event." 
> 
Okay. Will change them.
>>
>> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
>> ---
>>  drivers/edac/amd64_edac.c | 23 +++++++++++++++++++++++
>>  drivers/edac/amd64_edac.h |  1 +
>>  2 files changed, 24 insertions(+)
>>
>> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
>> index 07f1e9dc1ca7..36b46cd81bb2 100644
>> --- a/drivers/edac/amd64_edac.c
>> +++ b/drivers/edac/amd64_edac.c
>> @@ -2724,6 +2724,22 @@ static void __log_ecc_error(struct mem_ctl_info *mci, struct err_info *err,
>>  	switch (err->err_code) {
>>  	case DECODE_OK:
>>  		string = "";
>> +		if (err->dram_addr) {
>> +			char s[100];
>> +
>> +			memset(s, 0, 100);
>> +			sprintf(s, "Cs: 0x%x Bank Grp: 0x%x Bank Addr: 0x%x"
>> +					   " Row: 0x%x Column: 0x%x"
>> +					   " RankMul: 0x%x SubChannel: 0x%x",
> 
> There's a checkpatch warning here about splitting user-visible strings.
> 
> Why not use scnprintf() or the like?
> 
Had noticed the checkpatch warning initially.
IIRC, it was for splitting the quoted string across multiple lines.
Can use scnprintf here. But wont the warning still prevail?
One way I can think of for getting rid of the warning is to generate the string
through multiple scnprintf calls. Something like below:

            memset(s, 0, len);
            n = scnprintf(s + n, len - n, "Cs: 0x%x Bank Grp: 0x%x",
                      err->dram_addr->chip_select,
                      err->dram_addr->bank_group);
            n += scnprintf(s + n, len - n, " Bank Addr: 0x%x",
                      err->dram_addr->bank_addr);
            n += scnprintf(s + n, len - n, " Row: 0x%x Column: 0x%x",
                      err->dram_addr->row_addr,
                      err->dram_addr->col_addr);
            n += scnprintf(s + n, len - n, " RankMul: 0x%x SubChannel: 0x%x",
                      err->dram_addr->rank_mul,
                      err->dram_addr->sub_ch);

            pr_err("%s: s: %s\n", __func__, s);
            string = s;

Is this acceptable?

>> +					   err->dram_addr->chip_select,
>> +					   err->dram_addr->bank_group,
>> +					   err->dram_addr->bank_addr,
>> +					   err->dram_addr->row_addr,
>> +					   err->dram_addr->col_addr,
>> +					   err->dram_addr->rank_mul,
>> +					   err->dram_addr->sub_ch);
>> +			string = s;
> 
> Looking at the description for 'edac_mc_handle_error()', it seems that
> "other_detail" would be more appropriate for this info.
> 
> I do think we should consider updating the EDAC interface if multiple
> vendors are gathering this data.
> 
Okay, will use "other_detail" parameter of edac_mc_handle_error() for this.

>> +		}
>>  		break;
>>  	case ERR_NODE:
>>  		string = "Failed to map error addr to a node";
>> @@ -2808,11 +2824,13 @@ static void umc_get_err_info(struct mce *m, struct err_info *err)
>>  static void decode_umc_error(int node_id, struct mce *m)
>>  {
>>  	u8 ecc_type = (m->status >> 45) & 0x3;
>> +	struct dram_addr dram_addr;
>>  	struct mem_ctl_info *mci;
>>  	unsigned long sys_addr;
>>  	struct amd64_pvt *pvt;
>>  	struct atl_err a_err;
>>  	struct err_info err;
>> +	int ret;
>>  
>>  	node_id = fixup_node_id(node_id, m);
>>  
>> @@ -2822,6 +2840,7 @@ static void decode_umc_error(int node_id, struct mce *m)
>>  
>>  	pvt = mci->pvt_info;
>>  
>> +	memset(&dram_addr, 0, sizeof(dram_addr));
>>  	memset(&err, 0, sizeof(err));
>>  
>>  	if (m->status & MCI_STATUS_DEFERRED)
>> @@ -2853,6 +2872,10 @@ static void decode_umc_error(int node_id, struct mce *m)
>>  		goto log_error;
>>  	}
>>  
>> +	ret = amd_convert_umc_mca_addr_to_dram_addr(&a_err, &dram_addr);
>> +	if (!ret)
>> +		err.dram_addr = &dram_addr;
> 
> I feel like it is not necessary to pass a second struct if it is already
> contained in another.
> 
> You could just clear (or not set) that field if an error occurs.
>
Slightly confused here.
Do you mean we should avoid passing dram_addr as second parameter
for amd_convert_umc_mca_addr_to_dram_addr() and instead just pass
struct err_info instance err?

And, in case some error occurs, we should just do
	err.dram_addr = 0x0;
?
 
>> +
>>  	error_address_to_page_and_offset(sys_addr, &err);
>>  
>>  log_error:
>> diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
>> index 17228d07de4c..88b0b8425ab3 100644
>> --- a/drivers/edac/amd64_edac.h
>> +++ b/drivers/edac/amd64_edac.h
>> @@ -399,6 +399,7 @@ struct err_info {
>>  	u16 syndrome;
>>  	u32 page;
>>  	u32 offset;
>> +	struct dram_addr *dram_addr;
>>  };
>>  
>>  static inline u32 get_umc_base(u8 channel)
>> -- 
> 
> Thanks,
> Yazen

-- 
Thanks,
Avadhut Naik


