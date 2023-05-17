Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04EB706A91
	for <lists+linux-edac@lfdr.de>; Wed, 17 May 2023 16:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjEQOJU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 17 May 2023 10:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjEQOJT (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 17 May 2023 10:09:19 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7F53AB1;
        Wed, 17 May 2023 07:09:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RFkzzfwuHkQGiSiw9p4IIJHoBQbwDfvUXOiQBLedQdRDKDkPRzWYVUSlBuCM3NtjmPJ0Bzul6t1OrvmHI99aji8Ny4Xy36T6Y7InGYUC7QAJ/wRvDuOYURjvMBWx9MisRes4sCGzL1XadklxLL3g/lX2VVR6NvPNUCH/PXPRr13doxCw1Q/H7HgGtYboCry8DN76gYuvlc3wSMPFO/GbO/sqOFyYuGpl2oeIc1lRXUQPcl6vvLZ41maFmic/nVWpPuGW0ydQSHOs439jBwwP2bcKIhp8Z2j3eRHV2jg+SClo0wyZ2qJFoNUPF61pci8ffgn/4+FRS7jMnKVSY4koLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iamWA37xaodKAzWMQzDRynUOJyCfLC8p5VRPzqF8P+M=;
 b=X2a4WA3Pz+3+spf9Uf4eivRtEx9/oxWmOIZGG9LYOaQk58Ck7P0us4vdjN6ImsnTQHqP5f1/KEuPc8f39W1Hhu3pO/17fZDPVpnK5aayqM/G9uhVWaRXnjzCrpnbDAlJ7dDHz0nwTI4ius7okDXvNjsQSklBa5ghTZEzTLcbvcxvP6JG1Iky/5oY/Dx9BtM9hWWLwYp3WjeA7pmCfA409Ay8/oxY5asO2bG5nF1XmDhMEgMHu7GODsRgN6LNJ4ohS381FMNHhAp4wLpSvasyYebwBC4Jd8jw2PntFCi1BcUe9QnhjmBjICmQfIsTb0xLJfS1CtLdFhZ88UG56C0DCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iamWA37xaodKAzWMQzDRynUOJyCfLC8p5VRPzqF8P+M=;
 b=m2IL/QXptfJls/xNiAYKI252m05FWPDY+cq+KKi3qOzRnym8l8+g+mvDhwLpLCzU9HnMeBaNYFxnPdxYrF+LjGg3hQ9R1p7wQyZTznMdX/E0BJZN/5Ezrs4gX0ssY6+kklzaVpWjBBgFkzLswA7TNSf7OpwoYHxLkjrWgg6knZs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by SJ0PR12MB5486.namprd12.prod.outlook.com (2603:10b6:a03:3bb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 14:09:15 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::9798:caa4:43e1:b93f]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::9798:caa4:43e1:b93f%4]) with mapi id 15.20.6387.032; Wed, 17 May 2023
 14:09:15 +0000
Message-ID: <485dbd08-7616-09e3-c9eb-de0a1f78572b@amd.com>
Date:   Wed, 17 May 2023 10:09:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc:     yazen.ghannam@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        markgross@kernel.org, hdegoede@redhat.com,
        Shyam-sundar.S-k@amd.com, linux-edac@vger.kernel.org,
        clemens@ladisch.de, jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        mario.limonciello@amd.com, babu.moger@amd.com
