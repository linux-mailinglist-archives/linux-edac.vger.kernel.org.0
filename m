Return-Path: <linux-edac+bounces-1468-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9756B92B015
	for <lists+linux-edac@lfdr.de>; Tue,  9 Jul 2024 08:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5426F282880
	for <lists+linux-edac@lfdr.de>; Tue,  9 Jul 2024 06:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C55D13A24B;
	Tue,  9 Jul 2024 06:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CL5gzEJg"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C6D7D07F;
	Tue,  9 Jul 2024 06:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720506561; cv=fail; b=n6KTFmuAf0sJ41bYC63JESGRm9ei6qFQN4jfXmf1YN1nKPrUZvHLbG5Siu1ZquQ4fwl0Yg7vmxlMPR4o+qvRqZeAGrWjDWWlF462LivwLutRoBIKzYI9H+lJoyNBZjtHoQMSk7FSqvVLWIsaChSPoLlfXdWrjbDW9UY7kW6SM9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720506561; c=relaxed/simple;
	bh=+4fchTMypagWoLS+t7WnBDbzXLY4rqBCCcdA/hryh/M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IDzEQ6HPYHAd/d0SLRscAHGR1D+8ao+Zdp9FOao8r4eQ1Gx+liZXSV9cH5y2Up+xClrTMZQNL8PhVxM0S9uSFwHcdICQ+oGMDzLWUzYJpX4SEzfUqliAWJSLRlf0o51MRlytshrxXpoVOqQLi2IiXnGclCXbMNc+E4/zg4anarU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CL5gzEJg; arc=fail smtp.client-ip=40.107.237.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ga2aj1B3iz/lsbzV5pELmc/49AmoFbr+V5TdSf/9raAnrkbJvZwVYvb1EyRpdv5ouW/mjIxssABZsuatRiuUxUQPfpcRjRMkVdh3sTCq6lHVDRh5I8iCElUyPYZuIunJCP3tKnfGZKbORp0L0AWEhJh+wPu6Z8luSr5e+RKHR8DkYJjcxG/It6ZueH5xrk5bcc9HjN/5qS/8jmQKx6L7mPaQRu02hG86FXy0iBfyPRe32zCJmPdwk6jF/8h2HjVk1CXFfgUBElcWKUpSU02ffTlvdB6w2zhSJjmhFKt8tXth3SpgGICdBrxUkLpdwDYVEHCwuzZWOdNV62LZCKNyYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qGAYBJFSp6qXIjFYDCJcHuZHDyhb3nkyVfOXvI+RS8M=;
 b=a1iFffUZC1MosnxyquZUZ1e+K07Gmr7CdGrpJtLce+zs04KEO+5QCnKqLFKHumenl4suC3gnRmrOruZFl/XqO2N8nYbwKuLxD0eYnaDsjAqka8ZxtgG3qFuB/EH8aKnvvMWM+vEFKQbZ+pAmZLdIozsQbh2Gt3jzH7nJ3PBFyTcMy3VA0n4AKDJOYdghb7j0YUx+IVhgLD+1lAAWw+OZ4nrkrn3ZlBBTJfG4h4Njr/AJeaIYImvPfM1AkcumYrnt0rQ5esmdS8ZVzHpqsNUkKVtOQah/77Mu890zud8q3fr/80aeBgObOg41OXaAxfGvtcz1VK9fgn+eU5Za3iDO6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGAYBJFSp6qXIjFYDCJcHuZHDyhb3nkyVfOXvI+RS8M=;
 b=CL5gzEJgtyAvpxqopQfxVwJIQ+kJSWyQ6gu3kmP1zADDmCBRLN8jeAxjLs5YRbUXwHhggVPha5ooXMRa4URpDFfrR8HIEtqytJO501DkHR3TX8015Kx+v3C/u7ESFJQs4WI9dOshp8i1MDrSzduqEs7uXPV04mhmFXLezA5/+yk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14)
 by MW4PR12MB6753.namprd12.prod.outlook.com (2603:10b6:303:1ec::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.30; Tue, 9 Jul
 2024 06:29:16 +0000
Received: from CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::bdb:41da:3604:a469]) by CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::bdb:41da:3604:a469%7]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 06:29:16 +0000
Message-ID: <efa65048-e176-4bad-aac8-0147d26b1362@amd.com>
Date: Tue, 9 Jul 2024 01:29:13 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] EDAC/mce_amd: Add support for FRU Text in MCA
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: Avadhut Naik <avadhut.naik@amd.com>, x86@kernel.org,
 linux-edac@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 tony.luck@intel.com, rafael@kernel.org, tglx@linutronix.de,
 mingo@redhat.com, rostedt@goodmis.org, lenb@kernel.org, mchehab@kernel.org,
 james.morse@arm.com, airlied@gmail.com, yazen.ghannam@amd.com,
 john.allen@amd.com
