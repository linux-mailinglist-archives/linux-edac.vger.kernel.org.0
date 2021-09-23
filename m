Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D85C416450
	for <lists+linux-edac@lfdr.de>; Thu, 23 Sep 2021 19:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242549AbhIWRZG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 23 Sep 2021 13:25:06 -0400
Received: from mail-co1nam11on2042.outbound.protection.outlook.com ([40.107.220.42]:63616
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242554AbhIWRZE (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 23 Sep 2021 13:25:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=laIVBE0BP5E+ge2tBhOgqL9hcphEe1oVe6AYy4saowqs7Gcos+YD7V2X9GB86rpW3vvQPEaEZLV8NMp5C7PIfyd9Iu+wKeasZMLRh6lpfV6EEs6HzJeQb0gwjIJcB5Ik9D7C9AuWNZgaF4zyIarWaVUfwT4GZBTNYtZicv2NJknNMZoLe0sVXbEb+sYn48N4HS6MTFIbvZDWxIP8LhXL5zJ0QY/htJug78TKo40eeeZ6KrlfBzkRitoNDam117E2d0/cCVjpgzwA+1UJKR1Bj6TbFKYhIISvIT/WbXmDYHWANepBb8n8LfOiVg1Qj9IbOp4BvuRmZe0BLpITUp6dTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=1Llyr8n9ct14u02R64pVQZ8w3v9Ts4KQDKbN7EHI5qA=;
 b=FBb2igXOrP30OTntc7T57UL4TrJ0cNCPB6U4wapKbOQ6c/QRAwD4JsF0QluJ12bdvFoCA+W/Zu+drkrKrFHvxqo5COuHUp8WIaOADPoiTqaHJ6nnfcMPfR3Uunf1RPJ18c44WtGt7aTgcdfKBO7d39hWqqOGsxmK4XqYL1WX7YJM26Gd381szpO1zOEbjr3rhkTIT0msU8bvuKu67nqhqqPMIuYjRR27k9ncwqIK2b6++7qop6yzMKU4YVCbIVZ8KOT7Manh/f6GwqX84ayAcFAXdWLwwmYfjkXpHgEXIU2Je9hPSer5o0Yb+4eJdZP/rxdFQcJr5Dl4WrLsavaCsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Llyr8n9ct14u02R64pVQZ8w3v9Ts4KQDKbN7EHI5qA=;
 b=nx9RFkqzZEEXNLJKXjJN+lbCGKlfs927lteNJYh0nV87v6Bep3mr1u4K214CaALxLgLi0VCHGh2XS/nkWa7R08J5T+MyI9As0hYjVp2dWVMYIe6VKTGIzlYb0yDwaOmv4ley1Srkq/SZRUN5dKEnMmFYCMj0cJ2JU+jMRYhX0U8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR1201MB0081.namprd12.prod.outlook.com (2603:10b6:405:4f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.17; Thu, 23 Sep
 2021 17:23:30 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::fd41:979d:a3e1:d958]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::fd41:979d:a3e1:d958%4]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 17:23:30 +0000
Date:   Thu, 23 Sep 2021 17:23:21 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     "Joshi, Mukul" <Mukul.Joshi@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCHv3 2/2] drm/amdgpu: Register MCE notifier for Aldebaran RAS
Message-ID: <YUy4CdcUWJzQfM4N@yaz-ubuntu>
References: <20210913021311.12896-2-mukul.joshi@amd.com>
 <20210922193620.15925-1-mukul.joshi@amd.com>
 <YUyPM7VfYFG/PJmu@yaz-ubuntu>
 <DM4PR12MB52639349DF98DB01A3B155EFEEA39@DM4PR12MB5263.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR12MB52639349DF98DB01A3B155EFEEA39@DM4PR12MB5263.namprd12.prod.outlook.com>
X-ClientProxiedBy: BN6PR2001CA0037.namprd20.prod.outlook.com
 (2603:10b6:405:16::23) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
