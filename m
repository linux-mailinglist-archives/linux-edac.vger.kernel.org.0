Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 691204E583C
	for <lists+linux-edac@lfdr.de>; Wed, 23 Mar 2022 19:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240730AbiCWSSJ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 23 Mar 2022 14:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245500AbiCWSRw (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 23 Mar 2022 14:17:52 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7E188B2A
        for <linux-edac@vger.kernel.org>; Wed, 23 Mar 2022 11:16:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a0ki9ryw0PEOR+zeuop6oh1o16xwT2Lm7Icc/slcVPidEORQeEs6ZnfTpm6VAys5fSUHk1NBJGJWYBVHjdjB707SZc3PkshXxJ9hLbqDhjcP96389kZ3d7leJ9UMfEBds/a/tX/ET8PQ5qUC9KEDWk5Q+scg/bfrbZ2T/ZkXpwvEfeOxDYBrJckptuk6giEAsNGmByN9hPjWde5+IlINrPhd8IU0owMDr6dlpEuLVG6OuM1LnmNaAYTuAJljdz4cGllCnuCndGsF/8W1EQzqX1QTKZl6mYWxw1ccVcK2T7JMptUgANy/l8+j43r0Q5yugPH5L83XfDM4E6HhPdUp7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FhQUT2CGgFPXdkSrpShJPUzWuhwWZiVhjlIz66pj3TU=;
 b=gUcAl/v4XyXK4UYdu4srVbtqzQsHQJOh9Hnqa2kJ+pCpUASqRWatm0+i07Hec7xn6eGUliWAsnraib+dM6e3VkY342Q+0smJlQe75u/8ekSYxXV+CIq29SPnND2W54fovV73J6/5+ieqh0U1hYzqDkLt5cYRr0pWmuLvWk8HnpHOF/qVRqZFOz+qP6tCuh6AWGuafbfZ4etgyvHDFfnvsYZrDKRHUXJC9abvJvJKy5dVH6Xc/LLjBUBzE6Ch+Rthzv3uSjbE6oKnqTlBNW/IbeKxFAUUdwo/NXalbh0HA1Afzr63ziYOwvcnxTgAPS0QEnU5V6dwzzA18u4N1sU3EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhQUT2CGgFPXdkSrpShJPUzWuhwWZiVhjlIz66pj3TU=;
 b=xd3b+JUUg21cQ5RCYDGqjALlKjlolm2OZEIacLhREJlbb10ELQ008sOojvwmSls92hQ/bD097ODq4G9hd5iNGyP3CEUAGvLUcyRY/VS+AyBU4/9PCc0vubpi/vBjrbRNeApE2QRXYaNfC5wPPdFatpR54qtCfuFOlyff5ef/Tuk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by DM5PR1201MB0201.namprd12.prod.outlook.com (2603:10b6:4:5b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Wed, 23 Mar
 2022 18:16:19 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::6589:ebfc:1f11:3df0]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::6589:ebfc:1f11:3df0%5]) with mapi id 15.20.5102.017; Wed, 23 Mar 2022
 18:16:19 +0000
Date:   Wed, 23 Mar 2022 18:16:11 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Naveen Krishna Chatradhi <nchatrad@amd.com>
Cc:     linux-edac@vger.kernel.org, bp@alien8.de, mingo@redhat.com,
        mchehab@kernel.org, Muralidhara M K <muralimk@amd.com>
Subject: Re: [PATCH 03/14] EDAC/amd64: Add prep_chip_selects() into pvt->ops
Message-ID: <Yjtj63QZ8mZGC6p6@yaz-ubuntu>
References: <20220228161354.54923-1-nchatrad@amd.com>
 <20220228161354.54923-4-nchatrad@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228161354.54923-4-nchatrad@amd.com>