References: <20240625195624.2565741-1-avadhut.naik@amd.com>
 <20240625195624.2565741-5-avadhut.naik@amd.com>
 <20240626120429.GQZnwDzQ47y1fOlFTp@fat_crate.local>
 <ff9efb14-f3e5-4c4e-8285-7da853e6ffb7@amd.com>
 <20240626182013.GEZnxb3TpU6VgROX8g@fat_crate.local>
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <20240626182013.GEZnxb3TpU6VgROX8g@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0033.namprd05.prod.outlook.com
 (2603:10b6:803:40::46) To CH3PR12MB8403.namprd12.prod.outlook.com
 (2603:10b6:610:133::14)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8403:EE_|MW4PR12MB6753:EE_
X-MS-Office365-Filtering-Correlation-Id: 14600452-35f1-4d49-5011-08dc9fe07517
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0w0V21PeTNxR1pYdDF2dU9yU2M2QnZydXZ4WnhYYnFuY0Q4cjlDN1JacnJY?=
 =?utf-8?B?T0ZvcnUrRlpEOU5vVEtHc0UvQ1k2dXlJMmQ5eTdveGxLQVRWa2prdzR3OHp0?=
 =?utf-8?B?UWhHdkZhQUxVZHJyK1E4QjcxRUUyVEZRKzdjamY3YlNVYWJVdFVIOW5zMkNi?=
 =?utf-8?B?VTQyQ3JtV3IwQ0VmK0VUdER2TkpLd3pseFcyaDJaWWhRU0NBYlRvSE5iNnM0?=
 =?utf-8?B?c21pUUkwM3JQVlVFbU9xSHRPY0s1QzJaYk53eXJzb0dZblNZUC9jMW9MalpB?=
 =?utf-8?B?WS83WU84Y0RiSmxNaTlEVDdQSTF3U0dDVHRnZEZRdjczNTl5YTdBNHpyTDVG?=
 =?utf-8?B?VmlJVVBsQUNjZWt6eFNBZWI4TEV4TVA4emdQK3pob1VGUW1vVTFvSXg2bFBM?=
 =?utf-8?B?TzJHOHRrdDJTZ08xMytocEhXdTF3Y2RaMnRsbjFvL1FmMU03bS82ZkZETi92?=
 =?utf-8?B?U0drMjJ0MGVQL2plcHdUc2JpZzJ0R2F3VENPaE00a1Q0eUxJQ1luV3JMT0lN?=
 =?utf-8?B?S1V5WTc5d1dIMUpXNDY1K29IQXZCZXRiay9KdTBFQTZrVUFSTjdzSGlHMnM0?=
 =?utf-8?B?cGtmazZtV0d0Y1U0MndYUkFIbVE0YUNUSWd6ZmtTZmRDS240VTlDMDZRcitk?=
 =?utf-8?B?M3BMcUdsaWVuWG90SGptRDRWS0VRZi9KQWg4b0ZMVk5zTFM1dXYwbkUvLzV0?=
 =?utf-8?B?QmQwVm9zcnBISHltVXJMR1Z5bVMxUEpMMlhyZGFGV0NqclpqSTJqM29Pd0Yx?=
 =?utf-8?B?Y0NwdTE3ZFdDcnZCWkxoZy96RVZqNFVtZ2d3Rk9JYTlwcERmMjlmMnlMMkg3?=
 =?utf-8?B?UnZMNTBmQzVxOXhKaVZxdFhLcTRMMnhuWnpDNUxnNFB4RXp6N0N6NkU1UERz?=
 =?utf-8?B?Y05qNnZ3SjQ1K0VncGwxMDQ3cGpvQXdSRGZpeXdUTWJOR3ZwbGZyVFQ1YWNV?=
 =?utf-8?B?Mm9ManE5VzFhVGs3RUcyR0Rzcm1tdHZEcTloYXZFa0pQQmFGTDBkekFOSUZE?=
 =?utf-8?B?RlpoWlZBS3A2SjNpbXZWWG1QUUZiWUEvVGNYS1Q5Z1BGNlhaN1JYc3NxRkpz?=
 =?utf-8?B?TGhIUUNDdzZqTkZ1WVNrMENvMWEybWtmNFhlRTRaN1RlSFlzaU1GeE1Bd3Er?=
 =?utf-8?B?WTdlSStQcW45a25CODZNdmRYYWlTaGw0YkN5U0lmaHBHSXV2R29QNTlIYWdI?=
 =?utf-8?B?TjdJR2dKVEJoRVhtTUF4VHV3amtqd2s4Yi9oVndlem90elFleDVzQkxXNmtK?=
 =?utf-8?B?akdiK1ZaY2QyQ3JZYWQyRnJFZDRDWmgyTmoxa2VrcGh1dmhoOG5INU4xcHBY?=
 =?utf-8?B?NGdoK0V6MFNVYmx4U3YzOWZJNjI3dDczM0JFNFlzSkJXa1FQQmY5eHNnY2N4?=
 =?utf-8?B?MlJDU1d3OVB0c0xwTFFIOXRlVzdrRHplTThMOFR4VDBiS002dlE4bGtJQit0?=
 =?utf-8?B?RUlUcklkeXA1VHhOMi85VmRjTlFZbFRpMU1jTlN3M29ObndEWW1jOTBnQ09w?=
 =?utf-8?B?SWdvTGJKK0Q2MWVSYzFHNjNTYVJuZEd6SW5QR056UzVvbkJWRTczVXJ3NVR5?=
 =?utf-8?B?ZWkwRG8yeHJKUy9FZkt5L1hyb2JJNjIwRE5Hc2RjR3Y4Q2lDUHN4c3lRSGxP?=
 =?utf-8?B?Uk1HSzJWcHdDQ3NQWjRKNThoOGxIbnRHT0RQQURmSnNNaDYzTTBoRDNCRHFJ?=
 =?utf-8?B?NFRIU3JzQmQ4aUNMNkV1Nmpxb3QyMWVEYTVUY0syTUZZYUlsdUJ6S0FhN0o4?=
 =?utf-8?B?MUZ1UTJ5YU5FampLV0RxcEw5SFArMWdxTWJPZ2lzUVVwdEdXdURCNjNxSHFM?=
 =?utf-8?B?T240T2ZVc2VXdEgxVmRadz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8403.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NTNMQU4vVXBUbWFvWEpBTjVuQ0lkZUpLSDFzUHNsRE5QbmUxYUt1Wm1nTTEx?=
 =?utf-8?B?YW5DNCtLWlFQdTBrQzg2N0UyeDU1MitVbUZwYnZDU2NYSUhjanZkMHpzd09v?=
 =?utf-8?B?c2ZnbERtR3B1TFhNQWhrbmRYZjRyUXJIcmtoN1d4akw3Um56MFMra0hXZmgw?=
 =?utf-8?B?WUpCa1BjQXoyYTVzN2htNXk2ZWxFRXRvRkM4WVExbjR6RFZVYUFjWU9JZC8r?=
 =?utf-8?B?dEh5ODdZOE9PblZQbGVrV0tsMlFydzFQNjlvMExtQkJnWS9xM3ZWOTdad1JZ?=
 =?utf-8?B?RDVRRTQvM3Jmc2ZxcUhFdTBHWHZmTFFjc0VSZ0JGOEg0Y3MzdE9jM0VxR2J4?=
 =?utf-8?B?SklPeVBzUVV5QkEzallYdkc0cHA0bmRtQjEvamhiY21ENU1kMEF3eElQelpy?=
 =?utf-8?B?dmo5OTJ3LzFvczgxU2hsRlJRZkFBVEFZUXJ3TjIxcEtLaUdPRFNzeklzVG9Y?=
 =?utf-8?B?cnhvKy9ZUXVqY29VRnFzOFVJekV1TkllWXJOY095ZFZYZlQyNTdVR0tQWjlm?=
 =?utf-8?B?NDVhQ3lPbXlUbGcyUVR6WTBVaTFPaGFtWk9jRzltU1h3NjdqMy81Z2ZLWXJD?=
 =?utf-8?B?RG5LSnRpN1pFeDR1U2svSjVYOU1qNmlncW1PamhLUXRYSC9lcTcxQ3RINE5k?=
 =?utf-8?B?UGRyYWhDa1JNNDFtdVY1WUY4WmJsOWdoc085MVRhbXNwTmZmNWc0bmxVNVJu?=
 =?utf-8?B?SDQvMDBHOEZlUE1saDlsWis3YXE5cWVHVjVldVpRWUVxcGI0N05ET2s0V1U1?=
 =?utf-8?B?TFdobW5PYmxHVmUxNUhiSE9PaEh5OW1tek0yRE5xQzlCN25ENUFjajVLbkdX?=
 =?utf-8?B?eTNqeVhjQTR5TU42SFI4YlBCVTlINEllaUJtYWhtSnE4Qm8ybWNWM1haRG1h?=
 =?utf-8?B?VDZpUjAzT1p3enM1bE9kQUV6ODhsUnVuVGEwQm5JVHJLdzRkODNJZ2QrNU9m?=
 =?utf-8?B?cENsRnhHNlk4ekZSdzVLOG5kTUNxSllhbkJuRXVxV2lwanAvTE1reWliQjZS?=
 =?utf-8?B?anZQRFJ3N3dmZHVTbzRGMEFEcDlNUUxaclJkTi9va0x5cUJmek94TUpFK3Qy?=
 =?utf-8?B?RWp2dllaZFhabjFUdFJhY1BGQklMQ0FPQ3RkUmNnejdxK0JDZWtOaU1QYmNq?=
 =?utf-8?B?S1gzVXkzeVRpc2tKZG5jQnBHSHdUVlh0cEpUVHB3bkVQT1B6RXRzL3Z3WVpD?=
 =?utf-8?B?bG9tZG82ZWhpWlZUNDhudWNta0o4Q2luNnlEZDN0WFBEYnRlbmtsTU1mWFRv?=
 =?utf-8?B?N1FIeFlLYkgvZm9RVDVRbHlIeklub2M4ajM1SnVwd2lvL25Teko0N1o0OHp2?=
 =?utf-8?B?cUwxcWk1Zi9YZmkwbHZDMHh4MjYvSjM2U3k2VzhBeGNLZnNySWRYcjNoREM0?=
 =?utf-8?B?OHp1M00rMlBZTDFsZUM2VUhtSWNabHBaQXZHQk4ydGtNb1E0ZkpuUTU5bzFk?=
 =?utf-8?B?UXFjZ2E4QWJUdUwxeUxhengwRjk0OWc1N243YzNQN01EZEwrc0s0MXMwVWJz?=
 =?utf-8?B?UzdUUzJDU3BFL09LNW81N3NLV3ljeWlaNHlxck1lWG1GSVgwOTZ4TWRZdS9q?=
 =?utf-8?B?QzBSZjNOeHI1akEyU1hCb3FJZEZHWjRFNGhlWm1FMSswZW1GQnNpc0NZNDQ5?=
 =?utf-8?B?bFpUM0YwQWM0bHlMcnh0TmR5VHZlUWJzVmN0TGlxaEZoRy9lZ1RDb2VvOFhi?=
 =?utf-8?B?L3FtUmFvSTA0eDZQS1NzbVh6Tkt1S0dkZEVlVmxiM1MzeVoyRjBJa2NxREFp?=
 =?utf-8?B?bS9yWHZoN2FBc2RhcHRKMUV2eWtZTVBJWWRLbHh6cHZDUlc4S0ZkMkI2UHhZ?=
 =?utf-8?B?WEc0QjBEU1A0M3ZtTWhQQ3pidisxdUlBSGgxOHc5SjFWK0RDbHk1UGpJdERJ?=
 =?utf-8?B?QTB2WkpwejJWdks5SVEzbWptVzhxQlIzcWxIamw0eEhJSWxZcXZPVXUyWHZF?=
 =?utf-8?B?dmpzZUJ1dVVOZGRoWVlhWWFMR2V3OWhTSjAyOFJDaG54NzZkYU1IS1lJaW03?=
 =?utf-8?B?VGRZS2N3WXh6T1lhYmYxMTBRM2FBdzk3UEV5ZlBNN2FKMlFxMzZ3Q2hxdWZD?=
 =?utf-8?B?T2tTbnZmQ2paQW4zcDNQdHlaZVNjSjFhUGl2U0U0aHowTHNSc0svYUl3Y1g2?=
 =?utf-8?Q?GCnF3F9jAcYQfrivrLHuPeW+W?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14600452-35f1-4d49-5011-08dc9fe07517
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8403.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 06:29:16.7268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NGETzPQ9zo15Uvd0d9AUPzqRHOxYdZS7tsR5HcM6GL/TVBf1tHdAM3eTXjV3QhuQp5ONTDq6qlTbHVK8b5522g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6753



On 6/26/2024 13:20, Borislav Petkov wrote:
> On Wed, Jun 26, 2024 at 01:00:30PM -0500, Naik, Avadhut wrote:
>>>
>>> Why are you clearing it if you're overwriting it immediately?
>>>
>> Since its a local variable, wanted to ensure that the memory is zeroed out to prevent
>> any issues with the %s specifier, used later on.
> 
> What issues?
> 
Its a locally defined string of 17 bytes. We are doing memcpy() into the first 16 bytes.
Don't we need to ensure that it is NULL-terminated to prevent undefined behavior when its
given to pr_emerg()? Am I missing something here?

>> Would you recommend removing that and using initializer instead for the string?
> 
> I'd recommend looking at what the code does and then really thinking whether
> that makes any sense.
> 

-- 
Thanks,
Avadhut Naik

