Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCB172625B
	for <lists+linux-edac@lfdr.de>; Wed,  7 Jun 2023 16:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239831AbjFGOIz (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 7 Jun 2023 10:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235770AbjFGOIz (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 7 Jun 2023 10:08:55 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD241FD5;
        Wed,  7 Jun 2023 07:08:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KCmxOSP8ac3FpLSKrFtlXlJMO417JTMFZrlcU6NanlL6tMFlPZ3DwnG9K9rJbVNGLhSmf+4nbtQ4GAeItFjXMDaumklqVkX3YHovU938vWqEMbn8e4TD6EWB4P/hOI0TgWONWoqkMIYQ6uNPTraIPjr4I3rlwi7ahJ6q4TESYGgFDYfKm3/stSv1ybRTelLsItR8sYnLPHHJ5u83kEEaIFR9rsAk3vKwBFoq/Gpi5ApjKRKjR1O6WxQIdgx+5lo5LFiSNuAzfP7ifpAzfNLC/R+2fXuNa68u55lRCT6o1Kkkox0c9haXReOJz35NowYAhaHZuhr4H/MBn1xcsTIptA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HmKXde6l//YB9SvA7td1OEZ0SiGiJJ2TVtY0yfV9bH4=;
 b=V0qC+7LUe/mLh0ShZPvN7bm8uyJjxcc1VRPJnyt38jUZ/gdP6f1VJtQXn+MEDgZAGw5RVThYKlnXp8P0Cxp/vpJwb6ozws5gehv8y/SHW4j/BQIsDzLF0kKVR9HFY3i6JuXPquDOf9l6VGwh5rb1EZDSujCZZU9yYV24AHa17LGWeVnpXs+Z52TpHIy6kKV7QsxiAw7RfrP9UcHrnSPVmzRCHb5NKcFz+xLeV/9cPphAXuyPoT41+PGqZdqkIe63lfhlwgIuwtRvOoJcU6xFjW3+0fBml2PWPzi4UE9860YdOnZJOc9oo2NhE0qZlanQUerKXV0sY+pkHgyOIQPbZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HmKXde6l//YB9SvA7td1OEZ0SiGiJJ2TVtY0yfV9bH4=;
 b=KQrLIYgF74FexpUATK4FJ+9XPJyNLKl6QzquUc0bfklbO02P7nWvGmC7pPjoNV57QeayDUk8Got25ms70aQgK23xttqgMu/bCGUTGQfs2ky6USvlsWQtUa3z6mwj23EARnA0Yol2vu9nNqi1EJV4iULBBLXjxqxxOh7t+W98mCk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by MN2PR12MB4238.namprd12.prod.outlook.com (2603:10b6:208:199::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Wed, 7 Jun
 2023 14:07:52 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::ca6a:7f77:6bb7:17fb]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::ca6a:7f77:6bb7:17fb%3]) with mapi id 15.20.6455.028; Wed, 7 Jun 2023
 14:07:52 +0000
Message-ID: <c84f5983-930d-0bbe-b7fe-01875c045815@amd.com>
Date:   Wed, 7 Jun 2023 10:07:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc:     yazen.ghannam@amd.com, linux-kernel@vger.kernel.org, bp@alien8.de,
        mingo@redhat.com, mchehab@kernel.org, tony.luck@intel.com,
        nchatrad@amd.com, Muralidhara M K <muralidhara.mk@amd.com>
Subject: Re: [PATCH] EDAC/mce_amd: Remove SMCA Extended Error code
 descriptions
Content-Language: en-US
To:     Muralidhara M K <muralimk@amd.com>, linux-edac@vger.kernel.org,
        x86@kernel.org
References: <20230523085550.391768-1-muralimk@amd.com>
 <20230523085550.391768-2-muralimk@amd.com>
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20230523085550.391768-2-muralimk@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0170.namprd04.prod.outlook.com
 (2603:10b6:408:eb::25) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|MN2PR12MB4238:EE_