X-ClientProxiedBy: BL1PR13CA0096.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::11) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8957c133-2f4a-49e1-c26c-08da0cf93a5d
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0201:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0201C47912E767826B2EE5AFF8189@DM5PR1201MB0201.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YzAfMINETc0okgFLvrGN67/bnC6nJK0YJbxVlspzUbCJJn4U/Sf9hmfptRYl7xDLBU0SK8UikOksLu1yXhUFJwcW4YNdVk1k2PDmf9H8O9Ah4Qb5RsMwhy0dE/kSUXSyFPzU4+i7uFA8oDkKxFm6b/0TUqTzNz8+udn2C3/OxjevIIfnYLwJCLAEjPcuF0MREiek2y5prnXRvORRrUwIECnYH9AKK9WhiKPobLucY+F9inexmVnPo5PS8A9KHfMBbUOPHUGyaWTY9CK9bXZZ9NKvU8xL9yQF2iCjP2NU9wwg5p63TtW3629PdE4GDkGBDkfD1Vl/mUn85U0jIHUBHUUyqJftMVNZwKSAoStU8tLnvZ51uN3Z+cJdSKYp8m8Ngku9HxPwisKfmh0cWXXb6wpvVxuPpkiyIDJhrziYjtojeolARUHwK+9gn/K3e9fW8Wnuu3PAchic2cRIzvM8yF5m6ZwYcDYygKrIH7nWWDJBFDFKQtNbBPBD/usL8qCt4Hpi64gmzfzq6BrCMiOvUeCa12Dk1WbkhxYK+P26DQ7xIAKNtuiBC88I82da+A4cnE1gieZMkgTtEdpGkCL7Z99mxEw+W3DbZ9/Jf8KmA6DsQxwP+9iu8g72E8XEtuAlluRVO/5nLc1CHHuClo7JSFDSDCKkgbMeh8Ow80tqNp/fUxEoLmoscW1SUn9XhQUqJsSfcb34BVGQIt88U0cVByutsb5s4YpojNSMhVbyc1A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(66476007)(6636002)(4326008)(8676002)(316002)(6862004)(83380400001)(33716001)(6512007)(966005)(66556008)(66946007)(26005)(508600001)(6506007)(6486002)(6666004)(86362001)(9686003)(2906002)(186003)(8936002)(38100700002)(5660300002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VWCsz84iokjttUNfUuPafz1o+xvzD/k85E0kvmNJDB6Ry2ucJpIPB6CI6HgT?=
 =?us-ascii?Q?ao3YFUyvxVj9sQP/Hv3fod1bP0vNrbhaiABnFpuCFphhFmRjntm4raL6Hc9/?=
 =?us-ascii?Q?iyhWioDV7arLpAHiKbaPxbkBDMfquz+ghFQzkPwbJZPG44L/BGyaLUihqEEn?=
 =?us-ascii?Q?+WHk4hmNdKNu7jiydrlXeDskSYJbHrMvLtSJyQpDaJYOaIYtKmUkpHzFtQ5c?=
 =?us-ascii?Q?Hwkp/M5G1ovpwTMiicQWXIzcnzqVojHcy2i18Cxh0DLvSXcoSyLIwmEma9eM?=
 =?us-ascii?Q?DVKDBW5G5/tuE193akC+WI2Nb/cWp/v9l0f1+Yg46tgJ2SiihZCnVq+XRMKj?=
 =?us-ascii?Q?A05AAWltUGAi9nPn6OZykooB/jS4u+ruct9bgdkgqIM07GEKIVrcUb2w71JZ?=
 =?us-ascii?Q?2WMC0fxv2zoFD7IO/5GXIfLZEhskHWelCNBNOYzBro4TJcOG2IfEX7Lxv/Am?=
 =?us-ascii?Q?/NxNomlSA+taiMhD8DPKjZAWRjAdpmMwrFtyzHVohHWeWOINiYp6EkbhkG3r?=
 =?us-ascii?Q?KVU2Bkdyk4OPrUfem9FokuDtX1WB3Alv0xCynfIu/yx3yUIyo7uMLxnNF8n3?=
 =?us-ascii?Q?nRJ0ZpMg6un+YKe0wn9oThnYNZKpi/ZOGuiUFmUCHywBt/+/ONlfxF7Gqb23?=
 =?us-ascii?Q?cOpPaXa6TQuRnMvFa/7fiTz2VOi/ZmKZgiVBCL7LlROf1npiPYslLQkAZKTO?=
 =?us-ascii?Q?kjaR9xqlWRW7U7sBpbcnDGtBL4IVgMQjhwv4uHssIdmL/XoWwbQ61goPlrCl?=
 =?us-ascii?Q?1rS1zgt+jAHJGVAoyZALmdknYqYJ1bFjaZQRPbFyJPniI/uxYnobxUJ2hmXZ?=
 =?us-ascii?Q?tJRcIISnYyj4fDDFujv982cwrUrfne65zImipAQLb1qT9lu/o0BQUmCQ0kld?=
 =?us-ascii?Q?pP2df6sW7zfXsIOwPtzHBCH2N0BmUjOFP6VkKkoLNsSng2exsZrzHiLChGGA?=
 =?us-ascii?Q?q0pGAqapLIC2RlyE2z/MbKTbJxT9lAY6c9xOIhrppqyraKsnptj2bCUUAJLB?=
 =?us-ascii?Q?O1bJob/oQvZpd+yV+8PItSUQuqPAfcpWnaTIEULQpz7KFGzefgrFxL38grlj?=
 =?us-ascii?Q?dX09ezqGgmoyfVd0OWDP0Mor/+2hJgXW5GlMkKLjx1Im3mgWxDRy7KFkS0m2?=
 =?us-ascii?Q?MIaVCRLv+MEk6ITQAlrBPoAh3iHUNYpL/TeHfQHSCss/lu7PZklqMAcPt+eQ?=
 =?us-ascii?Q?h8kNacuP08HGGqAZKQbVcD575fdhxOwA4clndcqEciAj7p9x0Ks+z+VvMixt?=
 =?us-ascii?Q?HiI7qvCtMp0WeYF7qBI09w8lsVTepVbx3HaGiWLAeUUCukJN14STOvIcAkH7?=
 =?us-ascii?Q?imAPIAJUQSXQKZH57Ad3tDF53QglOp9cr5Er/ZDRjwchdIo9RV//+lJSBLr7?=
 =?us-ascii?Q?qzZ5yiTo87tUU7/wSsYzFcLNdZHGuZdHpoet2KDF+BONUg7cprRMIGL5jVy0?=
 =?us-ascii?Q?GFuQwiHV9XOj0msxD9fi4/1K12JcNbEI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8957c133-2f4a-49e1-c26c-08da0cf93a5d
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 18:16:19.4146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: teEf5skyJyEZONxFZM5RryOsCeCaJagRyrIphEDugo7QdygAIbKl0DQNc8iAA296qQMutOeSl++smyJXXO6TSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0201
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Feb 28, 2022 at 09:43:43PM +0530, Naveen Krishna Chatradhi wrote:
> From: Muralidhara M K <muralimk@amd.com>
> 
> Add function pointer for prep_chip_selects() in pvt->ops and assign
> family specific prep_chip_selects() definitions appropriately.
>

Please include the "why" also.
 
> Signed-off-by: Muralidhara M K <muralimk@amd.com>
> Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
> ---
> This patch is created by splitting the 5/12th patch in series
> [v7 5/12] https://patchwork.kernel.org/project/linux-edac/patch/20220203174942.31630-6-nchatrad@amd.com/
> 
>  drivers/edac/amd64_edac.c | 68 ++++++++++++++++++++++++++++-----------
>  drivers/edac/amd64_edac.h |  1 +
>  2 files changed, 50 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index 985c59d23a20..708c4bbc0d1c 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -1490,28 +1490,51 @@ static void dump_misc_regs(struct amd64_pvt *pvt)
>  /*
>   * See BKDG, F2x[1,0][5C:40], F2[1,0][6C:60]
>   */
> -static void prep_chip_selects(struct amd64_pvt *pvt)
> +static void k8_prep_chip_selects(struct amd64_pvt *pvt)
>  {
> -	if (pvt->fam == 0xf && pvt->ext_model < K8_REV_F) {
> -		pvt->csels[0].b_cnt = pvt->csels[1].b_cnt = 8;
> -		pvt->csels[0].m_cnt = pvt->csels[1].m_cnt = 8;
> -	} else if (pvt->fam == 0x15 && pvt->model == 0x30) {
> -		pvt->csels[0].b_cnt = pvt->csels[1].b_cnt = 4;
> -		pvt->csels[0].m_cnt = pvt->csels[1].m_cnt = 2;
> -	} else if (pvt->fam >= 0x17) {
> -		int umc;
> -
> -		for_each_umc(umc) {
> -			pvt->csels[umc].b_cnt = 4;
> -			pvt->csels[umc].m_cnt = 2;
> -		}
> +	if (pvt->ext_model < K8_REV_F) {
> +		pvt->csels[0].b_cnt = 8;
> +		pvt->csels[1].b_cnt = 8;
> +

"b_cnt" is the same for both conditions, so these lines can be moved out of
the if-else statements.

> +		pvt->csels[0].m_cnt = 8;
> +		pvt->csels[1].m_cnt = 8;
> +	} else if (pvt->ext_model >= K8_REV_F) {

This can just be an "else".

> +		pvt->csels[0].b_cnt = 8;
> +		pvt->csels[1].b_cnt = 8;
> +
> +		pvt->csels[0].m_cnt = 4;
> +		pvt->csels[1].m_cnt = 4;
> +	}
> +}
>  
> -	} else {
> -		pvt->csels[0].b_cnt = pvt->csels[1].b_cnt = 8;
> -		pvt->csels[0].m_cnt = pvt->csels[1].m_cnt = 4;
> +static void f15_m30h_prep_chip_selects(struct amd64_pvt *pvt)
> +{
> +	pvt->csels[0].b_cnt = 4;
> +	pvt->csels[1].b_cnt = 4;
> +
> +	pvt->csels[0].m_cnt = 2;
> +	pvt->csels[1].m_cnt = 2;

Here, above, and below you can keep the single line style when setting
variables to the same value.

> +}
> +
> +static void f17_prep_chip_selects(struct amd64_pvt *pvt)
> +{
> +	int umc;
> +
> +	for_each_umc(umc) {
> +		pvt->csels[umc].b_cnt = 4;
> +		pvt->csels[umc].m_cnt = 2;
>  	}
>  }
>  
> +static void default_prep_chip_selects(struct amd64_pvt *pvt)
> +{
> +	pvt->csels[0].b_cnt = 8;
> +	pvt->csels[1].b_cnt = 8;
> +
> +	pvt->csels[0].m_cnt = 4;
> +	pvt->csels[1].m_cnt = 4;
> +}
> +

This may be a good example of a default (though not "do nothing") function
that can be set and overwritten when needed. That would save the NULL function
pointer check and all the lines where the pointer gets set to this default
function.

>  static void read_umc_base_mask(struct amd64_pvt *pvt)
>  {
>  	u32 umc_base_reg, umc_base_reg_sec;
> @@ -3282,7 +3305,7 @@ static void read_mc_regs(struct amd64_pvt *pvt)
>  	}
>  
>  skip:
> -	prep_chip_selects(pvt);
> +	pvt->ops->prep_chip_selects(pvt);
>  
>  	pvt->ops->get_base_mask(pvt);
>  
> @@ -3761,6 +3784,7 @@ static int per_family_init(struct amd64_pvt *pvt)
>  		pvt->ops->map_sysaddr_to_csrow		= k8_map_sysaddr_to_csrow;
>  		pvt->ops->dbam_to_cs			= k8_dbam_to_chip_select;
>  		pvt->ops->get_base_mask			= read_dct_base_mask;
> +		pvt->ops->prep_chip_selects		= k8_prep_chip_selects;
>  		break;
>  
>  	case 0x10:
> @@ -3771,6 +3795,7 @@ static int per_family_init(struct amd64_pvt *pvt)
>  		pvt->ops->map_sysaddr_to_csrow		= f1x_map_sysaddr_to_csrow;
>  		pvt->ops->dbam_to_cs			= f10_dbam_to_chip_select;
>  		pvt->ops->get_base_mask			= read_dct_base_mask;
> +		pvt->ops->prep_chip_selects		= default_prep_chip_selects;
>  		break;
>  
>  	case 0x15:
> @@ -3779,11 +3804,13 @@ static int per_family_init(struct amd64_pvt *pvt)
>  			pvt->f1_id			= PCI_DEVICE_ID_AMD_15H_M30H_NB_F1;
>  			pvt->f2_id			= PCI_DEVICE_ID_AMD_15H_M30H_NB_F2;
>  			pvt->ops->dbam_to_cs		= f16_dbam_to_chip_select;
> +			pvt->ops->prep_chip_selects	= f15_m30h_prep_chip_selects;
>  		} else if (pvt->model == 0x60) {
>  			pvt->ctl_name			= "F15h_M60h";
>  			pvt->f1_id			= PCI_DEVICE_ID_AMD_15H_M60H_NB_F1;
>  			pvt->f2_id			= PCI_DEVICE_ID_AMD_15H_M60H_NB_F2;
>  			pvt->ops->dbam_to_cs		= f15_m60h_dbam_to_chip_select;
> +			pvt->ops->prep_chip_selects	= default_prep_chip_selects;
>  		} else if (pvt->model == 0x13) {
>  		/* Richland is only client */
>  			return -ENODEV;
> @@ -3812,6 +3839,7 @@ static int per_family_init(struct amd64_pvt *pvt)
>  		pvt->ops->map_sysaddr_to_csrow		= f1x_map_sysaddr_to_csrow;
>  		pvt->ops->dbam_to_cs			= f16_dbam_to_chip_select;
>  		pvt->ops->get_base_mask			= read_dct_base_mask;
> +		pvt->ops->prep_chip_selects		= default_prep_chip_selects;
>  		break;
>  
>  	case 0x17:
> @@ -3842,6 +3870,7 @@ static int per_family_init(struct amd64_pvt *pvt)
>  		pvt->ops->early_channel_count		= f17_early_channel_count;
>  		pvt->ops->dbam_to_cs			= f17_addr_mask_to_cs_size;
>  		pvt->ops->get_base_mask			= read_umc_base_mask;
> +		pvt->ops->prep_chip_selects		= f17_prep_chip_selects;
>  
>  		if (pvt->fam == 0x18) {
>  			pvt->ctl_name			= "F18h";
> @@ -3878,6 +3907,7 @@ static int per_family_init(struct amd64_pvt *pvt)
>  		pvt->ops->early_channel_count		= f17_early_channel_count;
>  		pvt->ops->dbam_to_cs			= f17_addr_mask_to_cs_size;
>  		pvt->ops->get_base_mask			= read_umc_base_mask;
> +		pvt->ops->prep_chip_selects		= f17_prep_chip_selects;
>  		break;
>  

I expect that all the Zen-based CPU ops will be the same. Also, I figure that
Zen-based CPUs are likely the majority of AMD-based systems in use today, or
at least those that will use updated kernel versions. So I think that the
Zen-based CPU ops should be the default. GPU and legacy CPU ops can be set
as needed during init time.

Thanks,
Yazen 
