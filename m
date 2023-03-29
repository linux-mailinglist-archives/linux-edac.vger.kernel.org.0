Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C4B6CECD6
	for <lists+linux-edac@lfdr.de>; Wed, 29 Mar 2023 17:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjC2P0Y (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 29 Mar 2023 11:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjC2P0X (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 29 Mar 2023 11:26:23 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20631.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C49191;
        Wed, 29 Mar 2023 08:26:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vm32pyWYUzH67wCLx7frsuqp/bejG2u8XPyGdmIljYcaIoZGDxouvGEERO2Eb2aScwOqFdYjrGD9a3KdLqX54lBbHwqEcUvRxsxgTVzffvYaMqffU74ZBECPlEnCBU/0UTenFO/I2pqNIt2LWv1S/L3Gv7+o65ayZ+FfWk4HMt8CLOn+QAZERUGD2PbKYb5vdAplFfYqjsD2pPYm+f//Ts0rVvVNsClRuRBtPdb9iHwj0RHBuSbBedqfe0xEozvSGJ6CVSGmsZk/WpeHdkDltJ/odT3Gb7pGx1xQkKSPSBXmhM1HF03XlzqDLnIxheUt0XBHHS8vTuwHFuWH7RTGzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQGBeU2mY1GkNGJKu6ksubOaWnxXFQY6SqRuSavfV/4=;
 b=RGIN+guVLZ1vAmwDm6EasV7iGFkz1VXUQi5UAHT6M5BY+zcRm6F2YFez/sdkWlJE8hq9X0JGMxP03TPGyZOkySTAu7UWftNaoWTTNBIkRi78vcgOl56pa/hItAo6agGEhlAEUieCzeyAlYrk1Ojq0adlVY0I18YSZMYdot1XsTxuC5+Rydav/NXW9KopZnZWWQttIYAJjCIzqMjrbsXweuqiwNy20/9tHTMQxs/9oPpEKtDnRpeakxB8w6JUKLqc/D2ccOHP8jAvqvF0CN6i+RviOD52kbGyLgRIjl+fQngRJH2JVk76l0tziPJ6LTrLXwGYoPAXmzrwfO/qvxG5dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQGBeU2mY1GkNGJKu6ksubOaWnxXFQY6SqRuSavfV/4=;
 b=h2NXNgsZxp2Vfjw2ADzSaRH/bS8Fltcr6yBny+xqKMbPCLdbiMpnG4f6HRauw8ue+3G9G79M+x27w6mQwVxl2/cMH+9ayTsEshp2OHlrPSZ6ohU2HqMeEgUHUFJl6PHgrtw2DqseYg5JKn3qco9pKTT+JGQ3zJk6NDfdKPsoPlE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by CY5PR12MB6129.namprd12.prod.outlook.com (2603:10b6:930:27::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Wed, 29 Mar
 2023 15:26:18 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::e62f:89e5:df27:9e45]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::e62f:89e5:df27:9e45%6]) with mapi id 15.20.6222.030; Wed, 29 Mar 2023
 15:26:18 +0000
Date:   Wed, 29 Mar 2023 15:26:15 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        "Smita.KoralahalliChannabasappa@amd.com" 
        <Smita.KoralahalliChannabasappa@amd.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v3 4/5] x86/mce: Move storm handling to core.
Message-ID: <ZCRYl9c7xgIJ+pJe@yaz-sghr>
References: <ZBR+GMH0olGoDMGs@yaz-fattaah>
 <20230317172042.117201-1-tony.luck@intel.com>
 <20230317172042.117201-5-tony.luck@intel.com>
 <ZBxvyqb5Mnt13341@yaz-khff.amd.com>
 <SJ1PR11MB60835D7F85097FEF454DD74CFC879@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <SJ1PR11MB6083D33BC6860AB9FE2A292BFC879@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083D33BC6860AB9FE2A292BFC879@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-ClientProxiedBy: BN9PR03CA0513.namprd03.prod.outlook.com
 (2603:10b6:408:131::8) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|CY5PR12MB6129:EE_