X-MS-Office365-Filtering-Correlation-Id: a59edfe3-4d1c-4014-bc9f-08db6760950f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7pAK2C4X70WwcLzG1RsR6JNi0dSr0WG6bNXWQyNwrxiMI+pZi743Uo2joxiK4Jsj9dthB9ri0bdA9MNq+OyEz541fBhkM+Y2It+RNqeZGxXtN3oX/U1HpEnsxfNv0POnTV9He0waq941BYE4RNYZPN498msQZmqM8yfz2mB/FB8UkKxmuSN8Lw/6ifZbjQ6V4POB4TQICnAvb5j0P0yEeelhOFBrKTckgDuLFZ3Odnm3PhhtvoncLcBHA0AwYI3T4YOzY7b1sRanrCC4JIdMhQcf9SMZA2DOygS7D9bisXLRWioYXO33vRaYLgMlK+fOJ3SmBuVIuujL2g/360pmy+EHqKMUfPYUgdwS/52TiooRYXgmywHGlo9w4RkBG90UosuHqeG1lkp7rZ9jpI13VYJum+rQ3odj6tYx/+Rb+brwy0rwO0Xd2tNGN8DLnZMjBNnzGAp1MRzC5eFu0dshYwi1Rpb30zjdeixDYJ5uTt4myDlr6isOGLbXRsY3mpYbbs/zT5yZO/RPxzcdO8u0W/f2nlMnBZY65vy0kMXBqKNstcVAyio7gDG1ZikynzmlFR2P7rmpdoycsPWhBafVWuDxLJUQZTAPYbOg5VA4lhT4V6iUtDKxN8W6OuHfT5BKEzoN8+vnLRVXVVNjO4VoAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(451199021)(6486002)(6666004)(2906002)(66946007)(66556008)(66476007)(36756003)(38100700002)(5660300002)(8936002)(86362001)(8676002)(44832011)(31696002)(41300700001)(4326008)(316002)(478600001)(2616005)(53546011)(26005)(6512007)(6506007)(31686004)(186003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3ZFYVBlTTB3VTdvNlkvM2s4d1RDVTc5UzNnMmZ6MlNWYkxZNnZTbjlBQzYr?=
 =?utf-8?B?dnBYb3ptZDVMY2w4bGRxdHB2bGxTNGI2S1d3QlZIRWZuRzhMMmNCTnF1cmZh?=
 =?utf-8?B?d2hrN3FpOTNZMHdRVllrMCtreHJ3UDh1ZkVuQmtRd29mcGovaDZHaFBEb1hV?=
 =?utf-8?B?MGM1YTBQVGwvVG1LUnluaXkwOWNxTFE2UmVPTjJxUjZDeWdwb25JblJZbmVC?=
 =?utf-8?B?L01SN2xvdE5MdlBIUkN5RjdtK0lGOG95R3N3YmN0cS9aM2dlNmw5V2VCR3Fa?=
 =?utf-8?B?c0l5cFZ3N1FEWGdKdjFWWnAvV2diRThPU2FpZHVqMlJmcXVFbUdjZFZXMWJY?=
 =?utf-8?B?VmxvbC9YcTZSQWxlaTJOcDRIVFY3dHZYTmxkQ0JyL2QzYnBTaDd3YytrRkJC?=
 =?utf-8?B?TDFvYmlnS0pxMjRNZkhLZ3VWaEF0d2RFWGFrNDRhU3ZaR2JmcTloRW5MSUVl?=
 =?utf-8?B?bFFoYzVXem1uVURoNHl4SDRnd0F2enVqdW83V2ZuTTdjb0NJcmxRMkEzRVk3?=
 =?utf-8?B?c3RKbkN4aSsxQ252T0JjLzhGRE8vbk00NlFBcjhXeVd5VkZyV0NjOWEzRG1Q?=
 =?utf-8?B?K2VEaEQrcS9qNGpCWFJPRGJBc0hUMHlQanlTREZJa2dJOFV4STdNZjRMRlhQ?=
 =?utf-8?B?ZzNsMitaalFsZlhHelBSVk5nbVJnMnFmdTY4RlpPV3NoaXE0MWJGUnVlejNu?=
 =?utf-8?B?SVNxZlBubFA1S2FuRFBXd2J2MFRwKzRrRldBRnZsOTNjS3dHR0czNWJUVmRa?=
 =?utf-8?B?UVJ0MzlqMFl4NEgvTHpnVUhvaTB5QTFsWWZxdVhvQjZGeFRYS3pjck15djMv?=
 =?utf-8?B?bFhRRGxOZ05lZXBmak5WS0xTeW9aNm9oVE1nMFp2U1ZCcytGa2p0YkRUWTJi?=
 =?utf-8?B?WUFaS0xHeU1icVFJc3NiWm9ZNC9TVldlNHhTWWlXeHErT0xKeFJJSVRjTkpy?=
 =?utf-8?B?MXk5M0hnOGxVOFBoRXpuWFFWdiswRkFCV0gwWFhSa2V2WkI1blpaN00zVWZj?=
 =?utf-8?B?cVNuQmlIM1NZWU8zaW04YmRrdERNeURrdlk0ejVlTFFlcXFMQ1lOVHlZS3VI?=
 =?utf-8?B?K3pYZ1pzYWdvZ2VaTDEwMTZ2VVBBM25sWUdScTZmZDN1Vkx3OFZqaVdqc25X?=
 =?utf-8?B?QU1LUG5lWkpobmIyMXNLRE5NQ2NyVk1wanc4K2NmSXV0ZjRxdnd0KzRFcGVN?=
 =?utf-8?B?ZHR0UkpEWEJxaUtUMUVneS9MdWlBMmdPL0FEakNoYUN0VDd3NWRueTBGaFRO?=
 =?utf-8?B?Slc2dC8rMlV3SGRLYTIzdlljNlBMWHdEM0hJa0R1V2Fjd2VkWHhZdXNpQkE5?=
 =?utf-8?B?dzFrMW9sdlYwRkZndkFRRlZDZzUzcjZ3YzJpNzFEZnpGVVNaOHVvQTRsOXpw?=
 =?utf-8?B?RDg0ZVlzbDBiOHBINEQ4OTEzaTFmRmhqaVRINVhpQ2NaTHpNMmNFcGdUMUVT?=
 =?utf-8?B?eEFsSk5kOCsyYVhmOC94MFV3VWsydkF3M3BwMWc2djgzZmlpeGVyT29jWlI5?=
 =?utf-8?B?REEvRW1QSGdQR3BBYUpkVitpNGRKVWZwSFRnWUlXSVRaQmg0VHhuWFBFMXNI?=
 =?utf-8?B?M3dEaEtkeE5mMWpKOHBRTzkvVXJLZDRjQmZQSjhBQllXbms2aW5KYXJobGFI?=
 =?utf-8?B?YjdxcStjSHpINnlyaDRVZFliRCtEYzZSTHkzSitzRVFTLzRMK2EyV0hmN1J2?=
 =?utf-8?B?NHJIaThTMDUwTlFjeU9pRHNOWWIzaXVleC80dEpJNXhqbWtkeVllL0FCWm5v?=
 =?utf-8?B?QWdLajJ4Q1duNzh4UzRtKzRXU0hQVWRmMEQrRGYwNTl2R3VVOGdMRkorY0wx?=
 =?utf-8?B?Y2ErNC9lMWV4Zlh2Vk1saWpGdnNaUmhDVVZhSzBCeFplQkI3bFgzQThVWk5Z?=
 =?utf-8?B?eVJTcExDOGFhVzJ4aTNxcmFrT3pZTnBCQm9hTjkyb05VcFczTlF1RHZRUGtN?=
 =?utf-8?B?RnNDNndGdzQxbENoNnU1a3Z6R1prMStaZERFMVo4N1FINDlCZjVXZWFaVloy?=
 =?utf-8?B?dVFUL1VLd3lNTjh6a2w2NzFTV0d4SC9FaDNYTEVKbzFVMnI5K0daaE5GZ1ox?=
 =?utf-8?B?QWFoazNmOTdKOXFPTHpFdUdOZDZvMzZVSHZtOE5kdmZpaWFEU2tWWEg4REFx?=
 =?utf-8?Q?pyqCH0YFWENoYOvHa6bZwZCHk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a59edfe3-4d1c-4014-bc9f-08db6760950f
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 14:07:51.9750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MGhFGhSV509R3YmLG+aCgdWT+0cM0XybYuH8xePS3ADy6d51PgRV/XcCC2KrZ/RAvulupUvvt7bDcxX1aMMy0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4238
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 5/23/23 4:55 AM, Muralidhara M K wrote:
> From: Muralidhara M K <muralidhara.mk@amd.com>
> 
> On AMD systems with Scalable MCA, each machine check error of a SMCA bank
> type has an associated bit position in the bank's control (CTL) register.
> 
> An error's bit position in the CTL register is used during error decoding
> for offsetting into the corresponding bank's error description structure.
> As new errors are being added in newer AMD systems for existing SMCA bank
> types, the underlying SMCA architecture guarantees that the bit positions
> of existing errors are not altered.
> 
> However, on some AMD systems some of the existing bit definitions in the
> CTL register of SMCA bank type are reassigned without defining new HWID
> and McaType. Consequently, the errors whose bit definitions have been
> reassigned in the CTL register are being erroneously decoded.
> 
> Remove SMCA Extended Error Code descriptions. This avoids decoding issues
> for incorrectly reassigned bits, and avoids the related maintenance burden
> in the kernel. This decoding can be done in external tools or by referring
> to AMD documentation. The bank type and Extended Error Code value for an
> error will continue to be printed as a convenience
>

Minor nit: there should be a (.) at the end of the last sentence.

> Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
> ---
>  drivers/edac/mce_amd.c | 480 -----------------------------------------
>  1 file changed, 480 deletions(-)
> 

This patch is completely within EDAC, so it's not necessary to copy the
x86 or TIP maintainers.

Also, this patch was sent in-reply-to another patch that is not related.
Each of these can be sent independently.

Otherwise, this looks good to me.

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks,
Yazen
