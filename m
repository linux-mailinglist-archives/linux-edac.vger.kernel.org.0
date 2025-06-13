Return-Path: <linux-edac+bounces-4142-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE21AD95D9
	for <lists+linux-edac@lfdr.de>; Fri, 13 Jun 2025 21:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CE147AD502
	for <lists+linux-edac@lfdr.de>; Fri, 13 Jun 2025 19:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67881242D67;
	Fri, 13 Jun 2025 19:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="R3Obbkwg"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23CE2E11A4;
	Fri, 13 Jun 2025 19:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749844780; cv=fail; b=ZeBou8SyWXjSO6QIk/OtFgdZCWJK6yFT3Lka3DS2jO0mbn0VJqKwj1X+st2WKU6SIjTDfjgSUU9bwIKN7kiIYnRgRxux18Sb7Fswos3QGGgGKvy9rowVPrIx8wPLAXRojKBeUJxs0Tl8V6mgj/unZTPV4Q9p2C+PLcKzKBeXj6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749844780; c=relaxed/simple;
	bh=SOXE7wzpmQ3A0inFt84Tk9KrqB+2h00qEE4jEDXuB2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aLtwXLMtE8UNT1Z0NwKBmylEXP8GYQDRoSpxWmnp0jeKdpoRJ+FPs3H/ED4mJU1dSIYSb12s9CH962yxitS0vTjy32yewnnPD449KLxR0NtIkSnQxA5bYnWBgnvGfvyZUHcLiGMWb6U+x+UIE13/0JrPKIyu8LuiCPwLFqOr5h0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=R3Obbkwg; arc=fail smtp.client-ip=40.107.243.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=byplZTjKWAmupDB65y+0SDkU8H5lDOKcs3lVaaxQjH2pcP0yjnV4EKY/CXFnp3lBl58WTq4FdWso9hBjwShCPrGmNV/Kk2uhlV53rUHZFBnBGfC8LweV6dRj72HCPSeFrEeE40Zkozp/QifBbFcQlwYpCQtxMyizHot31L1oiLffc2fWsqbQorVNDqK+dlQXn4N2mRT4k5arfNI3LJPZ6JMWStBHJHr0G877rFs6JLkQkPstgkmfzEG4b+75MnEDk0g6kyw6wu/3Vz/2UZaWdydr7bmd5H9jkKo/NDEGPPaY4++DhbRvC7mAVi34ktvY9yDmHdc4Hwp3zOaKnupqeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CzZmJj+16dyjM6wFR73kiv+iXGWBieP8zU/ejNsKnVM=;
 b=tJd+EEQcZKYTI+rHKIFxloI+B5b7GTNpILz4ap6VVdJy0YHAVfQeBX3s1NMcMECUnFZ5oeIsBYHIaqLH2Wba2Mk6Y8SSQfjnzT7C8ThRYp7BLEui9QOoq7BHCbaljHJSZPeyiyV8WQv/ZAIvuRjrVmcI15oV9gGilBVvTiAZMtQJdGy2rHeRawn4jsKZcFvpPdqrCeX3EgfDL4/7itsvg7k7eHchoXyUKThTrmJ3jVR3RExgo/ehkM6tgg8xyNEPeE9OzI8epFJfbQj1wMcL0n4SfukH7GF1Vz5l5h6aqobVmA0k2P2wUH6fiEyhbkG5Lut/YEF0IGVelZ5OXAP2xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CzZmJj+16dyjM6wFR73kiv+iXGWBieP8zU/ejNsKnVM=;
 b=R3ObbkwgBoguN0h/NlU4WMW6DzYpyINf3tCfbsY1RX42ySwvX6Xj0v5k193+OwZ1z6hfOx1IyvfLeU+wUXbA3MiF0jls6xc9A+99iczxtgi0N+W0fdA0FMm23ZnwzyyHL3ffPZwqYOxC9JI597Fkhh//ja0Slmz0eOBxoG6Dx3A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 LV3PR12MB9331.namprd12.prod.outlook.com (2603:10b6:408:219::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.23; Fri, 13 Jun
 2025 19:59:34 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%7]) with mapi id 15.20.8792.038; Fri, 13 Jun 2025
 19:59:33 +0000