X-MS-Office365-Filtering-Correlation-Id: d2181773-c306-4620-201e-08db3069f183
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rsme/N1YmxNx3bRm3COy24WiUNEKtGj0z4dMvZrhA0OAbWcH+xxN6cWORvWXS8L4xVGW0/Rsha50qfy1JwKDg9fiDjybpOSTexDFbnuOdQQfymhDFUDRCZPgOEQyai0iMCT4hWeVCiraP8ZhZtggOuyvAZMf9DzmhDhKsrKuPA21rJzpAalhsy7Yojo286jPgve8Ne5y04NfsngiFSrd/fnCR8Gb+Eeexe02nXTVidhUo34TDEJbPU+xDKI2CX29b4h5Dg8Wp/P0DFdl8HZM/rYyxhoIner6oVgAKstZ1ih9gK0JpoOMRvMwq2mE7HbQSRUCrQAFfKR11RQFrW7U8RfPTnaYPSid3nSEdHaHAsLanCSwvTR1WKWEA+6efoZ+EP++jPy7fX/PaHUh9euuM2MorTxY1qLYlZKxTlrVLCoqCec/ri+vBuwM5OYXAEPPCohPvsiN0tK6ZKBN4PvnP68YFQAWK1YptyqpI+Sgal2VNLcYhN2owKaTRbtcvEMcqLWYY/Fza1U9Vhm3CiCEUHYYYjHk60/yHAng8ifj2ht9jlri4qJa+UTku/XiPibSy2JeQNjmxqAgTSfJdBuYIB99y58mSsL0b+GdTZ5yTPk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(136003)(396003)(366004)(346002)(39860400002)(376002)(451199021)(8676002)(66946007)(66476007)(6916009)(66556008)(41300700001)(2906002)(5660300002)(186003)(4744005)(38100700002)(44832011)(33716001)(86362001)(4326008)(478600001)(54906003)(6666004)(6486002)(8936002)(26005)(9686003)(6506007)(6512007)(316002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ACPZiYKqEO9dLEd7zdBfNItwGkkS3jNMrURjtqxK2l1sqgIPVxEoLyC6gfw7?=
 =?us-ascii?Q?Ae7GJ0pWn1F6nw/1LGopn7NoZBDl3cOEqllhH6G9ZaxQuFLoLX/KJUFPCcMm?=
 =?us-ascii?Q?F7dWmkMdlRx5boCnJJTx42sjDs0JSF7XQ6wRN3QXdtGG30ZkcI5oz5IICam7?=
 =?us-ascii?Q?y5ZX4JeQ0GAhDGh6fYK38+MzuHGcobF+0c42zQU8BLDGSRtll3LmIWYovp+U?=
 =?us-ascii?Q?x4V4Gm+0Q7/YFzWEK8PZI4BpUCM/LTB0fM3wlKpvWO4bkFV3wlywQmo1q3g8?=
 =?us-ascii?Q?6h045sEU8neItDvx69Kf5N628L5NGq9TRTRTZhT2WSbvlwx/GywmtT0nsuFi?=
 =?us-ascii?Q?h8wTFS20xRF+IaDNObTSIqt2ysJv8DhYP7J/ZCP5PB0UpRlHPCUTpjk9beoQ?=
 =?us-ascii?Q?iFyayPjA20C0BotPTyJQpmrfn32ImKg+Unv/3LmZyBGjttpC+ay+JbTFj6MB?=
 =?us-ascii?Q?SWHQffdw62y4s3Fd7cf3OMGhR6DTR+hqp4tXR5pt7OQCuOjEVF+a/+ePppx7?=
 =?us-ascii?Q?SxuI/wCL/t0F2f8TCwrFDe3kuRP8cRQKCTidCeW6VxYd+DqgKSD1ORdik1m6?=
 =?us-ascii?Q?FxmH8Xxy9hQTwXqd+TamSed9+853L9qyjIhfRbtiCyn3zc1GUDWY4u1z2B83?=
 =?us-ascii?Q?TVAtODex3kZkrSbL04s12/TQU0nnP4zZ88cJCxDSR0DJrSFpSl6T6ifNmeCr?=
 =?us-ascii?Q?TRlwuYY60ndBM1CJhKsY9Iu3bFAr0REJF9yd3qB4sreB208aQbZPcbyUq8Fr?=
 =?us-ascii?Q?UXPLWvS6hCwr5406B+am/fOjjKoMYqwtMignjOafrJvsWegwBiiH7aocDctQ?=
 =?us-ascii?Q?dEYXoHdgGKvu6tXGDRjARqMnAAKC2RAGvC+Vy4dA2aJPxEX9bB/rP48dVcNQ?=
 =?us-ascii?Q?F9XMeUx6zQzchE9nM38y2N1NVYyIl2X9qdBE9mdHtwaiy7dFFqzkEbx1t9oX?=
 =?us-ascii?Q?GK76EG7i2na/aG/clLspgT3x+9HfZlXA/Yqai+l6eZfU2mcYgMKCotzBH4Li?=
 =?us-ascii?Q?mVXhD/u/B2dD7fcNZAg1elDRDzl0ME02nrpuqg9/bjnvgegzIGogN90uk8gw?=
 =?us-ascii?Q?+BZdrZhGmdMNo2jkklfDD4DxJ7sZP0miIBSaMgPdpZp8teyzAaMcoxmvH2h3?=
 =?us-ascii?Q?ENhS0kj4QaSfXlPPr3IGa8RfoVDK4XJlI0bmYsvefem5DdiziqPHOdImlJZF?=
 =?us-ascii?Q?2Vywz6suVaq3hO+VzX0QFbtGT7l266QD67Monk01VaAMy9lXwKjnrH9PywqG?=
 =?us-ascii?Q?RM+R8v6ZvuACNvc0sg+6fB2WWYl4wANJoMqyNftdfRv74T/b5Za4mVs9cXnX?=
 =?us-ascii?Q?VS1C/6Cym/McnS5jZZlUN8hwdhvZCEiCeNZ86ZwkLAUM7xLRXwf1mLLhh3Pv?=
 =?us-ascii?Q?+UdSaLzGNnqqWi+Q3Rqk3a9mxkaFD2MLkt8CMqkAQeyLC7peDu8EKBACmGM6?=
 =?us-ascii?Q?m04JN7BHDAWgyeShenXlsxkSdUK14KKkSgdMmjyMpWNQw9Jg2au/1SFQS5P3?=
 =?us-ascii?Q?4ltsLLCv1pejgTftaOL1TCmvcIdbTrn6z9uM0dT0/VTClkD2le/yPnUSzig/?=
 =?us-ascii?Q?B3lYd5hGqbQRzpIifBbcggXxL8uvHaWFanOAkmK2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2181773-c306-4620-201e-08db3069f183
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 15:26:18.6355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f++RFcvJT3nBcnQ1Edrztxuv3NpcKLIxKUINEWcV3J9um537fVcp/i4gvggRYPl0lalyXkYfjf+6PmNoGMqD5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6129
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Mar 23, 2023 at 08:26:02PM +0000, Luck, Tony wrote:
> Yazen,
> 
> I folded the fixes for the issues you pointed to in patch 3/5 into the series and rebased to v6.3-rc3
> 
> Resulting tree pushed here:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux.git     try-storm-on6-3
> 
> Builds, boots, and passes my storm tests here.
> 
> How is testing going on the AMD side of this series?
>

Hi Tony,

Builds, boots, and passes my tests here too.

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Tested-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks!

-Yazen
