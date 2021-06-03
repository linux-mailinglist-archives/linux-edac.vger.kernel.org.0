Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4321039AC6F
	for <lists+linux-edac@lfdr.de>; Thu,  3 Jun 2021 23:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhFCVQO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 3 Jun 2021 17:16:14 -0400
Received: from mail-mw2nam12on2089.outbound.protection.outlook.com ([40.107.244.89]:47681
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230055AbhFCVQO (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 3 Jun 2021 17:16:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JPbXfnnfyMaJDN/v5S6EiRpDd1mnyXlwHpX4ZSX1YUzSx/oe4YqTZAocw05PGqoaSPBI+g7t/vcIPXiK6er29EmiYQfm8uGxG6qrfUaeMgTNmSFNMzgohhVyenneOzyIBUi4oJYZvEKayXxLhBMb3rS7GPNm2hx81zwi0KgfwuEJvnnm+6FfhLLtUR6k8igdM/U/47DRYOqZ0n4Mn4p+BSLyxODlbQGD8LYvuhHXjxZMMyJWVMJyPeuux1SxOZd3IJaGumE3UDj8fWl2ue7fNxt1G4s6eIaag6cS2sdzsmNSxYJL60borLDqm0oC/6a5/GR6GZph9QU//znI6/bcWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1RkRmP6TgTWx7eexbejDpjD/2DRihWpeo5KcWB+Ja4=;
 b=R0BZuEQJreM2GskvecR3FZdzqKJDvsQx6GPlBR7vnM4sXMr0H0ZaU84Zk5fvs+yPGdegHQmA945ifvkcm5P7vaXCGHlT7XlX9Ki9BWlPAMHkTYUcMQmW8apfAEfxYYogwmNOowE3X5aVA5K0LlCokEz8xPivWoS4yzTJdW3f2SxtIDszrLJsad9J6mklm6pqVqBYrIGl82cFCIn3CHGLGghzON9EzGjBACRtuvKua4MxzJ+QtY+9dTDCyeERV3cwD3XO7CgXbw8K4zwMQbpu3Uw+7p1EoOaZOVUB3dS6THunmUKpwA4CVe3xBTqw9yUMMQvudw3HOR9APWI/NlyJIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1RkRmP6TgTWx7eexbejDpjD/2DRihWpeo5KcWB+Ja4=;
 b=Uhi/CiUxRTJDnFABTKOa4J0uw5UWQdej7Bwk5/epQvZc3z1QhV38vS0C3/BXSRMsMDp/oSEw5DH5pmjfYTLJ8rXFV5xRSK2jxYJC2oQpzsr1vkT0AGGpyDvo519JnJoLdjg+cgoOMyC3p0yy/D41yh3oub12yc9SyyJSKXlbDxU=
Authentication-Results: canonical.com; dkim=none (message not signed)
 header.d=none;canonical.com; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR12MB1748.namprd12.prod.outlook.com (2603:10b6:404:105::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Thu, 3 Jun
 2021 21:14:27 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::453f:6e2a:468d:ad6e]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::453f:6e2a:468d:ad6e%5]) with mapi id 15.20.4173.030; Thu, 3 Jun 2021
 21:14:27 +0000