Date: Fri, 13 Jun 2025 15:59:24 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-edac@vger.kernel.org, git@amd.com,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>
Subject: Re: [PATCH v7 1/5] cdx: add the headers to include/linux
Message-ID: <20250613195924.GB171759@yaz-khff2.amd.com>
References: <20250529070017.7288-1-shubhrajyoti.datta@amd.com>
 <20250529070017.7288-2-shubhrajyoti.datta@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529070017.7288-2-shubhrajyoti.datta@amd.com>
X-ClientProxiedBy: BN0PR04CA0069.namprd04.prod.outlook.com
 (2603:10b6:408:ea::14) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|LV3PR12MB9331:EE_
X-MS-Office365-Filtering-Correlation-Id: 03cc668f-d0fb-4a55-d27c-08ddaab4d12a
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pbXJmkNKSJcmnag4ObgSYObXuNGFAZl9ikzBEPFTND4MkY8bNKijX5soAgpq?=
 =?us-ascii?Q?bk4vQvLupN4clHythmAwu1DqiTcFrogrLjWQcgHqDPZ003DICpZIB2dnZPGf?=
 =?us-ascii?Q?0FbP98dblNKZOa5qChfiTihaJduY9YWaXk0AWC6Hp2gRqcxlbge0vdpYi8fb?=
 =?us-ascii?Q?EcT1QYXsd6x3gdYUA1uEn/cdUzYe+6YXmon90SLSapE31Si00CN8MNHuSQNJ?=
 =?us-ascii?Q?16qoMcIRsIU1lZjSHam41M2E8H4X5vg682Zp0yZjYDgP+3+2tVnPGD7JxoRt?=
 =?us-ascii?Q?mLE4QdteM1auxukUF6GQ+lXDFOM64fgmo0CDg+ZukP+QDlRoVk34sv1PWAas?=
 =?us-ascii?Q?/G5yNm0f4RXlTk6lqm3JOnMtAunoZlonRUqcOeOJGgA5mABCWDJldyXGCbLJ?=
 =?us-ascii?Q?uCKlH85hgsMsnJaZz9o7+lgU253iIfSCfd4cMWHWX9gcfS+LA+ljBc0KQMa6?=
 =?us-ascii?Q?oullA4g3sBFr5ufJVAEEJL5N7XVtvN0eYKd/kWzXlfIm20kfKY+FxqnpcaQS?=
 =?us-ascii?Q?pIn7GtJlqO8VlkPqRqb2mr6WUmvwIWqJ3HL2YL3gDako56FPeoDiN49UwKaW?=
 =?us-ascii?Q?DKJQPt55tE8OiyTlAKt2xmhF4iUWdSu3wD/c8VnjS0lcs9qZemhcCQpLCKCK?=
 =?us-ascii?Q?tCytW7IKjUX9SZ6FrodOpDoqVeFEqAkNUeMHpKqCVxXlUII9yulH1Q5YmkoE?=
 =?us-ascii?Q?nv5KwMtn8tmU8/rLtkJ1rAzqXBwRUr0xRWSgNUZ9QT2mbEyt6NgUWpTv1Qp0?=
 =?us-ascii?Q?4LyQpYZegegQMfpBdP/y3nEZVTp4lrgWjFBcOs8Bv6azdIrH52L8UXxZFKJf?=
 =?us-ascii?Q?3KfRWbh0HZ5V6qtJRPfLZSecWyyIKiZgrOCkU81ZLCFkEMhuD/7syZ/2SOvl?=
 =?us-ascii?Q?7dSnioQTGZ2LkO0pfU3WtsKXHm0V+4M3k0bSLnfrzj9FklqFDlTTJvRsS8Vx?=
 =?us-ascii?Q?msdftQjx63JKrz5fVc39Abrzitf0oZML3wTxQf+XnJvLDfqrgh87dUEJCjnh?=
 =?us-ascii?Q?E7A0UOXIJItWyB4x6+R6zHuFl2c5QR1FPrD5YUumD87MWVz4R/BMJBc5/lJg?=
 =?us-ascii?Q?IwafIz5YP8PVgeYMGnnkEdLQgP01ils2L7aogLBD6m7saBZARMTMbjrCRCq7?=
 =?us-ascii?Q?Buri1Oeu6s+dVw0knQQi2PfjMmHMkfkOcqA8eCB3Hdi10C6moyCPYksENrs8?=
 =?us-ascii?Q?TGHWdd8HQ5xu2UPVMxrA1KFFxF+I6IzpUxeLIIYEWdCBS9FVLNEyVb2FxH+1?=
 =?us-ascii?Q?zkD0i3ZBacb9hcsBrg5s0oh0N1Ql94G++gKBVJUOViUwxnm4zLCKkMe01Tjz?=
 =?us-ascii?Q?cKP47WAG83QQg3kyqpMFDyBWubvYBFfFIN6QU53UIEz0Zah8pGc+nwGk0Z6i?=
 =?us-ascii?Q?XYQd2DtlV5w5SuAfV/sjbbtJnuzWVloLGwKOoWHcB/SZTiCGohw5ekQcNfqD?=
 =?us-ascii?Q?A+orC5VYH0o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N5/5g6sZJGjulaN+1VKMbyxxv/T9ij3+a88/E+bx8flpf+PcJyP3QMufkH6I?=
 =?us-ascii?Q?RA+jx72RDbPZvAVlsir8XwEKqCWmnbLS69yWKF/oLGlTVlZAV090bOM8YyYd?=
 =?us-ascii?Q?YITqwCaE4W++W1Ex+kAQejIkc5DwzzYVjeyJRR+a83pyIB9kJsqFiYUcvG4f?=
 =?us-ascii?Q?oyQaE88Hi5hIRXoSg39Uo+c2vcyVw0Kv8d/Jcvta44evqSiCzydmAq9e0p5V?=
 =?us-ascii?Q?KP05DkecNz7ttPVRpe1kZn3eYf7YnlQ9Ohi/gD/SbuXfXZVVdv3mUILFKPaX?=
 =?us-ascii?Q?TYWhXvCEZm71Y0wJrJ/xHYOYZWlZa7hbyx27RPcQf3EHKH1Pq5zLdYeNSh9d?=
 =?us-ascii?Q?ppNP+LnxYqBzCL0XG1WuYoWUY/SShFvlyopCqKxx0h19iNBD1zEW0IyR8bxH?=
 =?us-ascii?Q?jgK9s5QTfesX2gMNyWQTxsW4iUqI9DG2lXmXZmhxzuJEUcjZoKHVxgspVR1S?=
 =?us-ascii?Q?fb8RZTtkfnJ8yTgtJIVBLmOuGyvQiJ4kj80wlsS27/02sxVwscC0XD4yhq3w?=
 =?us-ascii?Q?Z0q+ftrUMGWJSRqO1ti9fAG6ztM8r9fR7zARlwtsKiS8ZO61IuZZgoN6d2pr?=
 =?us-ascii?Q?Hap3ZRcNRrT4IxJnymtHkAp6OL58ZERXfEoUnCjUmAycgyXZBmPMHa//2ijR?=
 =?us-ascii?Q?kNtM0gjsBYTEegpW+9RcccHbKMnV4OFp+HW9yOkZuilZGAM1fDxCpxM7W0YE?=
 =?us-ascii?Q?tMZVFbpzSNoMn9d/Mn0oicEp8PRQ/xJAHtUS1/qRSty93gGySAwG2+Vz4tgx?=
 =?us-ascii?Q?eMzvm2/1m/wJnyqOv1RHnKcsRRJABnjQ0uJmjn4Yd7p3wq4qQtGid8wy7Li0?=
 =?us-ascii?Q?N79m5EprX3T4O56CK/irhr8EVK64jhQ2NJP7lNRfCnxMOQ+jGRjsm0OyiLeF?=
 =?us-ascii?Q?HfTfj0NODGDYyY/pzB99JZbLkrmuR+M/pN+XxmuqVsMm5Ar6oHNlK0jQq4o0?=
 =?us-ascii?Q?YBKhu8ffn94A0Z4654MJlQzqZvyduddmHsl4iA2YlWqzkxrPxVssLHmzZjP6?=
 =?us-ascii?Q?o6UGoj/AwbBVTFnZ1Ah3giadsE6mok9W5vL+BWHasie+uSXPAtilLu3g0Y7d?=
 =?us-ascii?Q?g/EgBxIXCG9PfoUPw8Gkvk9SDqlSiePmmRCxV6mwY7OTtuRMztrCbxXczwYX?=
 =?us-ascii?Q?KzlaGVBeBqw132f+ZCOHmzm0Djd0ZtryVjlj8T1WxBUHyVGe3HnhvxlaWMr9?=
 =?us-ascii?Q?z3y+aG/nhspHsh4SSVowHUK0twJJ6LQVAViIo48Eea9gOdqSLF2agKL00fx0?=
 =?us-ascii?Q?MGjoPTCaRmQQ/UaVMo4O85p46frOfeIf5hT+P6cesZjHHnoc1vbuORyoUwlq?=
 =?us-ascii?Q?6iPfUA8CVP2YhncyUbYeBh/t+njMg81uPFOUkTf8kTWXgwOvr3jt0m7exVW0?=
 =?us-ascii?Q?IwaKIEEvnMueiKg+/PkUV67lmC8AUgmdwEyL0kmGmKJOCKhC/xj6jWK4YHUL?=
 =?us-ascii?Q?Aw1duC0qvlEUftG/2uh3TeTJWxvdyFBxCxme8g+OeDYwrdNC4zdJJo51T0DM?=
 =?us-ascii?Q?vlxgXEs+Fbvc7Cb8ZfW3MdDA+kAtIJhVkrS8m6OUEz40FqdvmKqHHc5EW+mh?=
 =?us-ascii?Q?MUF5Lptxruo3MxEwzV78IjVKVQjflY+4lNsuKyvN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03cc668f-d0fb-4a55-d27c-08ddaab4d12a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 19:59:33.8438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BqTi6WdRuiGflxbgQRS/sCLYh4+CXw4mFdZIcSOF4hzYfH5ASxE/sjXEkg9uGx/FPH8fQcL7cX4E3w1+SBVFGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9331

