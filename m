Return-Path: <linux-edac+bounces-5548-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA438CA457A
	for <lists+linux-edac@lfdr.de>; Thu, 04 Dec 2025 16:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0E11D300578B
	for <lists+linux-edac@lfdr.de>; Thu,  4 Dec 2025 15:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D74D2D879C;
	Thu,  4 Dec 2025 15:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yihDKN3h"
X-Original-To: linux-edac@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013024.outbound.protection.outlook.com [40.93.201.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F702EC097;
	Thu,  4 Dec 2025 15:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764863494; cv=fail; b=q2Gjjho8UUtqperFwXthXVfc76+hVt8zlA+T/ZBJ4xvrEPduZF+/9nR9GKUZwqU/zHrdgvLjrgEph1MDOBVfDjl9sMTFGUWRzwvmHMT6xk/0lh8dZFUvQS8++587p6GZ3K88Uan0mdDmlDg3gEmcHGk65OvD1CJoTRd69vBZW44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764863494; c=relaxed/simple;
	bh=iD1q6Bqk9ZeQceDaeZKPm0aVcmr7tmsaZPDnA48amiE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ogdjc4+j15bagarAdp66BKUGz1yLUaww8BhZz5WgaE64ygsuoUfyXcGV2C9fm5Bw/jUIY0jzejAkm2sXYl7+VHPqfnk213O3nlyLHaJM0Ws+gCQASPvUCxn3plexPeGtbiZMwwNVPbJWHO7i3flQ1355DCmzh9Yd6kLbUQKV4fs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yihDKN3h; arc=fail smtp.client-ip=40.93.201.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cckVfrtLZoDKZN5Te2Nq+bRvoywF1/O3mhKgPf9kC8n0dI0bqr38xM77JCr+AXee8HVJDBU9k+guzNvj8rIIdrzqLRyu7J3+52iQXcRxJbcwvURAEH+DJ/XswOcAJSXAWXr0UWYLTPd2lTn7QcBkpnEsZQAhPW1IxEX2vSWfn3LAy+KQWtzxFvigdcx1JHgjxLm8vJBYA0TUyW3pf4x0avKSDPXi5C+yYM+luOtiBmj8OPoYQvhJgHYVdd5xI6uqhmm/gr3K24Jxp+R/d5ttYpxV6FjulYehtmZDsdijt/hs4VpLK3c7EUJrgVFfd1rwsFBE7/qBkCaq2HqDOHEJig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjkZRZasbyww40Hn+i/HbJyrvvG+AeXuGr2xJbvCIj4=;
 b=TgkjXyF5tyaywhLVPJpPxmI64neYIXpIwfszSJYVwDGnAVoE0SMkDHHjTczH81SggkakwWDrRGipoKeOOY64I4Q1jgkXD59VRdItATJhndnzLBBZO/BCOCr7mjn0ieoSYrBcAStWIU0SmmCKIwtBxGdU1XzOQKqjr2bcnGnoxV3GvIAY7c7JmS/AY3LVhgkvkaL7ecjkyDR4FC0nWcEKnMUHQO0fS53BXp4SlwHL55YgHAxPO+CIfZHZs5xsOr/J5I81u+VVd29AtWWuSl3bg40rSUQdEhusd9mNb/JmmUw6a3nAyJ/EPII15cASWeJs3Ee6hiOwU5PmZ3ZZHl5+YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjkZRZasbyww40Hn+i/HbJyrvvG+AeXuGr2xJbvCIj4=;
 b=yihDKN3hYehqu1MhmzH+jiTU0sO+DhDbZVyuW3OmkHbIJOLaHLp6pNIAArE5OjGJkKjefKV2WMVvkrCweWEBiVBVC/k5pMv3dpYvGx1QZ1Ur7bxHskALotcZBHehIyoGT9+q/rWNRQH2+DbPVGfJcs4vmDQXIS3fjrc7zJPzPT0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY3PR12MB9680.namprd12.prod.outlook.com (2603:10b6:930:100::10)
 by SA3PR12MB9178.namprd12.prod.outlook.com (2603:10b6:806:396::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.11; Thu, 4 Dec
 2025 15:51:26 +0000
Received: from CY3PR12MB9680.namprd12.prod.outlook.com
 ([fe80::1614:533a:8d3:b479]) by CY3PR12MB9680.namprd12.prod.outlook.com
 ([fe80::1614:533a:8d3:b479%5]) with mapi id 15.20.9366.012; Thu, 4 Dec 2025
 15:51:26 +0000
Message-ID: <17d7baeb-4864-4894-aa92-978af300fce4@amd.com>
Date: Thu, 4 Dec 2025 09:51:24 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] EDAC/amd64: avoid -Wformat-security warning
To: Arnd Bergmann <arnd@kernel.org>, Yazen Ghannam <yazen.ghannam@amd.com>,
 Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
 Avadhut Naik <avadhut.naik@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>,
 Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Thorsten Blum <thorsten.blum@linux.dev>,
 Mario Limonciello <mario.limonciello@amd.com>, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251204100231.1034557-1-arnd@kernel.org>
Content-Language: en-US
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <20251204100231.1034557-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR11CA0015.namprd11.prod.outlook.com
 (2603:10b6:806:6e::20) To CY3PR12MB9680.namprd12.prod.outlook.com
 (2603:10b6:930:100::10)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY3PR12MB9680:EE_|SA3PR12MB9178:EE_
X-MS-Office365-Filtering-Correlation-Id: 13113aaf-5d88-4102-9d53-08de334cfba9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RlFCRXkrelVXdG1JWDR5RzZ2QmVrY0o4YndBdXloUUJmR1EvUVFSbDBhVnRW?=
 =?utf-8?B?bFFPNUEvYnBQSW5RQUVLaU15S2phV1l1U1NzU0RHSXp4VTVzVFBhSHNTMVlG?=
 =?utf-8?B?UGxrRkFZY0p1QVVtdzRrdDJ0MUxoZ1FtVVRjakJ5dHZkZHRuM3UxL0Z0VFVS?=
 =?utf-8?B?dE5iZ0xxZFFIS2pGWXNuOHFhRVlwRHhFKzNOT2R3d3NxaTk1WkVVTlo3enRB?=
 =?utf-8?B?YXVuNS92R2krcUdKcDZ1eEVlbUd0Uk5zSjIvLzRtbEJabldaK0l3eWVpZ2hp?=
 =?utf-8?B?bEh6ZmVjdzArY1ZxV1c1WUsrQlpnc2VzYUw5aDlBVHZacUhYaTMvWS9WMnV2?=
 =?utf-8?B?VU1lbS9KUXAvcnorN05WdHJ0emd2Smx1amIycGJaTDhXNk9QMkI1R1d0MDRY?=
 =?utf-8?B?ckYzcStvQXp4MXRCMlFIZFo2VVF3NjE3VzYvaVhVeWlOcThKaEFrMDNvL2Jn?=
 =?utf-8?B?NlpxYzRhYzRhdWlucW54Qm5HRHJnZ1VvaW5WWWpjSy9WMGlxRTd6ZXRHWlFS?=
 =?utf-8?B?a0hjR081VjdFR2NXZ29oZ2NkbUhDbkZRQ2lvb2hXTHBRallQQVhtdHVWZUZu?=
 =?utf-8?B?alZXajlCdEV0ZTlGL3pSM1crVHk1Q1I2ZXJuTEZaS0t1MW1MNWVvN0xOVlFw?=
 =?utf-8?B?RzZPTjJkTEthZjJmMFp0Z29rMThFRVVzZzFKNU9PVWxIKzFQWUVFWUgzTFlN?=
 =?utf-8?B?WHN2WHkvZFdlN2c2UjByd3dGMWFxcmx6NGU2UEYyRCs2VE1Tem9iYXQ3OHVr?=
 =?utf-8?B?SVovbGFGS2VWaTdvdHdYTWJhVkJnS0k3aHBNRHh4c1oycDNFblYvanBCVmpF?=
 =?utf-8?B?K0JoV1drM1VtRnlFemcxaHgwalNyanFtVW43dFU2NGVZdCtXOTdEUlNLTWZl?=
 =?utf-8?B?cGRvZGFwV3V2N0NoV24rZ2IwMEtkclc1UElEMUhEUzdlV1lnSHpDV1RidkNj?=
 =?utf-8?B?SDZMV2plTTdaUWlwTUMrakN4OTJMUnh3TFpCdGpHNE44NEFCQnNEeGtZTHVw?=
 =?utf-8?B?OEhNNHV2a2JLU1NZWHNoY3FyYUpNYTcrNnEwVDFzTlhWU05DcDBPQWtHL2F4?=
 =?utf-8?B?K0diQVkrN0JBMGJKbFIzK2hUNE1CcEx6T2t2Z21HZ0xhUkJRdFlKckpEM1Jm?=
 =?utf-8?B?Nk1MbHo0L2RhSmV3VlRud3BWQmlwOEJLSHprYlU1M1ZnanlhbE1rN3FTK0Vj?=
 =?utf-8?B?OEhDNUY2SW85eFFYa2gxcmRiTEUrWDFFODZnZCt2SW9QN0x6aFVabHNxRFo4?=
 =?utf-8?B?ODdIQWFKbXdkeTlYMUh1bDhkTzJ3anR5SFlqY29wb1dtZGRiaDFYMDI5LzF6?=
 =?utf-8?B?N011TGI5Z2NYNnpGdW1CV3pxT2dwQlVsaG1FVGF5MjNabWh4OVJ4dzZiZ29j?=
 =?utf-8?B?RERiNnFxRXpIWkxTSkpkaFluN1c1OG40QmZUdiszdmJhekdndUZ6UHNmYkVV?=
 =?utf-8?B?MG9EUnJKOHhhRjQ1ejltclhoUUxwL1pJc1JPMGZsZHF5dnNQRHUzd2o4Lzdj?=
 =?utf-8?B?bFdZR3EyamxqRVozWVVxWkQvZkhTZkl3KzRDckJMZzMrUWtDb2xySmtROHFn?=
 =?utf-8?B?ZVNTd2R4ZjEzdHlZb0ovK2c3L1lhNVJHQVgwYUd5QXRBL2VXYkE1UkVpRzlZ?=
 =?utf-8?B?QmRKWVMrRWJHdFFUOFhBbmlGRUdjajU5Qis2dEFNd0NPeXJBek40d29uR1B0?=
 =?utf-8?B?RXluUXdIallmZmpuekd5T1hoczAwdUlQb0FXK1hWRFJrdUlPbUlyUEx1MEJB?=
 =?utf-8?B?ZjcrbzdlV1d0VG92ak85cU5vd2IxenMwaDNSV1dRTmF0U1hWUFNXd3M3SUZ1?=
 =?utf-8?B?eVVlOWh3bnM5SFJlUVhiR2FyWXJqeUFpWDBFVElJaTFlSmxtOW9HZDRuZ2Uy?=
 =?utf-8?B?cTNJRGVTVThpYVYyWTE0ZXA4eW13Um1aQXE3Vi9aNGNOUzdiUHZOZklJVDY1?=
 =?utf-8?Q?kH6qYUrty7nqWvk9WzjXB8yRcE1HoGGy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY3PR12MB9680.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0loM0RaNk94UjJjY2JCdXJ2b0hHd3ZxS0F4NUpkakUzQzh3M2dnUkpPOGcv?=
 =?utf-8?B?ODlEVExwUFUxQnlMMG5Wbm1wRG1tMXdqYm53RXd3YnhQK1dqT2dtd2xjV2Ft?=
 =?utf-8?B?c2VqckRPaU9mbWJtZVZsbjFUTXlyeFVadmtqVzVleERLenFXL1RDVlF3bjU5?=
 =?utf-8?B?NGhCTVZ3RzZiRmFLNUtkdk5HWC9zb3Uxd2JwQ1FXZnZ0Z2E4QzhtT08yLy9o?=
 =?utf-8?B?R0Y3OHc2amxoTTJQQmh5RFFQZmF2elBZOTl2TWRhMUM3eHptdHgyK3BRclJx?=
 =?utf-8?B?YnY4MkRDRnFFbTVyQ3NBNWdvWUFacytIK3BtbzlkYUQ2d3hGYkIwVU9VMUlw?=
 =?utf-8?B?UWE5ek9qR3JqdFM3N1JqTHFUNTJhNnJQNGlGT0t5SmViR0VuRU1tNDNlUGxu?=
 =?utf-8?B?RFc2eVVWMUFrUUpNaVduNlZ1WWlkTUpqclFLTkVNRHd2VzdFUjNacUFJWjc5?=
 =?utf-8?B?alRLVGxNYUFXQmhNbXhvSGVBendpanlGeENTOGFpVkpOQmtBVkU3M0JrTzNw?=
 =?utf-8?B?QjhSSys0d3o3bzJKK3VqdHBoNlQ2RTdiZDBXTjJiYllYcWtBWGgzMUZnaFY2?=
 =?utf-8?B?a0kzMCtCa2ZYSUZZcW9lN2oyclI1S0QrQ3p4Ry83dWs5RTQvRGpET2lWVlZ1?=
 =?utf-8?B?dXZJWEc2MXlRT2kwdVAyamI4UDFwTnNVTmNDZ1YybW80OXZRRmRWOEZEYWJ1?=
 =?utf-8?B?ZC9vNndhY3A5dDFsNHArVldURDVNSjJReE5ScXNrNkxMclZxMG1maWZVWTV4?=
 =?utf-8?B?SEVoTDBYeU9lYnpsMTFGMHpGYnVoZ0NqT3hSalBRQVI3N3FSbC9Hd1UvcWJ4?=
 =?utf-8?B?SU5YRmFOd25CL2d1TU9UTi9Ma1RzR0dUejhHUjg1REVXaXlZbTVvRVBQcElH?=
 =?utf-8?B?aTE4OTF3cHFMemVtcHZqNFcvckRrSXluQUdhejBaUmhyakdXN0FaS2s5aERM?=
 =?utf-8?B?SjZVTXlKYlIyK3BZdXU0MWtVTGhUZEpZQjJBbjhYNzk4VlNsV2xhakNDeks4?=
 =?utf-8?B?dTRQN2hsOVFlOGNKVUZ5ZkdMWmpOQmxQdGV6anFzMlMwaTRZczBKaitWMWdp?=
 =?utf-8?B?eW03dTdRMnFuWVBGUkEvWVBqN2wyYzE2Y0ZwU3BHTjhuSVJLSWxHVmNlNTI3?=
 =?utf-8?B?Y2x3Z095TzAwK3N2ZVNZVnhKMHpzVVJxUWQydGdRdjc0TkV1N0FXMURZdWJX?=
 =?utf-8?B?Z1BJRGlzODFDSXBWTXl2UGFxcGtMclFiSTFLbkE2ak1Wa3V1Ymt4WU1IRTNB?=
 =?utf-8?B?V3lka3pIaisxZVBjaGRicWtPTDNBM3IyWnh2Wk5DM2FwbWZkUDZGd0NwNENu?=
 =?utf-8?B?dEl0NGYrc240ekpZT1lzbElnUW11STdBTWtndnFWa1kxb3M3ZEJORTFiNmVJ?=
 =?utf-8?B?WEdnK0paczJBZnMwQnF6MU9xeXBiVWVGeWtOTS81Qzd2a0lybmVZUTBZZUNL?=
 =?utf-8?B?R3dTSS9hTkVGUTNXRlk3M3JVSk41U2puRmRrcUhsWmhRNlVHU1ZwQUw4RTJ5?=
 =?utf-8?B?cFRQZ05tTXk1QkJUNVlkYmQzQm5uQnc2NHhuWkI2OTYySjZFK0YybnM1emph?=
 =?utf-8?B?WTZZU3NNd1JJbHQvRS9pcjlHNWR1VWpjSWsvbzRHMkdtMTFoODlreFJybGY2?=
 =?utf-8?B?SEJzUWxIRkdwdnJPb1J4MGV4ZjhuTlo4eVlFdERseDVxdHJ4QUJLSkF6NmJ0?=
 =?utf-8?B?ZmMyMmo5WDBJVWhsYks1MGwrZWRUTzZYZm9vRUVPN3F6TmRxOTNmNE9BMUVq?=
 =?utf-8?B?eTVJZ1BjVHJzNlp3eCt3MlhhWXRNY01EQy9RcWdoN1VLRTFpUDRnOFpzQVk1?=
 =?utf-8?B?UkZ2L0RMNVpJYXFacU5RN2ZIOXhDYXZEU0J5Njh1dVpWTllUWk55ZThtalJx?=
 =?utf-8?B?N0V0VUdjazYxTkp1R2c3TURNZHpRQVNmQUhtTlRUaGZUU0s3VE1SQ0tmcEhF?=
 =?utf-8?B?bXkybVpDT29nY3hyMHhIOXJLQjVpZWNGZjExNG9BVUVFaXptMEpoMUpRaTlJ?=
 =?utf-8?B?TzFuTGZ3Sm5YTjFBSjQ1ZUhtaUd2dEx4TGZiK3NBdkwwKzZ2ai9NQzdXMEQ1?=
 =?utf-8?B?a1BCaFAxUUF2NGtjS2lMYlZseWR6dkpWYXRleUplSTFmRVkvcFEzL3ZBQjQw?=
 =?utf-8?Q?54T3h80eDAQcBH9C7WKKY/maD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13113aaf-5d88-4102-9d53-08de334cfba9
X-MS-Exchange-CrossTenant-AuthSource: CY3PR12MB9680.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 15:51:26.7546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Xw03ciJtHh1TBcCJIIpeyCC7KBQJNGcGs9sGYv0MJYaT/vNbcggeCpAOg8KjSbqP9k7lJHsxb8yHNUalp6Fnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9178



On 12/4/2025 04:02, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Using a variable as a format string causes a (default-disabled) warning:
> 
> drivers/edac/amd64_edac.c: In function 'per_family_init':
> drivers/edac/amd64_edac.c:3914:17: error: format not a string literal and no format arguments [-Werror=format-security]
>  3914 |                 scnprintf(pvt->ctl_name, sizeof(pvt->ctl_name), tmp_name);
>       |                 ^~~~~~~~~
> 
> The code here is safe, but in order to enable the warning by default in
> the future, change this instance to pass the name indirectly.
> 
> Fixes: e9abd990aefd ("EDAC/amd64: Generate ctl_name string at runtime")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/edac/amd64_edac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index 2391f3469961..63fca0ee2c23 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -3911,7 +3911,7 @@ static int per_family_init(struct amd64_pvt *pvt)
>  	}
>  
>  	if (tmp_name)
> -		scnprintf(pvt->ctl_name, sizeof(pvt->ctl_name), tmp_name);
> +		scnprintf(pvt->ctl_name, sizeof(pvt->ctl_name), "%s", tmp_name);
>  	else
>  		scnprintf(pvt->ctl_name, sizeof(pvt->ctl_name), "F%02Xh_M%02Xh",
>  			  pvt->fam, pvt->model);


Thanks for fixing this!

	Reviewed-by: Avadhut Naik <avadhut.naik@amd.com>

-- 
Thanks,
Avadhut Naik