Date:   Thu, 3 Jun 2021 17:14:25 -0400
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>, linux-edac@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] EDAC/mce_amd: Fix typo "FIfo" -> "Fifo"
Message-ID: <20210603211425.GB1410@aus-x-yghannam.amd.com>
References: <20210603103349.79117-1-colin.king@canonical.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603103349.79117-1-colin.king@canonical.com>
X-Originating-IP: [165.204.25.250]
X-ClientProxiedBy: BN6PR1201CA0016.namprd12.prod.outlook.com
 (2603:10b6:405:4c::26) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aus-x-yghannam.amd.com (165.204.25.250) by BN6PR1201CA0016.namprd12.prod.outlook.com (2603:10b6:405:4c::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20 via Frontend Transport; Thu, 3 Jun 2021 21:14:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e03d3339-9ab1-4af5-7b12-08d926d491bc
X-MS-TrafficTypeDiagnostic: BN6PR12MB1748:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1748A90325C730164E3DEAFBF83C9@BN6PR12MB1748.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9gs0Gq6GDJ0g0Pk7VnYSCpk4M/evIE8F23ingHt/2gg9kbDXnb5t2GZ1HeE0DZJCfVFOpU2Ug6kYrgeZBnAr1EKIzn7QCrIXjanfkuSxgQg59dJyNcdXRs8L7d7wwcDcZm3/CRR9uyvOrClZzMm4fyLMhPiGlZpXXNzk0ZA833RpYdP6ZPdjp5IHuLtkWAZLw5msWhgp9EA3jw1t2vUByWD0F+6l9HYcOoCISKAO1eisztY8jc7T2yKy4dTLBzFDV+PFVBmOMcZmZIUEbnd0GMfHuopnniARC/rWINtVAiz/VJkEdjBvBEiGKoGyACRUFY8qyCmMUT2JIcdBsgSYMf/f5EznQyWFaoHzqMVbpuSSUzmWxSAR+FKehTJ9y7bZmtvpb/xgVNnmZDCnNn8AAXDF9qJBmk6XIwYySpslYxUrBlkxL+Wnfa8Wy2/4NXRxhIgj86OfhBrqyqEifLkrdw4OgJ5VDdytW66PJjG/Pf3MGzrApoZ3olIvbvsrPiMzRi5qllxrpgMqOvwvJwiDmYbvpyvFN9FYQgxgIQ+zVozjYtVABJ76604Mz8/SRKsHWA/AEZVPcm6oPbHFITvyxlhRpFUbiZtocwH8xryyewoxJOWXokngsZFJcpii8qa8XmtRA4iOiIbkhHV6pwRtXWffgu4Cb5WecjJCZSvkF7k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(346002)(136003)(366004)(376002)(396003)(83380400001)(16526019)(6916009)(33656002)(38100700002)(38350700002)(956004)(86362001)(44832011)(66946007)(54906003)(55016002)(8936002)(8676002)(66476007)(26005)(7696005)(4744005)(5660300002)(52116002)(4326008)(478600001)(1076003)(2906002)(316002)(186003)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?PRxKQfgs9BCsuyxx4dNY6t5CagO+PUZI76yOMK2SEwtvFgeQvvrNahqGF/ie?=
 =?us-ascii?Q?2vwvZkyOyL53VN8f/ELqsQ5UYNzVPO3pv2mVMEfyp0/vsmUZwIrmGpdS1BPX?=
 =?us-ascii?Q?IjpRSjAs1vOesNEYLw6HcCyKxQrbmmrPfdzYsDStkmCIcIAjA95Uz461xXIk?=
 =?us-ascii?Q?Xg3CBS9zIHzeGx+/Da7I30+QKgsSACHFmmS7I27Hp6oDY6AOYZvoypS+7jEw?=
 =?us-ascii?Q?/4eaK/63PLtrHpZjtkgi7MI/Js4ElmC1xH/ioQUhhOL/h0oOoOQophDEMByZ?=
 =?us-ascii?Q?JgYS2m1uP6RJ9dBE98D3CtKCehwPmNvqaRy9JDUBdRCSX3vg+UrL7w96S20B?=
 =?us-ascii?Q?KYOoNL9jh615cBVYs+h7mIyQ9aWsAlYn/PjrwLroV2z0fzZWGM3Uw5DSBxa6?=
 =?us-ascii?Q?5p7z8l0NBpbOV30Z0h/dRKIK8taOgBF+6P0VH/hi3BtsUtzGSsRbl5Sw1ga6?=
 =?us-ascii?Q?KHhkVkk1o8YK07QpnsUz+6wZl1KeHji9mo+uVEqfs+xAKR78wsMtuSLGJKXI?=
 =?us-ascii?Q?hM0chhiyM/Rsvj1eR+y3mROE/DISXh41e4TcQK0ZWfxQvn0ify1MnxGVTuEQ?=
 =?us-ascii?Q?L7m44JSQqAJu6m6IGeQmbRckO1QqO3bA0iSg9Sswb4E32/ORKyAhQZUK4d1j?=
 =?us-ascii?Q?lbavYnCVRTHtgnLcIHZPWanFNlD3ji7ox9D9pR1hYFcIopoiZ99YuxVQPIoM?=
 =?us-ascii?Q?+GnSwblk4sWwe7GKq7IzjrxX42HAerpmn82URJ1CvYEstRVhgliLv24Qrvlr?=
 =?us-ascii?Q?XDmqh4GhndnKsRia+UXBe5kFoLrGkUXqD7OC/UPcZjRxyv/445xx252ajMnt?=
 =?us-ascii?Q?J9uSRPnq0iiXYH9/gLQbyMx51rRjDO5YtJsKXyjA125leoqczlBt/QIJHOE3?=
 =?us-ascii?Q?GjW/74RlYi5gLdZMzJ2oD5z+pKkNJCczObuGXli7y1JBbqWIfvjGmqM7toC9?=
 =?us-ascii?Q?EoaYIGOX5c6e1v0wdVzU+x94L5P/NzqV7cjxGcATDthT5wCbcfdDxtN31WWJ?=
 =?us-ascii?Q?Jx5mM4Jg+ZdCkhCjExze1jhWD4WmqiLpT+s0+ryydHqEg0K4M0XopZkZ+RfD?=
 =?us-ascii?Q?e/0HpSk36aS+yj4bmeCAjvaMknbRuIcJR/n9jUyr1kP6Hb6a+4aWB6MDzUnc?=
 =?us-ascii?Q?H/eef/eA3o4cxpm9XM1/VRVzcG2SRqka5u3FmZOzoWZc1me26Fxjp7mcK0Z9?=
 =?us-ascii?Q?lo3b2S2hZDKZHrfKhuieeX/gTvdlBSHWXaIHZRj0qXSkrHn5MatGlDBeVGbS?=
 =?us-ascii?Q?ucdwBjIa/s+FMEi7TV+ZevZeXqbxZUl8wyVzq/Z6KzE5HmzulyVIchA95rKt?=
 =?us-ascii?Q?Zt3ZEiBOHEn0kxzw5wq7Pu9+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e03d3339-9ab1-4af5-7b12-08d926d491bc
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2021 21:14:27.1065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l2R+sw7kSkWL0kp8Ey6jIQaSGcefiI0ebHrA2mczRYkjcTjXdKeO7mhoas01NNNZiYxb1omulurf7P+9fSuysA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1748
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Jun 03, 2021 at 11:33:49AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is an uppercase letter I in the text instead of a lowercase
> one. Fix this.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/edac/mce_amd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
> index 43ba0f931629..27d56920b469 100644
> --- a/drivers/edac/mce_amd.c
> +++ b/drivers/edac/mce_amd.c
> @@ -431,7 +431,7 @@ static const char * const smca_xgmipcs_mce_desc[] = {
>  	"Replay Buffer Parity Error",
>  	"Data Parity Error",
>  	"Replay Fifo Overflow Error",
> -	"Replay FIfo Underflow Error",
> +	"Replay Fifo Underflow Error",
>  	"Elastic Fifo Overflow Error",
>  	"Deskew Error",
>  	"Flow Control CRC Error",
> -- 

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks!

-Yazen
> 
