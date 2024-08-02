Return-Path: <linux-edac+bounces-1611-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 360D29457F3
	for <lists+linux-edac@lfdr.de>; Fri,  2 Aug 2024 08:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 234C7B2314D
	for <lists+linux-edac@lfdr.de>; Fri,  2 Aug 2024 06:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F316A3A1B6;
	Fri,  2 Aug 2024 06:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="y9tQ78ct"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4C41757D;
	Fri,  2 Aug 2024 06:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722579085; cv=fail; b=WkPN95AmNjgyD3YN8tW7Zvq3S4Su+BwBZ87mYKVSpRxXrF+YJCwSl2gwQgiOl3sWA5is9P7kgK0CUzT+ahGFCPPPKsaCXY0YIFQ06Kzygcm4hrh40BMFwix4rAhDXW6lgjK2mp7t7hG/PhEUJLx/CqKCqQbBwB0I3DrlnOhDo/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722579085; c=relaxed/simple;
	bh=H+p1hDDMrFWR3jydPh+Rkx5rGnR4JAZ5OEfqmaTSLSk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z/lnC0i96lfrS+eStO9wkzmfcj8TxDNfm6+5xaoRZV0B1FhT7OrVO854bBp4x/OLkWWVtl7fWpYJAleTb1gvaGj47qHkUuOHR8Zlc6ZrLri4Ta7XS01nZZ8FLTRyCggAIV6XpK1wllVpx1DZXuBESbGEB9Q+Ihxvsp441VxWFRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=y9tQ78ct; arc=fail smtp.client-ip=40.107.236.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O34vYGucaGhIM+GJiM6xqBXC1tzDi7PcoaImOiTfagu4M3uiKoJGtQdUO2VoFUiABirwFPYRYVYXOPS3CE+qTa2zXNx7403CDzlMFGoLd5w+fvwsoubEqjj8g1kEWKPeCtBiJMC8+sno4S+pwT5jVhpO3KEPr5a81GBSJpOdDqvJAhfY5534TcXPvfsU41RG7NFEYCIyhssxT093rlZwmB8z7KKXVeaZTSZUTtIe7CewRiDpQD1O8lFl0sHF6zCGLPgJs+O5DlQ9+61fXY6hArWc9Ledaj0mgMy5N7Hh/HakD5UKqP0k9kdguXkeoQIjGeF90Bx9I62SD0hNk8hQAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5BRh3GWXRKqz1mfjrLhoai7/0IkkDo/aT55X8ipdwTs=;
 b=nyTBKMLe+EkS2h1ylA/eZqHgkVqxtsiaNfHRDThXSymxjZcUPVQ7D6rkBDkfXgEi089L49b7XDupt+G1WrCJXzXHeQTCQ2+MMdsvN9DVYNmdjTVPBOgq2mn4S3BhM3DPWN7DzSy4ExIyA/2Q5H6v/EmUqZpiOygQHoruTaaMIkXA//yLwN5JXsvC1CR0EXp8BSUK2XtAcbksw2h85VYapcOf2qMv5qnAA4nGiEvNZ1iiiSgjIX8+vs+i6Ag8/eLJa5FS2VSXcPvNjrVsio7REEEoQrVWg4jQTmnyLfMSwVobajgomu+lwXopNWxePBiwSVTbprZNL+qIw2LIOLfH9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5BRh3GWXRKqz1mfjrLhoai7/0IkkDo/aT55X8ipdwTs=;
 b=y9tQ78ctmuyI7iLAXUm+2zJyYeGAMTb/IKpAmd00GN+GSftORdrdtgUkPKvEztbMSH1tmU5/f2gwEhsDmHlYfBZoEO0UTNHk8d8NsCk79idOcSHiveBw1n5EBCZKwsoRHXrnArXKJYGnt+FPSvhaoV6RayXzdPSbqCAAT/XwFjk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5388.namprd12.prod.outlook.com (2603:10b6:610:d7::15)
 by BL3PR12MB6644.namprd12.prod.outlook.com (2603:10b6:208:3b1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Fri, 2 Aug
 2024 06:11:21 +0000
Received: from CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607]) by CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607%5]) with mapi id 15.20.7828.024; Fri, 2 Aug 2024
 06:11:21 +0000
