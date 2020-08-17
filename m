Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 030672477A7
	for <lists+linux-edac@lfdr.de>; Mon, 17 Aug 2020 21:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732842AbgHQTve (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 17 Aug 2020 15:51:34 -0400
Received: from mail-eopbgr750079.outbound.protection.outlook.com ([40.107.75.79]:43281
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729088AbgHQPSc (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 17 Aug 2020 11:18:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTWXBTt9ucjJPqBTliEpbBaaOtdSPwjpjWIoD1To5rhesYG1B9nGscBMgSgtNdDxJJlA3Wbw3e44fr1t3lJU+Fqtb+jQRiLqDu2x67BornAbF8tw6RNThl0s2YdlUFm7I5HBxEh3G3M4fJdsUo+lZNXXTJgK5yru6e/v5IAHp6qf/Q1tyJ4AvoxuYlIxPIG3mEUZtG6JKXPkCXJmWjWbfJgiyI7lAJt2d/4EqBdTtvda2HEkUmDOTYDiItA6esqABS2kwCksuOOtwz7t7Ngeqgl3pJPbgQZzrxhN1YZpn5N/RNm3F45t3idxhml02wNIhR+8EUjT1FH9lwNMD6TgUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtWaFkLwatG3eoF1Vaf674r01GT6enB0ABlDnlGefhc=;
 b=FQBlpmVP7rL5wlRlhFvxCLqA03x5YGZuCpchb1qtT5tVWWiC/CQgQxAfnOexgblIlauYpBDNF6B0Atv9C9DpBCQ5XCsaIhMGkYOneMSi2WWh8sAuKHmbfGthpJGblUhJho+GMsGzP+FbnnAG/oPcCKrNbo7bKeazcU7WH/V9bTY5qoeEqDHxnNzuOdSSbDiiBu248aVsIzHxvwvH2TyP7zS/UIyqahWMRP3FuUMi6sIczStV9xVn6KX1hZahVzmEZg9tQvaHSfu4gnvnwSFYKK/OKKOuH83Ebpxhjocd+q3IaS3Ex2PkpwCPEMGmDpbsbG3yS/F8VCROqwn0Oadj0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtWaFkLwatG3eoF1Vaf674r01GT6enB0ABlDnlGefhc=;
 b=l/hLxTcq+rDQnrvk3JjIZXia33OBHmKIZfPXkU9EjOU9ylcTxsxUyDmVr4XMC8/L2MMG9pSS4SXOBE0ewko5BE0GVyg1T8GldZLcTVS/T8NGH3PUCYkbthU57bvxnap2N9GN3rqQ7Pr/Nu5LmJGZzWp1ewDi4vQHl9RgGjrERF0=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR12MB1379.namprd12.prod.outlook.com (2603:10b6:404:20::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.23; Mon, 17 Aug
 2020 15:18:29 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::1ef:8f33:480b:e2d0]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::1ef:8f33:480b:e2d0%4]) with mapi id 15.20.3283.024; Mon, 17 Aug 2020
 15:18:29 +0000
Date:   Mon, 17 Aug 2020 10:18:21 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org
Subject: Re: [PATCH] x86/MCE/AMD, EDAC/mce_amd: Remove struct
 smca_hwid.xec_bitmap
Message-ID: <20200817151821.GA1095089@yaz-nikka.amd.com>
References: <20200720145353.43924-1-Yazen.Ghannam@amd.com>
 <20200817093956.GC549@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817093956.GC549@zn.tnic>
X-ClientProxiedBy: DM3PR12CA0093.namprd12.prod.outlook.com
 (2603:10b6:0:55::13) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yaz-nikka.amd.com (165.204.77.1) by DM3PR12CA0093.namprd12.prod.outlook.com (2603:10b6:0:55::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15 via Frontend Transport; Mon, 17 Aug 2020 15:18:28 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3f3774bf-eaea-4375-89f8-08d842c0cb6b
X-MS-TrafficTypeDiagnostic: BN6PR12MB1379:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1379C655D342CC128F4DB4A3F85F0@BN6PR12MB1379.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PTWhaS/7YXuUeF6NHcVMjRcO9PW54ui/dmNMGUxA3RGPXtdsM7oLzQykmkLQRtQFI/L0tJsM3rVnSjnM2ynxkXRGp/BjDBUs6Hdn03xiobvoAiUTkZ61KF89+hKIN4pXhkS7ME2egmsvVxYgss8cLj719CJDBg3AEJt7ot95ZGNSV9mCLNqbQMq2L5tERnpH6kiP9ixBG1b+rgc0b8YWuLCuj61utqkYxjXJOxRvOjGuNAqUOGwAboIUUsNHd8mxnE7C2VC4NIzPkBsRcfCPt3eDFiyqIqKaIlKf98aLn0ObSQ5qASLGITDuJsVTMr+MhKQn3SvAFX9rGtY+iEZA5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(366004)(136003)(346002)(39860400002)(66946007)(2906002)(66476007)(66556008)(4326008)(8676002)(52116002)(7696005)(55016002)(1076003)(4744005)(86362001)(83380400001)(44832011)(8936002)(16526019)(478600001)(316002)(5660300002)(6916009)(186003)(26005)(956004)(6666004)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: YafB6aEAbXr4KEIGNoh7V4xLMamwfm1FaaC6LMMh0fXw7HwGUxO0S8MLp7R7m/0e02Tf7Cizi0WlEmaS0dUlyCfWW0THlQY4YKIQyqhlqWqfTUE/gCNdHP3ajflauOl7FEjiNNHg/DOrqN/6yAxeRZqzuZ6jPAlv6tBFCV1YApgU4EdXQPrOXmtu5/6xxxyDMFZT11kazSgdDot9ByM5XDjsvpzBNZD9dFA81QoR2XCRqZ2t8KmeFdotj3CTKeRDOzRgZX7AJOLXALzJaSQ7HUFuSbIZlBKIIb9bpn/Jum+qaT2hhVqcwdrZeY+HUzceW3qhUvGfzGuRejsIEkikaWbkH5mH9Zfg+2e7ZE0PKDvbirc9Nh4yWWDzCNrBGy8BoiOdR2B/u/sIqGVWUd0suid7PUj7+9609LW/THpqEd+ftoHEZeRtQr6Bv2kPwaPkW/9HP4Y52ycr6dj2x2qznrOWq23UV+8rO2m8vmvUXJRSIroWQwGuT7yWL3nY4Iuw+uvZGPWt63Lzv1qftqwLtICCFxoCDFMYcAwvRnIm3ooAwm1QqxaAmv5tJuKlLRob2T6F2p55sgIuU/XkFCZbyhOXnKzQpRBPi4JSKHk8cxp0hKFE8R4z2D6cR6qkNdQqjRmd4AHNdyb/Rk3bdo1gJA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f3774bf-eaea-4375-89f8-08d842c0cb6b
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2020 15:18:28.9100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kTbDKjXHNMHiNaAxYm5O4w+0c80cZidks7Q48w1ZFtfCEHrBvwaGQFh/MKGABtDFhXDizCAJB4dMgmapZIi8qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1379
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Aug 17, 2020 at 11:40:07AM +0200, Borislav Petkov wrote:
> On Mon, Jul 20, 2020 at 02:53:53PM +0000, Yazen Ghannam wrote:
> > From: Yazen Ghannam <yazen.ghannam@amd.com>
> > 
> > The Extended Error Code Bitmap (xec_bitmap) for a Scalable MCA bank type
> > was intended to be used by the kernel to filter out invalid error codes
> > on a system. However, this is unnecessary because the hardware will only
> > report valid error codes.
> 
> That's a kinda bold statement. :)
> 

Yeah, I'm trying to keep "may" out of my vocabulary. :)

> Are you saying, you wanna trust verification and that check is totally
> useless?
> 

I do. This check was added because I wasn't sure what to expect with
this new architecural extension. But after a few product releases, it
has been unnecessary. And I don't see a need for it with future systems.

Thanks,
Yazen
