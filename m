Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5142749116E
	for <lists+linux-edac@lfdr.de>; Mon, 17 Jan 2022 22:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233947AbiAQVws (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 17 Jan 2022 16:52:48 -0500
Received: from mail-mw2nam10on2078.outbound.protection.outlook.com ([40.107.94.78]:9953
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233431AbiAQVws (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 17 Jan 2022 16:52:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U0vbQ2qUf0G7fk9O8zjqKnTVWs0WllFF7hrAhSaCFkW6ivyOsgX650LNb9Hk9vunGz7IJjyJBHoBdzPy+1Orc84T8HpYRbHgOEvxH2lNWyuH/BsULtuQHTTS8v+9cbo/bRKYuG1IF5S1k1ISe/7Fclt7YGXiRl8l9sdmhsph67TpOdMBLhn/W4vL+WQmesulfGWvMJCiWBTmzvG12XvfA9vMfGRVEX+nUniVLOk9rzu25ycj9wtPCvBhTGD2Yt8jxjsxmQwUEu6I7obdEZJHZnAfOfi7k2lQsBKGXtU/NuGW9g/qpJ4RBKqjajesNmbzJv4irHpJrAxS1HRjX6N5CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3pC/mfPaKM6YtPNt9WE10C3jIwrLSbuaXEoMHflhnOA=;
 b=Wlb1GMwnsN+A9aap/lZSilj0osj9hykzY7rz+o+4jX2HUTxJs2DXIfXRIWRwLF5kXvk5Dfy3SvgCbvrhvwdRIEOSvrr8+NrN86kK+q1JbXrCeIYyj16kJq2hyzCw6LvwUq7Klr6DiHC9d5R5yHStqfbpFl6AvIp2FVIoxdQDK/eeZ0GEfnTs14B4NFofdkYWX77/XP8II+Df8Genq4WE+zsck7aJN/gDOlcMuEv0fvJHWU/bHpw3jhocoZclH6qj3ZIiH2x5lOd2Ig1ateS0WE34NWp5js1lB8SISCFIcbgM4Z7/5PcdKnhuHDIZu29ofuiUjHyts9Dt7UI3ET0NXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3pC/mfPaKM6YtPNt9WE10C3jIwrLSbuaXEoMHflhnOA=;
 b=LIw3BPvkTK4zO5LuMgzs+Ip0aezURKIg+J+NEZiwBx/4taz8K0KhWmGx2p+5GmNZ2LkmG67dDGHuKkJTydsB9iZobkG4hEJ8Q9bxXe7H/E8JcrgBPlIgT80XNOHYnVOPXMjLrKxH/g2VrE2MiPi1D9oh6Od4/HMq8dtfcm8C2SI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB3620.namprd12.prod.outlook.com (2603:10b6:408:49::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Mon, 17 Jan
 2022 21:52:45 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::f93a:9f04:fbd5:dc5a]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::f93a:9f04:fbd5:dc5a%5]) with mapi id 15.20.4888.014; Mon, 17 Jan 2022
 21:52:45 +0000
Date:   Mon, 17 Jan 2022 21:52:37 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-edac@vger.kernel.org
Subject: Re: [PATCH v2] x86/CPU/AMD: use default_groups in kobj_type
Message-ID: <YeXlJUT/qgRf9cEW@yaz-ubuntu>
References: <20220106103537.3663852-1-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106103537.3663852-1-gregkh@linuxfoundation.org>
X-ClientProxiedBy: MN2PR02CA0006.namprd02.prod.outlook.com
 (2603:10b6:208:fc::19) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8f22a6d-7eb6-4a43-753e-08d9da03b1d8
X-MS-TrafficTypeDiagnostic: BN8PR12MB3620:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3620E0FBC3A884A7EC3ADED3F8579@BN8PR12MB3620.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R5jYNvwTi5KmmoNFsM4LrmkcB0MylqJcVZrS0wCvQdkp6Y54NXVHOvXx3Z3RuTF++0Sf3IJFaATTVPNEstkbOevtzq4EoTidWa4xxF3DVHKJgYp2ceFhSr0YGSWB3xQgFBYpiqC4XXyhQ7wk1yUtyLEXTa7wubzhwvotgfA7mqMCprRuWMLs+Ieun2nYt7JUxN9qA6Y4X9mC3Vy4xwxQpGELNKNZMybQIHl+LhqqhzjMY00TV5cPGEoNVJo2RAc9Caxjskky2zxKYHlRXk7/wXCP+oIPUq3hojjALTkmxVtpFci2nAMhemc1ePyE5suR+m0oWxD4Dqm4BY3qdebk0PSiNfSz25p5+DMgz1ly1jn4ETFX+yGz4kHCSgsf/GNynYNP0Pg8L4IzmuIthVN0zfsG6UMbbadbyQVrK4hJwKlYQhRIYSnIwo7uH29j2Olw/05mgTo5ktQ4kUHgObBaYB83cVJfXOMoQdgMkhd1SOAWc7qj8Lgoc9pFaYj9CMb0SOHXNa9bvMYUcejZlTUhOElSdjRtWfyXDE/deYESiC86kthjmRnnEADJEEezp+BH7A3VKNDgwdiZveE9Tqc8GEjEqnlHuurBYwM3Ka99YqBdmaiDHKlvtU+oxcI9EmRl1fQ55xO4saAU6E0DJlXX1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(316002)(86362001)(54906003)(6916009)(66476007)(2906002)(66946007)(6486002)(33716001)(38100700002)(6512007)(9686003)(5660300002)(44832011)(7416002)(8676002)(4326008)(26005)(6506007)(8936002)(508600001)(186003)(6666004)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WuNAqeOrGdqxmoBR40MQJoqZ7eLPm3VV3Gmz8c5pxD0Ofk8uHPfTdUG2wkmp?=
 =?us-ascii?Q?q+YaF7KCKTav4/Mc7RJIZhP02w/TmIee2aUEb/llv4+ZlR02MURFaMtXgqy9?=
 =?us-ascii?Q?ISTfd3ElOLupQ2+QDyoj+7K3xHjNvvkX41lOduYT0vA91CgTN00Qfi62PonZ?=
 =?us-ascii?Q?Eesxg/EJ0OK/9V61CNMpjF9OvSJFXAKi7ys+p0Vkn2v3sY/rRZJJR9V50ViJ?=
 =?us-ascii?Q?YHcDGvEhz1Auuju1vPQL4s0lTMUJgaDQveR7xeh4+HbDQ1H3LGzaMa/HHSEi?=
 =?us-ascii?Q?Z18ZF3HW4qNFXUYH3hDgT6P/b5ue0vkFxjxJkj62aLPyqAQARYoFJegiJ22r?=
 =?us-ascii?Q?DK0+dSRTp0l5fTrK6QpMRMAKnXcXO3htMVxlOSZdFm6xpWOo2zaIgzElZ1Li?=
 =?us-ascii?Q?+qjjNDXgrpNm6JFOr9daJUUXPisa/HdMrXsqkwf0+kqmZ5Y68AaG5x9GTYZy?=
 =?us-ascii?Q?V+716pLyqueQHn/jpplCRzmjzxrYYqOjCXguPU/xZZ6MDx1dTxFDo31aksZz?=
 =?us-ascii?Q?8c2IPoxOTMUNDA77htaarIzFbZ/1uflmz+7nl5Bi5QF8IAdmzjyHgwYyIqhL?=
 =?us-ascii?Q?fAwuJWzmhlcCowqyK2/TE9/jdBIL8iHi2kPEIR3kSkKTlChD3va0SBKTgcWl?=
 =?us-ascii?Q?6csWcJPFIxgq7nX4AVd0ZiKyT8/nQ7q/6slrTWdhqVAm4a3IocGdPSF47BI3?=
 =?us-ascii?Q?A75Fidyo9lj1a8HSheInWDJsWLD8dIUs9aEragxdlagCAv2dnYSxy/3pp+68?=
 =?us-ascii?Q?AdMjMlLxz6RuQYfAuC2lM+LB40qMNaKpIfz4vnWe4dxo2mZel2g2YBVETcXv?=
 =?us-ascii?Q?dP2MNnhtu33Vq5JhEoGpOTg597CeaIZP9mM4R0u1rNoLNuvROXW5VrToTj0/?=
 =?us-ascii?Q?D0WD4nD7SyZtKr3YyqPr3ZuXlcQcnR8OEnPd/iR4gyvgv/hZq+MZ26RQZVR7?=
 =?us-ascii?Q?vsiy3e3dCcWeTZ7BpXHQc83m6X7QO0gnJjy2UoRoZ1tg3n9Q6GGEz8YJbHbY?=
 =?us-ascii?Q?iMPrwDEuSx7SYQ2ExFndzM/Bnetd/XET4w7bxOXY13KYpJHzMkIt6ByJ5Jwc?=
 =?us-ascii?Q?No4cvwhjQomqoO72UiVCuQrfwjXvd4OeHA8e0Y8/yrdmiTlBlmHA952Xple2?=
 =?us-ascii?Q?fHebYdo8uMFqmTBmt7s2r9yODBKcGI+ZYbmGKgBuN/Owyd0kjVMBxHhZ4cz4?=
 =?us-ascii?Q?ri9C2b4AoiAjCvbJW+YwvIPW8XF/8NmL77Nnka10U8b9rdN+n4bsCThfUBVE?=
 =?us-ascii?Q?4Z79XzmJs50/QOOYSohR2kujWsSKdeYfUZi3IlxhTOTAYR7WStMQtmmR8g3Z?=
 =?us-ascii?Q?0/82a/V0q+lcP1D+kbr4NdKRE5vGoUI2M69ngos1qIY0aIHWhraUWRnXdiLE?=
 =?us-ascii?Q?TX/lV7V5fpBzEep4hy7ucfswx467B4RUblCKyvfORE6b4Ja3MiDG5r/iTjM0?=
 =?us-ascii?Q?cyqoMr6T7X6q1NdSZEzFBhvcm575g2/RDBrla7d2fsQGbUaX5G7VE4tp3rTg?=
 =?us-ascii?Q?aFEy5/8MdZUtQenCswnHEXKcXAoVm2g5LQKxlOL5egdk3Biuugy1gaZHdipM?=
 =?us-ascii?Q?AfN0KpwFVeTUQZhK1Zi6GTj8blYuXCLHA+TgWo8al6VTo0yaIOOQGm6loLHT?=
 =?us-ascii?Q?YJHxrRIZ8wRe29hGhVX14PQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f22a6d-7eb6-4a43-753e-08d9da03b1d8
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2022 21:52:45.5333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VAspaYHAQYvKk3Y2+NiBBI1EgD3BLbxmsVSIVN1yXu6yGK9WLRhTDRXW5X+jbG751pEuIjVaLKbTXzPppVA/TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3620
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Jan 06, 2022 at 11:35:37AM +0100, Greg Kroah-Hartman wrote:
> There are currently 2 ways to create a set of sysfs files for a
> kobj_type, through the default_attrs field, and the default_groups
> field.  Move the AMD mce sysfs code to use default_groups field which
> has been the preferred way since aa30f47cf666 ("kobject: Add support for
> default attribute groups to kobj_type") so that we can soon get rid of
> the obsolete default_attrs field.
> 
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: linux-edac@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Tested-by: Yazen Ghannam <yazen.ghannam@amd.com>

> ---
> v2: fix up direct pointers through the kobj_type to the default_attrs
>     The logic here still isn't all that nice, ideally the is_visible()
>     callback for the attribute group should be used instead as that is
>     what it is for.
>

I'll check that out. Thanks!

-Yazen 