Message-ID: <322fd9eb-8793-402a-ba6a-617591561254@amd.com>
Date: Fri, 2 Aug 2024 01:11:18 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 RESEND] EDAC/ti: Fix possible null pointer dereference
 in _emif_get_id()
Content-Language: en-US
To: Ma Ke <make24@iscas.ac.cn>, kristo@kernel.org, bp@alien8.de,
 tony.luck@intel.com, james.morse@arm.com, mchehab@kernel.org, rric@kernel.org
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20240802044134.1569313-1-make24@iscas.ac.cn>
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <20240802044134.1569313-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0166.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::21) To CH0PR12MB5388.namprd12.prod.outlook.com
 (2603:10b6:610:d7::15)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5388:EE_|BL3PR12MB6644:EE_
X-MS-Office365-Filtering-Correlation-Id: d4574662-dcc2-4de1-6537-08dcb2b9ee14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MHpOZ2FxaWtGWHNWM2oxV25VVFFMZjRsSGRmTFlpckZlQVp3T1dlek8vbENL?=
 =?utf-8?B?cm1EUkhpMXlrWEtSTTVTSGZEcy91QkZRMmdNczdMN1VmSzBuY2Jta3BXSTdQ?=
 =?utf-8?B?SmI1WHhrTkNrTWxoV1hpZGVXRC83cE4xOHdkZ1RWa1JSS3AvdXNMNXZhU0c1?=
 =?utf-8?B?RmNFSTZZbVIwNlN1M0I2RVEzdlh1TmJjTGgydjdRSGtuUlQ4V1h1dzJGSUNI?=
 =?utf-8?B?ZGlmdzNZME9nd21DMjJ3akpLaEJEWkdDTFpzVGxYUDBnYTFzbC9NUzkxcno5?=
 =?utf-8?B?YnVlNlUwVlVtaGx1bHZ3SWQ3VGVwZUFjVW8xUzFuUEhOSDZmZzFhaC9KYUVq?=
 =?utf-8?B?K1VycDNJZ01BWUtBWGFyYklEakFJWDNVZzk1cmgwUjhQMW9zb016UjFGcHpm?=
 =?utf-8?B?d0N1UHZCMExmbUUwMVVpdHJOclc5emorWm5vU3FIUlZuZmxOa0hqVU50SnFI?=
 =?utf-8?B?YXhNL2lzbkdKSXF2VXk5ZDVTeEJ1c3liY2laODNMVTVqeHlwalQzUy81NThV?=
 =?utf-8?B?ZkJFaUZsV1p3QmVYMEU2ckh0UGE0dXRmMzZNRVdZY0pkdnJSWkV5S0NCSVZV?=
 =?utf-8?B?ZWUyQVBBSk5kK1l1cjZ5U3pzL2psNjNkY2FzZURKWXNXZFdXMmN4THY5d2w0?=
 =?utf-8?B?emhtcDNPNE43MGVSNDNlQVU2T1ViMkJ3WDN6aTd1bWVoVjJ3RnJic0ZMbnlL?=
 =?utf-8?B?bG05RHBXdnZkSVRDa2ZHSTBBSk1Ya2Vpc29LQ1dxalRWM1QzNngvWUVGUVoz?=
 =?utf-8?B?ZnVuZDZ0cjJXNDZCZWkvaFJHQ1Q4dDZkaFJvZkNNV2N3MkN2VXdNWCtrSStT?=
 =?utf-8?B?dEZUWWtESTB3MU9BOVJSQ1VSOERZZ0s3RmZYSDJlTWRSOXFpT3BjbjhFT1lr?=
 =?utf-8?B?U1RFMlVHMHRyYklwZTgxZ2ttTmpqblRuM29vNlAvdlZ1UWhoblBoNVZNN0RC?=
 =?utf-8?B?dTlnUlIvWlJST1FBMmZBOFNXRStCVXJFaU1LcHgwMDlkY2tUMVNIM0t0RGtm?=
 =?utf-8?B?c2h5ZHBQOS91RzdmenVRaVJFTUZqVDhrNmdhVlI2NDBCVllOTk9FSTI2TWpM?=
 =?utf-8?B?bDBzK1VqOEEwOHhkbG5RdUpNeWlpbFhMN3hoVXYzSVk4MUEvOEVYay9udko1?=
 =?utf-8?B?ekdJNld4dlhva3NPcGZHMFNURGVlczVJYkVBTmp6cWZ6UkNTUFVnMllDcVdW?=
 =?utf-8?B?N2oxRHMzeWZuZzNJbVM2NEd2WXQxM011cDlqYkFMSS9XcWJrNnZIZUtqTi9Y?=
 =?utf-8?B?L0J3WHpCNW9IRWFOS1hzVnhiUk1IV3gyR3Z1TDRpV3NucjF1UzZISGZGM2s1?=
 =?utf-8?B?RVRENVlldCtVc3BJbzdmQXdtcnJZVDI3MjZoa1J2djREbWRFY1FPRVpMTWtz?=
 =?utf-8?B?RnN3RjJFTXMrTUZZcWtwa201RldkRUhsckl1b0JmL0dUM056aXN2cU5HdkVL?=
 =?utf-8?B?TUJQZXc3ZGk3bFZIR2VMc252cThvcEliMVpHQTFncUhwYVBDKzd4NWEzaUY2?=
 =?utf-8?B?cnRERjVJdmdjd09odDVNcmVBZjV6ZnVjbXFsTlE2dGp2N0ZOVE9QVm9xZnNo?=
 =?utf-8?B?KzdrMGNGeXVJalhoVDF6U29TN05vTWxUbkV0QUphUDUzRVBlYjFRVEtXc3By?=
 =?utf-8?B?TFBWUHdoaFZQWWVNK2pIRDk4K0g1K0JHSWdnZ0JPRnZpZkV4QU8zNzM3M3ZE?=
 =?utf-8?B?WGhIWDYwMStyd0JCK0EyNVBhby94RlRSUGk2VGZ0WmoxTlFjT0dwT3NnRTM1?=
 =?utf-8?Q?Q2BBFhLwS8rWl5BLcg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5388.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V25NQWYzQktuU2VMSFRHbUxsRDBrREZwNTkwT0dFTkdXYUNyc1FHMmtEa01i?=
 =?utf-8?B?MTRoRzBJVnFwTDErMURDVGlSRjd1dFBVZFNCbUROaDFoWDhhSGU1eE9VUGtE?=
 =?utf-8?B?bkFYWk5HdVRsYjdsZ1JlZDQreVhDMGlscHdzVGM1UTNzWEoxSnU2QWxCQ3ho?=
 =?utf-8?B?RVg3Rk1DT0puQ0lhN3hWMlQwa2tmU0QyOXVUVnVEeGtmMjRoaXoxV0RQK2RD?=
 =?utf-8?B?M3o3V0FjRnVzUzF3VVNlbGJTY2hpdGU1dXNXaHl6WVhuNjhhNVFvUVo5M1JQ?=
 =?utf-8?B?NlB0QjN5N3BvbmVOc2MwTW1VUk1TWktpQzRnMDIzeGF5OUwzZ2EyWDNxYlpz?=
 =?utf-8?B?c0I0WnJTdGVTdUhaMFBZMG5sMk9ZRFd2S2xhdXYyWC9JWllneWVEbWtRZHZG?=
 =?utf-8?B?WnBBTTFKZ2Y4Yk5IUHRTMnVuZXV0d0s5eWY1YTZWOWN6NlNqc1ZHcnNmRkZk?=
 =?utf-8?B?ZEZhTm9MaitJaU5YZ25vK3hmaERmNGNwOUZ4U01tdDh5YUs3aWZKTStEM0ZB?=
 =?utf-8?B?RzhFT0JXMjJ2U3VaL3J6d1owcGxMZkt4QysvOERQazlzU1JFWHF4MjJTMDU3?=
 =?utf-8?B?ZDFjTHZhaWJSRzRZSDJYbmgzNjFKTE5tblNEckNXS0l2cVlTUXlOeXNMaWto?=
 =?utf-8?B?ZDFqRnBYQTZ0NmdOaFZVODJNVTN6UzNvQ2JUWWs4OUpnRkUzREZNTkJQbkVO?=
 =?utf-8?B?VlQxQXhKRmJUYkVGMXRuSk9RSnZhdXFzclRvMkhqTTRoS0pJL0ZJbVozQWlj?=
 =?utf-8?B?T3prRE1VRVdEOXByazI3TmFLUzRGT1RFNVBhcS9tc09PMmU4RkpxM3BqanNI?=
 =?utf-8?B?TXJXMUNGbjRxTFVhQzBTNkxsNEFwaUlvZUdIQUR0a1ZoeHQwVWhaR1BpYzdh?=
 =?utf-8?B?WXkzQVRCUm5mTk5qRVpMVXVMR0dmWStEMW4vTmhTU0VKblNQcE1KZFBIVmpT?=
 =?utf-8?B?dkNKdUNBSlpTRkJwUlJqKzJvTlIzbXlpM2EzS01mSFV5MldJTlFGd3V6bUF3?=
 =?utf-8?B?bFI4c3lWdExGWWUrRkp5RjJwR1lEaHZkY3JONDgyNjZPY0l1dm1wQWhEL2J0?=
 =?utf-8?B?aG16TFpDVllYbDF5Y2ttM2oyL1QvalBBVEVsVlNJallkQUs4ZEZ0RGp2a1Zi?=
 =?utf-8?B?dmJYL0k0VWhSSmdNYitxQ0ZRbXM4T2hPUHN2QWM3WDdQYnlOanFyckRsYjJW?=
 =?utf-8?B?MHdQQjMyM2paN1JzajJtTlFnRnFtU2pYUjFSTWVsODlsdlRwODNnZXVzSjZx?=
 =?utf-8?B?WW15R2JHaGsyTHkxZFNKMmhIMnUvNjRsVTBoem90U2cyUXZmdDhqTDB5bTVE?=
 =?utf-8?B?Yy9oU1Rvd1FwS25jUjd5ZUdnSmxwaVNubG9LSFFmaTMzNnZqNFFxVDV2MndK?=
 =?utf-8?B?RGxoQkE5aUJRWTd3T0dqTjA4dVB4cW9jMWpXZSs2M1dGa2JDeW1PekxFbDlC?=
 =?utf-8?B?MFMzRDhxbVNKaU51UVlSQ2R4c3l5ZzVCSittb3dFNDI2Z2dvK21JdVBheDYz?=
 =?utf-8?B?Q1VRMC8wODlqWXNiUHZIVGtuTU5pQ3VVbHlYdXhCaHlnSUVMT0dPRGpPeWFZ?=
 =?utf-8?B?cUk0aHRIRXZSREhRdktWTFk2bUFsbDFTY3Vzdml0Q1RrSTZFUnhMZGNmU2xV?=
 =?utf-8?B?dUZkQXVyaHFjTzN1RmtmMysyOFlWVlNXMTVzMG5CUWFYQUNmTm9sOVFSN2ZT?=
 =?utf-8?B?Tk5JdDc0NWdHQjVwNFo2eGpOaHRYalU3U0txTU8zblg4UWlmc2RXUG9KZExo?=
 =?utf-8?B?YlZTN05vWjdha1JxQm5UekVJV1BKM0xGbVVySWxwdllrZEMwSnp2U1QrNmZS?=
 =?utf-8?B?dG9Kcm80bGNYVGZ3cVlCRlJPUlVhY29qTjJrU2V5VU5FODY3ZFhRUE9rV1lK?=
 =?utf-8?B?ZjBSZnJKRjZUbWJFckl1ZnZVaU93ekpIMWh0eU12VTJPdXk1dC8vanV1Vlhk?=
 =?utf-8?B?SnAzMFFEYW9jdU95aUlseituOGdpNjM1MmlUcmJzamdXaG5XSDFkdXhGTEdu?=
 =?utf-8?B?RldicDZZaVJuWCtNZGlURDRnV1pobnEzandIbVREN2tsZ0RoM1huQkVGUEJy?=
 =?utf-8?B?cGhUSlYrL2t4SVFTKzc1MU81YXl5bmNlaDRFcjBUT0Z0QVJlSUwzalhZQ29P?=
 =?utf-8?Q?Gs21BBtGCBLfvcA8KrpttR8NJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4574662-dcc2-4de1-6537-08dcb2b9ee14
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5388.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 06:11:21.4255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4j/HovMLwJp8U1IQJkh/Z003dOC9DSoraRa3dGh3Q/ev+o1XkPiOngY1qFuDJSpLq2sgCT5oKKadz7wCUShsiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6644