Received: from yaz-ubuntu (165.204.25.250) by BN6PR2001CA0037.namprd20.prod.outlook.com (2603:10b6:405:16::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Thu, 23 Sep 2021 17:23:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33db7421-c078-4ada-0020-08d97eb6dcff
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0081:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1201MB008117EFC6D611B916BFE07AF8A39@BN6PR1201MB0081.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yt2joL/SSHVjJvZZ8Z9OvPKv3F+h1p56toC764w9PRRAE/5KhLqgWL6fTgsheBiCHkLfyr91+RZNi/BoM4FF5FZ8Q1nRK2ha6J5gY8BF6MREDg/T5V6RaOqnIPDSK2UWLJV+Y1mI59xyS2OY7lAFdNPBs/Tz5FbS9FsznVDNplIyD6uIo5ePkaC/GdJQfXpq+OfQVWjUvVFRaC80INboNltJC4IXcp0nywiWvfzYRRNvP08AloQVWRr0cEBrd1YCbs9ehxKiFI6tVLzdboMM8eQ/uXX60UqgbtDjGaSr0NSHqvw0GIBldNlwNWf+Wg63tHQF1kqpVPmfBMEpiNdEXNAMBTSEujGSqBeC2HF9cs1Fotixcun1rerh0hp7cN3srcN6GUvPVrd4CYf2J/TSwJxgAYhZyymVmn6ZXfIrotx3LkWv0wJQ9yhjrTy4T5dm1iD5o3hukDxsaKkTTk7OpIFkysm8HQY8EFy6szPj6Mt+LXaYIJRgV6q06kmhKD+3mntkp0Rzu1VtYmXksJGZUUPf9+MjYlqoVs1RWFAVOyaIAef5yS7KxWIjztWblt1l339yLmxmxc0EWOROYmBdm/z8Dd+tL7jv/ptDAoqa/W8v8N335TzcBH1sr+LomCCVIjeamOfZUTPvfdW8h/9pfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(55016002)(4326008)(9686003)(26005)(6496006)(66946007)(66556008)(66476007)(5660300002)(6636002)(54906003)(6666004)(6862004)(316002)(4744005)(956004)(186003)(508600001)(8676002)(44832011)(8936002)(86362001)(38100700002)(2906002)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3cnQWxwLm0PrSrOrRRS0O2Oypsue5dDZgYvDpEg5KrIr9YnAfcbfrgwRJV8T?=
 =?us-ascii?Q?EwCUGNU/8EvmC5PZdkG64KhlnOvVPnijoUGS8M9uga0gYvfIGPKBzNPjtACq?=
 =?us-ascii?Q?VT65/RfNmiYqs7ml4Jy9c43Fe9cKpOMmNxeVWNXIiJCvrn8ipvu3ihKGCWO1?=
 =?us-ascii?Q?YA+jBuXKeazjx5pGXawxZBxQLsDOIwxSaqFbdF74ojr/Qhzgk1koCyK+ln6/?=
 =?us-ascii?Q?15SBnJjq+rK5Q6sD2E2IOa8YpObzK5Zp6EmPBqGwEVLScfJcWwf1cqVtfsp+?=
 =?us-ascii?Q?nXmEDOVWRnfvKPHzNh0PRfkqnvF56a2BLXUxvfST4/HJ243SXq4IVY53ViE0?=
 =?us-ascii?Q?JWxlvYK2uO13bnNQGTONTl7hpcG8P/85bMxJ93lzf43NQszyO/EZOCE6U4Zt?=
 =?us-ascii?Q?iKTbiaZWppUe7DgbQmEPqckNVQelZDL/diY6xVOcFhXeoaEX8rhg7EcqYeXJ?=
 =?us-ascii?Q?B6J4WrcCzuuax1CPvo7gIcXDbGLQdEG1xl3HIanFK/85Sm/V17wZT35FgP5r?=
 =?us-ascii?Q?EnsnEF5n8HI+07Hp8FVPoSNRKcvzc1SqmMmwTu9Slbhyr6/vwH+2jKZDrQBA?=
 =?us-ascii?Q?ZB3IpDItt1gWn/57CYENkP6jhpFlZhm7XIdrBSy728KGDl91AwXJYjPAZNnJ?=
 =?us-ascii?Q?OPTRgGSv4y+z1st67tfHtVOrQ+JyFdRkkaxH6u0xkclCIpmSRallFFk+L0Cd?=
 =?us-ascii?Q?wssF5f7kpQTwrz/I6LurNNrxIQfbOVChhKW8KtcWT52v2gH9O87bPrdaeQ/o?=
 =?us-ascii?Q?KAganVyUiSLfc9AbAFW2ydjaj9fR7TjwJYMIUP8zJiufdpFgp1kzcGGxLPOa?=
 =?us-ascii?Q?S4wXvJnSnl5u29je3esJqThpjmlTLfIVDvW1f9pYff+UeeEIKvEqE9cl13Nc?=
 =?us-ascii?Q?C0xH+FVL2oI6sBEjV82RzQ9gJLGkVlyT271GsxPiQQ+kOrssdXUxfIacrUZ2?=
 =?us-ascii?Q?NYmxU0gCwL0Z/KykQsLfL7Vpa3r/7JexSalUfALPqlt+qfzw8aYIRNxyQmz4?=
 =?us-ascii?Q?B4/Ib76uhcOTIj5P1YwIqR5E6q/2tGAINt3IyKEBZpJqTIdHmgC+GW3CL7ov?=
 =?us-ascii?Q?bfJkhNw9hRZIlOoRDDJ2txpdXJGk8v3nFgetN6n2CwqLNY2hUrstOBw16/qu?=
 =?us-ascii?Q?C3ga8340UsE/Z9kpR5WN/qRysJ+XWcDQZL6iiZwfE9/PIYxEUbY9YDUvHUpC?=
 =?us-ascii?Q?sqx9gtf7i7GUraeRtU1qJnOQa1/FA+K5g/zQnOTCWwj2GmeLj0GpZWYH9N8d?=
 =?us-ascii?Q?w+m0AJ17q9XzyC/tnuZmQLNjCTb3S8EMqrYqrVX/iroI+14GD7t/WVu8pQgD?=
 =?us-ascii?Q?szmSep2xbwYj+EymK1n9/WDe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33db7421-c078-4ada-0020-08d97eb6dcff
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 17:23:30.7492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PutWnFBdSgCxZD1gzLhCsjq4nkLg5q60VewALkMnxUwlkWzWDvOG4atFWbVfuy8G56joGxT5L4m9+OCySsoJuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0081
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Sep 23, 2021 at 11:30:55AM -0400, Joshi, Mukul wrote:
...
> > > +		return NOTIFY_DONE;
> > > +
> > > +	/*
> > > +	 * If it is correctable error, return.
> > > +	 */
> > > +	if (mce_is_correctable(m))
> > > +		return NOTIFY_OK;
> > 
> > Shouldn't this be "NOTIFY_DONE" if "don't care" about this error?
> 
> The thinking is we want to stop calling further consumers since it's a correctable error in GPU UMC and we are not taking any action about the correctable errors.

Shouldn't the error still be reported to EDAC for decoding and counting? I
think users want this.

But it looks to me that either NOTIFY_OK or NOTIFY_DONE will allow this, so
it's not a big deal. Was this intended to be NOTIFY_STOP?

Thanks,
Yazen