On Thu, May 29, 2025 at 12:30:13PM +0530, Shubhrajyoti Datta wrote:
> Add a the bitfield.h and mcdi.h headers.

Extra "a"?

> This is in preparation for VersalNET EDAC
> driver that relies on it.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> ---
> 
> Changes in v7:
> - add a minimal header instead moving them
> 
> Changes in v6:
>  - Patch added
> 
>  include/linux/cdx/bitfield.h |  78 ++++++++++++++
>  include/linux/cdx/mcdi.h     | 192 +++++++++++++++++++++++++++++++++++

These only get used by VersalNET EDAC driver at the end.

So the headers can go in drivers/edac.

Also, maybe these can all be a single header file? It seems like each
one is just included in the next one.

	$ git grep "cdx/bitfield"
	include/linux/cdx/mcdi.h:#include "linux/cdx/bitfield.h"
	$ git grep "cdx/mcdi"
	include/linux/cdx/edac_cdx_pcol.h:#include  <linux/cdx/mcdi.h>
	$ git grep "cdx/edac_cdx_pcol"
	drivers/edac/versalnet_edac.c:#include <linux/cdx/edac_cdx_pcol.h>

If these are truly independent header files, then the "c" file should
include them all. You should not depend on a header file including other
header files, if possible.

From "Documentation/process/submit-checklist.rst":
   1) If you use a facility then #include the file that defines/declares
      that facility.  Don't depend on other header files pulling in ones
      that you use.

Thanks,
Yazen

