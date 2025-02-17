Return-Path: <linux-edac+bounces-3110-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D238EA385F9
	for <lists+linux-edac@lfdr.de>; Mon, 17 Feb 2025 15:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 661671891ED3
	for <lists+linux-edac@lfdr.de>; Mon, 17 Feb 2025 14:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C52224AE6;
	Mon, 17 Feb 2025 14:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1bbx0K0/"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9F52248B8;
	Mon, 17 Feb 2025 14:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801861; cv=fail; b=jPGuIdI3WpAWC1B1b1rkuGFNMM/NxpovEusvqmlVHhk3uoEP906rKMsjOd3uR/VYdqXHw+e+ducAwQCE41Sx1/0F8ZxwT04/vt3voyfBBuPJxwAtOY+bMJ3JIGduUL4c1oUlB2zQK33xnLjLwiNcdFP2v9hcjyAeF2JORicdP2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801861; c=relaxed/simple;
	bh=ZlXBKTaH2prEpfSOLt7Hf6vKw4J88knM00OFqR6jndA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OIHkydGOzFeBuTb1cAwVoS+/dcBINr6NsjHR70aP4FSyer6lOK7hEXPONGrSktH72bw8PGfy1VbzWM/OEXSDnvyhpePsyyIavVqpz5CdfsMcN03UxRMDUewy18JRQl/4hW9v0CQbk6rL9vYoQT35Qi9J9TXGaSJPnvA1uMNTvBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1bbx0K0/; arc=fail smtp.client-ip=40.107.243.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q6lEuKfybCUqU9dqEhyc7EI9iSP+3szQM5LmAKtsTBzxOj7BmM4hAhGAzb2iAEH1gv8XSY1Ijs46aPb6DdDfldzs8NSPGDrjjUcA7mQ+noFsXj+Mdv3BUH3x702eu9/nGrx8y+gxii8yxVSm/NTlhNtoqj1KKCRQMinn6dHNKKup3PGl1RGxFmL94WEvlMgOc4dNYTrveFxuk4qyAzp3Qh/zQ6oThpwJgzu7uPqklSQG4074pdFUFc2PFY5oj9CRZqYoLbL86FwZ9C++g2FG0S2ZxwhH9MYLfy5DTajta2Oa0vdpy38TTlyexYZOl9mPD5pJnqkDPfD/1m8tb8i34Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j8Kxo6dwf9o1jOghj03ftVwukh1enuZrZpKNeMphC+g=;
 b=afykQQITQzE2v9fZ0UGwwWHa8s7i/QmGa5ef13bdorYVjBvbareAJ0GXr5GM4SWIPCdHMEdx/GtdpZA5qxzAvqsm/wsSLMGFturcah68rY3GAq5ljEoJr6fB2xC+xEbILW0KjOXGmIGIxLOJ9qzlG2qTHcgnC1slwc6mLx/fuoYX31EjxtIM6cwd8EoNPGlitkV8OWYGXSoWqd6XSPSqnY/v/CUrSDuZ4zPjTSd3rAe12I/fFOHtwMoIuhhH20/dMQ75eJkrF/oWb7zuA6HO3NJQTRXbj49ZcXsMVDQ7AizQrX7/lr16Cr7b0sGLENHu3bzAsN68dRHVyGx+zENnPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8Kxo6dwf9o1jOghj03ftVwukh1enuZrZpKNeMphC+g=;
 b=1bbx0K0/2++y5WFlgWroWtLvtQWfBXcqGsfdxbn9RG5WXKseKSawBrJkDTZNtX+wKNc/wwymEe1q0GHbaLQGP+IVCFTaaLPtU6ak662za69xO70UkId53o4Xn0FT8I2AypVheDAx3kptQ1SxnYRd00Nfz6+jdkgt16o7Rc0ymvI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6354.namprd12.prod.outlook.com (2603:10b6:208:3e2::11)
 by CYXPR12MB9427.namprd12.prod.outlook.com (2603:10b6:930:d6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 14:17:37 +0000
Received: from IA1PR12MB6354.namprd12.prod.outlook.com
 ([fe80::baf9:26a2:9fab:4514]) by IA1PR12MB6354.namprd12.prod.outlook.com
 ([fe80::baf9:26a2:9fab:4514%4]) with mapi id 15.20.8445.019; Mon, 17 Feb 2025
 14:17:37 +0000
Date: Mon, 17 Feb 2025 09:17:33 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Cc: "x86@kernel.org" <x86@kernel.org>, "Luck, Tony" <tony.luck@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"Smita.KoralahalliChannabasappa@amd.com" <Smita.KoralahalliChannabasappa@amd.com>
Subject: Re: [PATCH v2 03/16] x86/mce/amd: Remove smca_banks_map
Message-ID: <20250217141733.GD591070@yaz-khff2.amd.com>
References: <20250213-wip-mca-updates-v2-0-3636547fe05f@amd.com>
 <20250213-wip-mca-updates-v2-3-3636547fe05f@amd.com>
 <CY8PR11MB713439C32E76A85C09C666BB89FB2@CY8PR11MB7134.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CY8PR11MB713439C32E76A85C09C666BB89FB2@CY8PR11MB7134.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL0PR02CA0126.namprd02.prod.outlook.com
 (2603:10b6:208:35::31) To IA1PR12MB6354.namprd12.prod.outlook.com
 (2603:10b6:208:3e2::11)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6354:EE_|CYXPR12MB9427:EE_
X-MS-Office365-Filtering-Correlation-Id: f82cd989-bf60-4ec5-5a7a-08dd4f5dd432
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?KzIzVXBTTWZLU240OHFnVjVxNkE1VFY5OW40UDd6MFQ0dEg5cVdYMjdDSStK?=
 =?utf-8?B?WjJXYys4T2ZQc2hMMTQ5YVIxZDNzSlZaMlh0MDFHUGduYXhCa0dEQzE0RUlF?=
 =?utf-8?B?b2w5VURDVmt6Yis5b2VDMURNYVlmL2VwMEI1QkRncWtSNkdkVE4xM1hpUGJ4?=
 =?utf-8?B?NUJkR1dncGU3c3VmbW9mbUlSNDJyYjlGckVmb1lMUE1QY2dqZkdyMlhoMkN2?=
 =?utf-8?B?Z2l2RFNMNFRTRDJES1JwcnFQa3JmQXUwaXFOYi9sRlpqb05XdWZ3elpmVzhM?=
 =?utf-8?B?dUZKbFE2dFZoeEtTMnVUV1I2Nm1INlBqaUUzOU5JdDlTUEROOXpTNnRKRkJm?=
 =?utf-8?B?bzZrbXZ5VU5HbDNWOFJmYnN0bFB4TGlPaSs5cHJhQlYwWWRvSkxyWi9RdXl3?=
 =?utf-8?B?L0U5dmdONFNzR3dLS0RvM3VZRzJtRzlnc1NGMHJnTWkvVGJkMUhRcDdzR2FE?=
 =?utf-8?B?YjBTOUpFVGh0a1V0WFNyT1IveVRjZUdDOG5wYW9KWHJJOTBUeGNBdHNzSjRv?=
 =?utf-8?B?Y1o4RzVtQ0pXNXhTeUtJdlRIcm0rNUl0azNGOVFKNFY2ZkJ4NlJEcVlqdjQ0?=
 =?utf-8?B?Y0xmeVY1RTRKT2h0b3NwQzRKZ1lSQnA3M3RidGU3a1hONVo5R2FzczJqWmhG?=
 =?utf-8?B?cDQ4Wkg0WGlwWnlKeTFEKy9xMFZvYVUxaDJZZkVUOGh2alRTWjNEN01FZVgz?=
 =?utf-8?B?cUl3UDhvODFKVlZsNnBxb0JEZy9yVEUyMHBESjR6aWoxNCtkNWxCSmR0UnhB?=
 =?utf-8?B?U3kzUlE3UW9JYWo4LytEQ1V0MDBIQ3YzdGkyZnJLV1ZRMFZ5Y2laeVIrblpQ?=
 =?utf-8?B?LzNXQ0pQMWhIN2xxVlJsQlNKRFNYeEFsdzhkYXh3d1ZDVW5IS2tMQThFV0dT?=
 =?utf-8?B?UHF3a0dnVGtzVTRWczlpWlptdENjSytFdndOWHp2T0xXcE1meEY0M1F5RHM3?=
 =?utf-8?B?TFdIK1Jqc2g1UFdKUmp0emtIOHhaNjZHOXNpaGhpTnFYZlVsaG9ubWJlY3Fj?=
 =?utf-8?B?L09xTFJoZFBkcjc1b0xSQk1vMGYyL0kvSmxDS3BjMWJTQW9TNzJTZGl3S21W?=
 =?utf-8?B?Q2F2V0p0d1BmK0VGYkhNUWRRZEZKZEdRUmZGTEZzNXZ3a1BaZmEvaFQyM0F4?=
 =?utf-8?B?YW5zLzA5Zi91Wi8zVGdTTDdCWFhuaEFBeDhscmVtaCtpVldyUS9HUnNTbm50?=
 =?utf-8?B?M255Q2wyeWdoSEptcThyT21FWlcrZ2xsbGErNmZGWW9PMGUvNWx0ZzFZOGpk?=
 =?utf-8?B?dGdEc0U3Rm1WckVlcXZ3K3VDTzFzWTlIQTZYUUZUTzEwQ3JTbjJyWkpxZ2dN?=
 =?utf-8?B?S3dtT0lkUUlCQ2pwbS9xbk95OS9YM2s3NGtkV1dWSEtMRWM0Nk8vR3dxcm9t?=
 =?utf-8?B?S1NSem53a2p0MWtiUXNJWXg5SUNXd3d1WENpUGVaMDFJMU5CcG9ud3pteVVE?=
 =?utf-8?B?SFUxcW81M3RpTU5jeXBUSzEwMjBTbGQxcHhCQWszOG1oMm9rbFB5RFQvZkI3?=
 =?utf-8?B?Y1F6WFhGQmZrZHB2eVNob1kwUkNvM3VmZy9vc3Z3T2JTNjBWOTNUQTE0WHI1?=
 =?utf-8?B?MEc1allla3l2bi9iaWJPRkRKQU9JM1R0Nk9NY0U3ZUJ4Tmx5cUZlamhHNnA5?=
 =?utf-8?B?V01neGQxUlBoRUw0b1NvTWpnVEQxODVxYmE1NUQzeUI0WjFvdW5vUThFeFZa?=
 =?utf-8?B?UUt1UkgyNE1BejZUaDZkekdyc1dWMkRiVXVKUHcyalZwMkhRakk4RUxmWWZM?=
 =?utf-8?B?cnI2a2NSQTRYcWEvRzRETUZEc0NvT2drTktaeWZ4dXBOTTM2dWlOb25ZaXhW?=
 =?utf-8?B?aVV2WWNlNHc2QmtJWG03Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6354.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aStkdVdZcGJTR0YzUU0zbnEwV0lsOVVQaEh3VmdrVjZ3clNjNDdIRUtjV3Y0?=
 =?utf-8?B?T2R6OG43T2tUWXVaN3dpYXhzdWF3czY4eXQwNFBtdGtqOCtET3JYM1ZxSmtD?=
 =?utf-8?B?bjhEUHhNQVJrSzZwclZVRHpuWHdYOTc3OVB0NWRnMlBjRUI1SEFadmQvVGdZ?=
 =?utf-8?B?YzhQZmtMWlY0K2ZIUk1qQkp2Y3FVMnA3QVpHbWMvOE1MdFQ3SW9rYWljd05w?=
 =?utf-8?B?L09qcWJVYWRaTlNHbU5wbDJWaEdoTndYdlV6YUxtQ0dYS2h2eGtUcTIzYTI0?=
 =?utf-8?B?VFBGVzV2L0xFQXB0OHBNN1dWZWxRVEJmdUFrSUFJN29zQlIrUGEycC9qSG1B?=
 =?utf-8?B?OTVKVlNFOVdnWFVhS3VKajRGZGYrNlZxV0UvSGZDRXdJWkJaOU5vRWZSVWJM?=
 =?utf-8?B?dnlYUzNORmNsdzlsZytlT3YvdkJhQWRkck1ueURPc25oS2lqNGlFQlFIN282?=
 =?utf-8?B?MTRBdU1TZUV0cW5jd0RhamlpMUNaeHRBSUErSFlPcjdId2ZmejJqc1J5ckk1?=
 =?utf-8?B?cGl3VmtQbGg1SGdPRERtdzMvTmp6UGdnblFHRTFFVlpiblhEZmNlNEpQUWNi?=
 =?utf-8?B?SVNVa0E3YUw4bUs3SmZGUHdaMkNtY0x0ZzlXd0lpTE1LN0dqRkJIVlJ0dVU2?=
 =?utf-8?B?ZVJBYUxXZG9EWXl3MWdQTmRkc0Z5c2MyVzZuK2R5emREd3FqZXY2dWx3K1Iy?=
 =?utf-8?B?SzU4MGh3NFBPbEJ6SHhzRXZNdUdTWjc5RWlSektNUjdVLzVHOFB3OTU3bitu?=
 =?utf-8?B?c1pxaHVsTSs2YnJOcXJ5dWVoQ1cwSHU0ZDBUZVJDSXBkM0RlNzBzL2RpOG1I?=
 =?utf-8?B?dk4wQkYzQVE4VXZReVpNRzE1U3lEWFhyKzNkZURGcGs1elpVUExXVm1HNEgw?=
 =?utf-8?B?WnNleUhUenFIR0cwRTZRNDJNaFFzRUpIRDltaU1RWWdpUnZjM3VNekFDTkJ0?=
 =?utf-8?B?ZzNsM1ZEZkhQcXJwZFdUQnFHZzJlTzh2YThYNDI3KzdUa3RHWFd1ZEVsN3Vo?=
 =?utf-8?B?VXJBWUplU29VemUrMVFwQng2Y21ucmpJU1ZReC9TSnpYWWp3KzRaMmwxV3Zk?=
 =?utf-8?B?dXd3NjduMFNZWkw3eUJ6dDlXdDNobzhmRmYyUVRDWGxYY0JOWVk1WFZZSWFt?=
 =?utf-8?B?QTNDellQaW9nc3J2cWEvMHpuQWk5dFN0bzlydXg5S21ObUhzWFpoWElzbjRm?=
 =?utf-8?B?ait2K3lMSlM1VGl3RTRXWnFCN0tVeE1uL2ZRTEZSZ0lFVW5CYmN3NGJ2MUFD?=
 =?utf-8?B?KzBuTmFTQlBtWVhkOVI2bU5xb2lmbmE0RjEranYrWWZBSkNSV09MTHc4eERW?=
 =?utf-8?B?Zk9nV21LSEZSRnJNQnlGZHFsa2FCTGwwRkJhTTVTb2huWVZjV0grS2ZaN1pB?=
 =?utf-8?B?N3ZXOERUc2xIcUxlc1UydE91S1plRlFucTJVK2FRYURwWjR5bHJnQlI0Vndz?=
 =?utf-8?B?Y3hCZDE1SWdLaFp3dUhiMGdXU0RqS29RQTh6ME1VQzc4L3ZMeHFGUit0RlpF?=
 =?utf-8?B?bnd0cWZwS2V0WENNaDI5U0Q4RERGN1BpWU9zaGZwdFExWjVVTjE5VkIyd0RL?=
 =?utf-8?B?RUpKWWZCeDdSMmQzbjI0S21RQUdEOG5LZW1yVW5UQjRQR2RlSVZnbHpuZGdq?=
 =?utf-8?B?ZHNtNmtFQmJSM2c3YmJpS0xibzJkdzVVTmliMmdiTGZDcExFd0ZDUFZUeFlq?=
 =?utf-8?B?aXJES0xPaU5ZWFJRY3lJZlU1TVE4bm1TekFQUWxVNFZDTVp4QURrdUkyREtw?=
 =?utf-8?B?bmkwb1F6WXlEQzZHWUVuVTYzMDR2WGRVay9uY3d3SmxjMW9nd01mbWRsUVkr?=
 =?utf-8?B?TFlsSkFkd1lVeHUvNDhXb2JIOWFoU2dpdEw3TGgrMWF2eDVlQzZrL2taL2F1?=
 =?utf-8?B?MDN3R2JNbFh6NWEweFVSYlpaWldhdUplMlJSc3ovYUtRSXJtbDZzMkh3QVRj?=
 =?utf-8?B?bnUyWDVwV245L0h2dWU5M2hlREo4R2dZVWZ6Z3ZYa25mZjRSOFFvZ3lwaHFY?=
 =?utf-8?B?YkRoRUJRa3BJQlJtaUdiWjI2TWgza2hWQ1FWaGpta0V1SlBWbDQvK2V4Z2d3?=
 =?utf-8?B?Ym5UcmJUM3hFTERpZlRCN1g4VkNaNnlwRGdpWmJqZWZYSmVjSzVUakdwRnZF?=
 =?utf-8?Q?IEAsu1gamxpJS0xgz14aYWuD2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f82cd989-bf60-4ec5-5a7a-08dd4f5dd432
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6354.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 14:17:36.9603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bEAhvilmV9SOmAe947Sp99Fr/K8Fmi21MLmvEeQdiPdkfIhV91eaamRHT4zlh967eh6NGtMZ2c6caYirR4CT6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9427

On Mon, Feb 17, 2025 at 07:57:47AM +0000, Zhuo, Qiuxu wrote:
> > From: Yazen Ghannam <yazen.ghannam@amd.com>
> > Sent: Friday, February 14, 2025 12:46 AM
> > To: x86@kernel.org; Luck, Tony <tony.luck@intel.com>
> > Cc: linux-kernel@vger.kernel.org; linux-edac@vger.kernel.org;
> > Smita.KoralahalliChannabasappa@amd.com; Yazen Ghannam
> > <yazen.ghannam@amd.com>
> > Subject: [PATCH v2 03/16] x86/mce/amd: Remove smca_banks_map
> > 
> > The MCx_MISC0[BlkPtr] field was used on legacy systems to hold a register
> > offset for the next MCx_MISC* register. In this way, an implementation-
> > specific number of registers can be discovered at runtime.
> > 
> > The MCAX/SMCA register space simplifies this by always including the
> > MCx_MISC[1-4] registers. The MCx_MISC0[BlkPtr] field is used to indicate
> > (true/false) whether any MCx_MISC[1-4] registers are present.
> > But it does not indicate which ones nor how many. Therefore, all the registers
> 
> s/nor/or     (suggested by AI 😊)
> OR
> s/does not indicate/indicates neither
> 

Hmm, okay, I think the second one.

  "But it indicates neither which ones nor how many".

I guess this falls under "Using 'nor' without a correlative pair".
https://www.learngrammar.net/a/how-to-use-nor-properly-in-a-sentence

:)

> > are accessed and their bits are checked.
> > 
> > AMD systems generally enforce a Read-as-Zero/Writes-Ignored policy for
> > unused registers. Therefore, there is no harm to read an unused register. This
> > is already done in practice for most of the MCx_MISC registers.
> > 
> > Remove the smca_banks_map variable as it is effectively redundant.
> > 
> > Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> Aside from the small nit above,
> 
>     Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com> 

Thanks,
Yazen