Subject: Re: [PATCH 5/6] hwmon: (k10temp) Define helper function to read CCD
 temp
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>
References: <20230516202430.4157216-1-yazen.ghannam@amd.com>
 <20230516202430.4157216-6-yazen.ghannam@amd.com>
 <f61f548b-0007-404e-9c9d-d84a2a657983@roeck-us.net>
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <f61f548b-0007-404e-9c9d-d84a2a657983@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0947.namprd03.prod.outlook.com
 (2603:10b6:408:108::22) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|SJ0PR12MB5486:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cceadff-0a8a-4a6f-34ef-08db56e04bea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PKVR2vmOx/GNnfc4uCOa0GFh8n+Q1rktdBThuviyv1doFVeffQnB5Qo4Baa5KDU3EaW2U7oJpw/45oGuolIAmo6F4NiUQhbZUBVrMjz6//izH24qnTVkugesx8IpKJVAkN8KGvMP8Zkb/bo63ulnI0mz0ZTMvgSJm1Zh9lJw+0OZZnTRCJ3fWs+8741Tb5v1kpCJgyiZhLLgvorFSo4gPXarqopK0QspDRiCW47+k4QX41UjpS+5cOvGI+FpR7bRoYZwClTo1zk2KFSGnJqD5l6bza8gfvOqhS7Q5cKb62rTiJa5rbJ7J0ik4ZOW1NS+Aqbm8aNgRSBaYMmBKB4Fb2f93TNhC9sNHFKi/ynQCnGgGGMui2QYbcDnbmOkJviPMC4phDbK13zcfTBPMbpLs394XLUBCVfYkE3ZbcQ/y6gX59VwfJ633G/hqpDasy0d480BAlJKq4ZOo9KDjtghrLrEEPpo3zBMwSHYOmFe+5pgMb+KNnZh6r4yhXed5SUtiS9goxbj3WFJu0g3flmDQr+1qnjQ4/pOcXF9AAIMX8VnQe+shVV11EmLRsl6WnIGRCpP8yH3YWWulQzt7sYzzZXs8BejnNQihbi89dUUiOwVHRAmGpXM/Q8vitFVRg7G2JLT3RewH0RuEEOeF1x2wA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(366004)(376002)(346002)(451199021)(5660300002)(41300700001)(2906002)(36756003)(83380400001)(2616005)(86362001)(31696002)(38100700002)(26005)(186003)(6512007)(6506007)(44832011)(7416002)(8676002)(8936002)(53546011)(66556008)(66476007)(31686004)(66946007)(478600001)(6666004)(6486002)(316002)(4326008)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXlmRUp0OEVObFM3cFlDMGkyRmVlRU5IU2UvOEZRUkQ2TGJ1eXJxZWszVjJV?=
 =?utf-8?B?VTQ2b0xXMXJMN2U4NEJoRm9QcGRBME9PTmdGVkdiNCt6NzBVYk9nL0IzMEg1?=
 =?utf-8?B?K2RwekhUMXlZS2E1c3huTnl4a1YvSytQSllKSkw1K2c0VkhaMFFFSHR5MkZI?=
 =?utf-8?B?dGtBN2JtWXBLVGZyU3RPQW1zbXJ1bXNKcG9EZnRqUEJrLzVpZUFyUDFzS0Q0?=
 =?utf-8?B?bEJzRXc2UWhTWE4xekNYUWtSMGQ3UWdqYVVYVlFQUDNySXpNdU9pSkNSYnFB?=
 =?utf-8?B?STJyZy8rWFVPbnpBRFk3VmxMcmI4WjhETHVxazVOaE80akJHSUtkN0Z5ZzRp?=
 =?utf-8?B?bDRNczIxeklEU0dvSnlvT1EzNmlUdU5zS0pvdVIxbHBzMFliUXVrTVc2S2Q4?=
 =?utf-8?B?bGxQSWFHNXppNTkxc2trVGxnbEJUcy9FMzZWNmZmNTlaTlhsWHg2SjFTNE5R?=
 =?utf-8?B?bCt5OXJNWlBFbmgwNUFZeDhtUkNNeFVTR3VXZDlzcVlZbW9xakF5WkV4UkJ1?=
 =?utf-8?B?RTM1eWhnNUk0d3pWekxkY3JCTUVLRENDNHZpdmVPNTNEbmhGeDViYzRTdGw5?=
 =?utf-8?B?T0FaQkRsbUZVbGFxN1ZYT1VTVy9hd1pSS21xeUcxNWhxYzg5NlVJeENFMEUv?=
 =?utf-8?B?b0thdTRGUzdMVjhSd2cyQm1hRG9RSWk2RlVZanlxTnZOYkdlNzdtYVQ3NFhG?=
 =?utf-8?B?SHJZR1BRM2NCZU16djh0Zng1ektWRFZVVkFqSkZ2T0wyMnFpeXhhRnVDcG5i?=
 =?utf-8?B?ekRPLzFRRFhpMWd4N3hsTDlXc05XTEFibnRNK2IxWG90d2R3V1ZwQVFSbkRh?=
 =?utf-8?B?UHV4Yy92WHhwb2kvMHJxWGo5V2ZYUFBzSURCdjZOS2xkVUVvUURJQ1l4RHdX?=
 =?utf-8?B?eVc3QmdHWCtEVTRuVTBHWXBjU2thZS9CTG9xaXBhOXhtWHBYVWs2cUtHWXdv?=
 =?utf-8?B?WlpsRVZsU01aeStBclZxYkNKVFZ0RDVxRUZSOHVUTWROVWI5SEFOL1Z3R1FZ?=
 =?utf-8?B?RlRzR0hpQUxZckloUlkrSnY5bWgwUjNnUERYTU9PTGlNYkxFaFJFNzlIK04w?=
 =?utf-8?B?RE5jZE0rY21tbWphRjVYWDJlM216aFpNSXBrL3c3VG5FZlZJNE9WQmJTSHV1?=
 =?utf-8?B?bVY1YjBHWDgxMlBGa2hMLy9pQnhjZ3FZZ1h0WlVuZEx5dDNpVGNERzlrRFpP?=
 =?utf-8?B?a3FINFoyNTRqN2JLSnJNNDhzcEM2MEw1MUpnV29qTDQwS2R5VUNYaGxMN1NQ?=
 =?utf-8?B?UnludHBsL0Z0cGJCQW1mSStQVlhGM0dYVGdtejNNV0tIK0JYRWJ1aHgrOGFr?=
 =?utf-8?B?MjF6YUlIZ0llNjRrNWRwVW94alMwZWFUc0xZQVRDVlIyZzBLV0kxWUljQU9Y?=
 =?utf-8?B?WkpJMjFCQXRHczV1ZmNFaHpiNkhRUUxtTXFpTzhpc1ZJZkFsQTk5clBiQjMy?=
 =?utf-8?B?TXpxaEQ0UlpVWGNyRDZwYmxscDZ4Zlo1N085Vm1zQ1ZTTnhCRVR1MHhmQUQr?=
 =?utf-8?B?a2dsbkF1R0tFZVNDa05lQzUxRXNEc1RnWlozdWYrSVRJV2xwZVZDT0Q4QzJX?=
 =?utf-8?B?RlY2N011VTJBbC9XWExHL0NoVE1DUEplZXhycEhHbzRJR0NmdlJDZkZFTkQ0?=
 =?utf-8?B?RDNFSkNHMkl3Q1k1VE5CVFZQQTI0UithSk9qbm1wR1h6bC9zVDVDNDFEMkdE?=
 =?utf-8?B?T2xwVzByVlVzVGw1K3hQcWZvRkQ1bXI0dUkwcktUakxDSFBhcXRHMGlGRzMr?=
 =?utf-8?B?MUY2K3JQWXNLcnZVK1dQcE1rSDlZU0FxSUh0WnBEbEJIamxhTHBGREVlSmRo?=
 =?utf-8?B?SVczK1RwYi9iclpEbDRhT3J2ZmNLN3E1QnZlaEVtWFUvZVJMbXl1VTcxZWhQ?=
 =?utf-8?B?cFdSQ3dKUkVWNityTGRjRFhJeXVxRlQwajFseWtsbkFJQWs0RjEwSXk1QmdL?=
 =?utf-8?B?VXBSQUY5b3FLNXlkeC83S0VSYVdKSSt5ZGUyclhMS1p1NHN0cTBEUXdQSDVD?=
 =?utf-8?B?d2xZS3g4WGRaSXM0MXNJd0w3RDI4N3J0RjFYTkc4TkdsaEJIWUVOQUNBd3Fx?=
 =?utf-8?B?dmdBZGp0cXhBd0FacWxjd2lKOTdVSTk0YnBZcTIzc2pxb245djFycjd1cDRR?=
 =?utf-8?Q?OXEFWl9jaN9gkos3Kkx9L06uG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cceadff-0a8a-4a6f-34ef-08db56e04bea
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 14:09:15.1249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IprkmYf3drcjTY9rgmXY2bO6UMzBo7nr+AFGZcspTFbMrlg9RvOTJsiXaP+NOWSaERfkeOX2EsL8+b2ExAKmoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5486
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 5/17/23 8:30 AM, Guenter Roeck wrote:
> On Tue, May 16, 2023 at 03:24:29PM -0500, Yazen Ghannam wrote:
>> The CCD temperature register is read in two places. These reads are done
>> using an AMD SMN access, and a number of parameters are needed for the
>> operation.
>>
>> Move the SMN access and parameter gathering into a helper function in
>> order to simply the code flow. This also has a benefit of centralizing
>> the hardware register access in a single place in case fixes or special
>> decoding is required.
>>
>> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
>> ---
>>  drivers/hwmon/k10temp.c | 19 ++++++++++++++-----
>>  1 file changed, 14 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
>> index 6ea1fa62b7c1..06af1fe38af7 100644
>> --- a/drivers/hwmon/k10temp.c
>> +++ b/drivers/hwmon/k10temp.c
>> @@ -150,6 +150,18 @@ static void read_tempreg_nb_zen(struct pci_dev *pdev, u32 *regval)
>>  		*regval = 0;
>>  }
>>  
>> +static int read_ccd_temp_reg(struct k10temp_data *data, int ccd, u32 *regval)
>> +{
>> +	u16 node_id = amd_pci_dev_to_node_id(data->pdev);
>> +	u32 tmp;
>> +
>> +	if (amd_smn_read(node_id, ZEN_CCD_TEMP(data->ccd_offset, ccd), &tmp))
>> +		return -EINVAL;
> 
> As mentioned before, this is not appropriate. The error code
> from amd_smn_read() should be returned.
>

Okay, will do.

>> +
>> +	*regval = tmp;
> 
> This seems pointless. Why not just pass regval as parameter
> to amd_smn_read() ?
> 
> This function should be reduced to
> 
> 	return amd_smn_read(node_id, ZEN_CCD_TEMP(data->ccd_offset, ccd), regval));
> 

Yes, will do. I think I got carried away with the "don't save invalid
value" idea. But this isn't necessary if the caller checks the return
code and avoids using the value.

>> +	return 0;
>> +}
>> +
>>  static long get_raw_temp(struct k10temp_data *data)
>>  {
>>  	u32 regval;
>> @@ -214,9 +226,7 @@ static int k10temp_read_temp(struct device *dev, u32 attr, int channel,
>>  				*val = 0;
>>  			break;
>>  		case 2 ... 13:		/* Tccd{1-12} */
>> -			if (amd_smn_read(amd_pci_dev_to_node_id(data->pdev),
>> -					 ZEN_CCD_TEMP(data->ccd_offset, channel - 2),
>> -					 &regval))
>> +			if (read_ccd_temp_reg(data, channel - 2, &regval))
>>  				return -EINVAL;
> 
> Now this is really wrong, no matter what. Why bother replacing the
> error code in read_ccd_temp_reg() only to replace it again ?
>

Understood. Will fix like the other places.

Thanks,
Yazen