On 8/1/2024 23:41, Ma Ke wrote:
> In _emif_get_id(), of_get_address() may return NULL which is later
> dereferenced. Fix this bug by adding NULL check.
> 
> Found by code review.
> 
> Cc: stable@vger.kernel.org
> Fixes: 86a18ee21e5e ("EDAC, ti: Add support for TI keystone and DRA7xx EDAC")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
> Changes in v3:
> - added the patch operations omitted in PATCH v2 RESEND compared to PATCH 
> v2. Sorry for my oversight.
> Changes in v2:
> - added Cc stable line.
> ---
>  drivers/edac/ti_edac.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/edac/ti_edac.c b/drivers/edac/ti_edac.c
> index 29723c9592f7..6f3da8d99eab 100644
> --- a/drivers/edac/ti_edac.c
> +++ b/drivers/edac/ti_edac.c
> @@ -207,6 +207,9 @@ static int _emif_get_id(struct device_node *node)
>  	int my_id = 0;
>  
>  	addrp = of_get_address(node, 0, NULL, NULL);
> +	if (!addrp)
> +		return -EINVAL;
> +
>  	my_addr = (u32)of_translate_address(node, addrp);
>  
>  	for_each_matching_node(np, ti_edac_of_match) {
> @@ -214,6 +217,9 @@ static int _emif_get_id(struct device_node *node)
>  			continue;
>  
>  		addrp = of_get_address(np, 0, NULL, NULL);
> +		if (!addrp)
> +			return -EINVAL;
> +
>  		addr = (u32)of_translate_address(np, addrp);
>  
>  		edac_printk(KERN_INFO, EDAC_MOD_NAME,

In [1], you are fixing possible NULL pointer dereferences arising from
of_get_address() and of_translate_address()
In this patch, however, you are only attempting to fix possible NULL
pointer dereferences arising from of_get_address().
Any reason why of_translate_address() doesn't need to be fixed here?

Also, since [1] and this patch are addressing possible NULL pointer
dereferences from similar functions, you may want to club them
together as a single patchset. Makes its easier for people to review.

[1]: https://lore.kernel.org/linux-edac/7021a08b-ba75-4d16-a71f-b38e48df5af3@amd.com/T/#t

-- 
Thanks,
Avadhut Naik


